import jwt from "jsonwebtoken";

import type { Request, Response, NextFunction } from "express";
import prisma from "../lib/prisma.ts";

export const protectRoute = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const token = req.get("x-auth-token");
    if (!token) {
      return res
        .status(401)
        .json({ message: "Tidak Diizinkan - Token Tidak Ditemukan!" });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET!);
    if (
      !decoded ||
      typeof decoded !== "object" ||
      !("userId" in decoded) ||
      !("role" in decoded)
    ) {
      return res
        .status(401)
        .json({ message: "Tidak Diizinkan - Token Tidak Valid!" });
    }

    switch (decoded.role) {
      case "ORANG_TUA":
        const orangTua = await prisma.orangTua.findUnique({
          where: { id: decoded.userId },
        });
        if (!orangTua) {
          return res
            .status(401)
            .json({ message: "Tidak Diizinkan - Pengguna Tidak Ditemukan!" });
        }
        req.orangTua = orangTua;
        next();
      case "PETUGAS_POSYANDU":
        const posyandu = await prisma.posyandu.findUnique({
          where: { id: decoded.userId },
        });
        if (!posyandu) {
          return res
            .status(401)
            .json({ message: "Tidak Diizinkan - Pengguna Tidak Ditemukan!" });
        }
        req.posyandu = posyandu;
        next();
      default:
        return res
          .status(401)
          .json({ message: "Tidak Diizinkan - Peran Tidak Dikenal!" });
    }
  } catch (error) {
    console.error("Error di protectRoute middleware", error);
    return res.status(500).json({
      message: "Terjadi Kesalahan Pada Server!",
    });
  }
};
