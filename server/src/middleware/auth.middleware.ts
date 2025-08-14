import jwt from "jsonwebtoken";

import type { Request, Response, NextFunction } from "express";
import prisma from "../lib/prisma.ts";

export const protectRoute = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  6;
  try {
    const token = req.get("x-auth-token");
    if (!token) {
      return res.status(401).json({ message: "TOKEN_TIDAK_DITEMUKAN" });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET!);
    if (
      !decoded ||
      typeof decoded !== "object" ||
      !("userId" in decoded) ||
      !("role" in decoded)
    ) {
      return res.status(401).json({ message: "TOKEN_TIDAK_VALID" });
    }

    switch (decoded.role) {
      case "ORANG_TUA":
        const orangTua = await prisma.orangTua.findUnique({
          where: { id: decoded.userId },
        });
        if (!orangTua) {
          return res.status(401).json({ message: "PENGGUNA_TIDAK_DITEMUKAN" });
        }
        req.orangTua = orangTua;
        return next();

      case "KADER_POSYANDU":
        const posyandu = await prisma.posyandu.findUnique({
          where: { id: decoded.userId },
        });
        if (!posyandu) {
          return res.status(401).json({ message: "PENGGUNA_TIDAK_DITEMUKAN" });
        }
        req.posyandu = posyandu;
        return next();

      default:
        return res.status(401).json({ message: "PERAN_TIDAK_DIKENAL" });
    }
  } catch (error) {
    console.error("Error di protectRoute middleware", error);
    return res.status(500).json({
      message: "INTERNAL_ERROR",
    });
  }
};
