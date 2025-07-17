import bcryptjs from "bcryptjs";
import generateToken from "../lib/jwt.ts";
import prisma from "../lib/prisma.ts";
import { type Request, type Response } from "express";

export const register = async (req: Request, res: Response) => {
  const { noHp } = req.body;
  try {
    if (!noHp) {
      return res
        .status(400)
        .json({ error: "Gagal Membuat Akun, No. HP Harus Diisi!" });
    }
    const existingUser = await prisma.orangTua.findUnique({
      where: { noHp },
    });

    if (existingUser) {
      return res
        .status(400)
        .json({ message: "Gagal Membuat Akun, No. HP Sudah Terdaftar!" });
    }

    const orangTua = await prisma.orangTua.create({
      data: { noHp },
    });
    const token = generateToken({ userId: orangTua.id, role: "ORANG_TUA" });
    return res.status(201).json({
      message: "Registrasi Berhasil, Silakan Melengkapi Profil Anda",
      orangTua: orangTua,
      token: token,
    });
  } catch (error) {
    console.error("Error di register controller", error);
    return res.status(500).json({
      message: "Gagal Membuat Akun, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const completeProfile = async (req: Request, res: Response) => {
  const { id, nama, nik, jenisKelamin, alamat, posyanduId } = req.body;
  try {
    if (!id || !nama || !nik || !jenisKelamin || !alamat || !posyanduId) {
      return res.status(400).json({
        message: "Gagal Melengkapi Profil, Semua Field Harus Diisi!",
      });
    }

    const orangTua = await prisma.orangTua.update({
      where: { id },
      data: {
        nama,
        nik,
        jenisKelamin,
        alamat,
        posyandu: { connect: { id: posyanduId } },
      },
    });
    return res.status(200).json({
      message: "Profil Berhasil Dilengkapi",
      orangTua: orangTua,
    });
  } catch (error) {
    console.error(
      "Gagal Melengkapi Profil, Error di completeProfile Controller",
      error
    );
    return res.status(500).json({
      message: "Gagal Melengkapi Profil, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const login = async (req: Request, res: Response) => {
  const { noHp } = req.body;
  try {
    if (!noHp) {
      return res.status(400).json({ error: "No. HP Harus Diisi!" });
    }

    const orangTua = await prisma.orangTua.findUnique({
      where: { noHp },
    });

    if (!orangTua) {
      return res.status(404).json({ message: "Akun Tidak Ditemukan!" });
    }

    const token = generateToken({ userId: orangTua.id, role: "ORANG_TUA" });
    return res.status(200).json({
      message: "Berhasil Masuk, Selamat Datang!",
      orangTua: orangTua,
      token: token,
    });
  } catch (error) {
    console.error("Error di login controller", error);
    return res.status(500).json({
      message: "Gagal Login, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const loginPosyandu = async (req: Request, res: Response) => {
  const { kodePosyandu, password } = req.body;
  try {
    if (!kodePosyandu || !password) {
      return res.status(400).json({
        message: "Kode Posyandu dan Password Harus Diisi!",
      });
    }

    const posyandu = await prisma.posyandu.findUnique({
      where: { kodePosyandu },
    });

    if (!posyandu) {
      return res
        .status(404)
        .json({ message: "Gagal Masuk, Kode Posyandu Tidak Valid!" });
    }

    const { password: userPassword, ...posyanduTanpaPassword } = posyandu;
    const isPasswordCorrect = await bcryptjs.compare(password, userPassword);

    if (!isPasswordCorrect) {
      return res
        .status(400)
        .json({ message: "Gagal Masuk, Password Tidak Valid!" });
    }
    const token = generateToken({
      userId: posyanduTanpaPassword.id,
      role: "PETUGAS_POSYANDU",
    });
    return res.status(200).json({
      message: "Berhasil Masuk Ke Akun Posyandu, Selamat Datang!",
      posyandu: posyanduTanpaPassword,
      token: token,
    });
  } catch (error) {
    console.error("Error di loginPosyandu controller", error);
    return res.status(500).json({
      message: "Gagal Login Posyandu, Terjadi Kesalahan Pada Server!",
    });
  }
};
