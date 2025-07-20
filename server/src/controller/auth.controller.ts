import bcryptjs from "bcryptjs";
import generateToken from "../lib/jwt.ts";
import prisma from "../lib/prisma.ts";
import type { Request, Response } from "express";
import type { OrangTuaType } from "../types/prisma.ts";
import axios from "axios";

export const kirimOtp = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({ message: "No. HP dan Tujuan Harus Diisi!" });
  }
  const { noHp, tujuan, nik } = req.body;
  try {
    if (!noHp || !tujuan) {
      return res
        .status(400)
        .json({ message: "No. HP dan Tujuan Harus Diisi!" });
    }

    if (tujuan === "UBAH_NO_HP" && !nik) {
      return res
        .status(400)
        .json({ message: "NIK Harus Diisi untuk Mengubah No. HP!" });
    }

    const cekNoHp = await prisma.orangTua.findUnique({
      where: { noHp },
    });

    let cekNik: OrangTuaType | null = null;
    if (tujuan === "UBAH_NO_HP") {
      cekNik = await prisma.orangTua.findUnique({
        where: { nik },
      });
    }

    // Logika pembatasan OTP - maksimal 5 OTP dalam 15 menit
    const sekarang = new Date();
    const batas15Menit = new Date(sekarang.getTime() - 15 * 60 * 1000); // 15 menit yang lalu

    // Cek jumlah OTP yang dikirim dalam 15 menit terakhir
    const jumlahOtpRecent = await prisma.riwayatOtp.count({
      where: {
        noHp, // untuk DAFTAR dan MASUK
        createdAt: {
          gte: batas15Menit,
        },
      },
    });

    if (jumlahOtpRecent >= 5) {
      const sisaWaktu = Math.ceil(
        (batas15Menit.getTime() + 15 * 60 * 1000 - sekarang.getTime()) /
          1000 /
          60
      );
      return res.status(429).json({
        message: `Terlalu banyak permintaan OTP. Silakan tunggu ${sisaWaktu} menit lagi.`,
      });
    }

    if (tujuan !== "DAFTAR" && tujuan !== "MASUK" && tujuan !== "UBAH_NO_HP") {
      return res.status(400).json({
        message: "Gagal Mengirim OTP, Tujuan Tidak Valid!",
      });
    }

    if (tujuan === "MASUK" && !cekNoHp) {
      return res
        .status(400)
        .json({ message: "Gagal Mengirim OTP, Akun Tidak Ditemukan!" });
    }

    if (tujuan === "DAFTAR" || tujuan === "UBAH_NO_HP") {
      if (tujuan === "UBAH_NO_HP" && !cekNik) {
        return res
          .status(400)
          .json({ message: "Gagal Mengirim OTP, Akun Tidak Ditemukan!" });
      }
      if (cekNoHp) {
        return res.status(400).json({
          message: "Gagal Mengirim OTP, No. HP Sudah Terdaftar!",
        });
      }
    } else if (tujuan != "MASUK") {
      return res.status(400).json({
        message: "Gagal Mengirim OTP, Tujuan Tidak Valid!",
      });
    }

    // const response = await axios.post(
    //   "https://api.fazpass.com/v1/otp/generate",
    //   {
    //   phone: noHp,
    //   gateway_key: process.env.GATEWAY_KEY!,
    // },
    //   {
    //     headers: {
    //       Authorization: "Bearer " + process.env.MERCHANT_KEY!,
    //       "Content-Type": "application/json",
    //     },
    //   }
    // );

    // if (response.data.status === true) {
    if (true) {
      const kodeOtp = "9817";
      // const kodeOtp = response.data.data.otp;
      const otpExpiresAt = new Date(Date.now() + 5 * 60 * 1000);

      if (tujuan === "MASUK") {
        await prisma.orangTua.update({
          where: {
            noHp,
          },
          data: {
            kodeOtp,
            otpExpiresAt,
          },
        });
      }

      if (tujuan === "DAFTAR") {
        // Hapus OTP lama jika ada
        await prisma.verifikasiOtp.deleteMany({
          where: { noHp },
        });

        await prisma.verifikasiOtp.create({
          data: {
            noHp,
            kodeOtp,
            otpExpiresAt,
          },
        });
      }

      if (tujuan === "UBAH_NO_HP") {
        await prisma.orangTua.update({
          where: { nik },
          data: {
            noHp,
            kodeOtp,
            otpExpiresAt,
          },
        });
      }

      // Simpan riwayat pengiriman OTP
      await prisma.riwayatOtp.create({
        data: { noHp },
      });

      return res.status(200).json({
        message: "OTP berhasil Dikirim!",
      });
    }
  } catch (error) {
    console.error("Gagal Mengirim OTP, Error di kirimOtp Controller", error);
    return res.status(500).json({
      message:
        "Gagal Mengirim OTP, Terjadi Kesalahan Di Server. Pastikan No. HP Valid!",
    });
  }
};

export const daftar = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({
      message: "Gagal Membuat Akun, No. HP dan Kode OTP Harus Diisi!",
    });
  }
  const { noHp, kodeOtp } = req.body;
  try {
    if (!noHp || !kodeOtp) {
      console.log(req.body);
      return res.status(400).json({
        message: "Gagal Membuat Akun, No. HP dan Kode OTP Harus Diisi! 2",
      });
    }
    const existingUser = await prisma.orangTua.findUnique({
      where: { noHp },
    });

    if (existingUser) {
      return res
        .status(400)
        .json({ message: "Gagal Membuat Akun, No. HP Sudah Terdaftar!" });
    }

    const verifikasiOtp = await prisma.verifikasiOtp.findUnique({
      where: { noHp },
    });

    if (!verifikasiOtp || kodeOtp !== verifikasiOtp?.kodeOtp) {
      return res.status(400).json({
        message: "Gagal Membuat Akun, Kode OTP Tidak Valid!",
      });
    }
    if (verifikasiOtp.otpExpiresAt < new Date()) {
      return res.status(400).json({
        message: "Gagal Membuat Akun, Kode OTP Sudah Kadaluarsa!",
      });
    }

    const userOrangTua = await prisma.orangTua.create({
      data: { noHp },
    });
    const token = generateToken({ userId: userOrangTua.id, role: "ORANG_TUA" });

    await prisma.verifikasiOtp.delete({
      where: { noHp },
    });
    return res.status(201).json({
      message: "Registrasi Berhasil, Silakan Melengkapi Profil Anda",
      userOrangTua: userOrangTua,
      token: token,
    });
  } catch (error) {
    console.error("Error di register controller", error);
    return res.status(500).json({
      message: "Gagal Membuat Akun, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const perbaruiProfil = async (req: Request, res: Response) => {
  const id = req.orangTua.id; // Ambil ID dari request yang sudah di-protect
  if (!req.body) {
    return res.status(400).json({
      message: "Gagal Memperbarui Profil, Semua Field Harus Diisi!",
    });
  }
  console.log(req.body);
  const { nama, nik, jenisKelamin, alamat, posyanduId } = req.body;
  try {
    if (!nama || !nik || !jenisKelamin || !alamat || !posyanduId) {
      return res.status(400).json({
        message: "Gagal Memperbarui Profil, Semua Field Harus Diisi!",
      });
    }

    if (!["LAKI_LAKI", "PEREMPUAN"].includes(jenisKelamin)) {
      return res.status(400).json({
        message: "Gagal Memperbarui Profil, Jenis Kelamin Tidak Valid!",
      });
    }

    // Cek apakah user exists
    const existingUser = await prisma.orangTua.findUnique({
      where: { id: id }, // Pastikan ID adalah integer
    });

    if (!existingUser) {
      return res.status(404).json({
        message: "Gagal Memperbarui Profil, Akun Tidak Ditemukan!",
      });
    }

    // Cek NIK duplikat (kecuali NIK user sendiri)
    const cekNik = await prisma.orangTua.findFirst({
      where: {
        nik,
        NOT: { id: id }, // Exclude current user
      },
    });

    if (cekNik) {
      return res.status(400).json({
        message: "Gagal Memperbarui Profil, NIK Sudah Terdaftar!",
      });
    }

    // Cek apakah posyandu exists
    const existingPosyandu = await prisma.posyandu.findUnique({
      where: { id: parseInt(posyanduId) },
    });

    if (!existingPosyandu) {
      return res.status(404).json({
        message: "Gagal Memperbarui Profil, Posyandu Tidak Ditemukan!",
      });
    }

    const userOrangTua = await prisma.orangTua.update({
      where: { id: id }, // Pastikan ID adalah integer
      data: {
        nama,
        nik,
        jenisKelamin,
        alamat,
        posyandu: { connect: { id: parseInt(posyanduId) } },
      },
      omit: {
        kodeOtp: true,
        otpExpiresAt: true,
      },
    });

    return res.status(200).json({
      message: "Profil Berhasil Diperbarui",
      userOrangTua: userOrangTua,
    });
  } catch (error) {
    console.error(
      "Gagal Memperbarui Profil, Error di lengkapiProfil Controller",
      error
    );
    return res.status(500).json({
      message: "Gagal Memperbarui Profil, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const ubahNoHp = async (req: Request, res: Response) => {
  if (!req.body) {
    return res
      .status(400)
      .json({ message: "Gagal Mengubah No. HP, Semua Field Harus Diisi!" });
  }
  const { id, noHpBaru, kodeOtp } = req.body;
  try {
    if (!id || !noHpBaru || !kodeOtp) {
      return res
        .status(400)
        .json({ message: "Gagal Mengubah No. Semua Field Harus Diisi!" });
    }

    const existingUser = await prisma.orangTua.findUnique({
      where: { noHp: noHpBaru },
    });

    if (existingUser) {
      return res
        .status(400)
        .json({ message: "Gagal Mengubah No. HP, No. HP Sudah Terdaftar!" });
    }

    const userOrangTua = await prisma.orangTua.findUnique({
      where: { id },
    });

    if (
      !userOrangTua ||
      kodeOtp !== userOrangTua?.kodeOtp ||
      !userOrangTua.otpExpiresAt
    ) {
      return res.status(400).json({
        message: "Gagal Mengubah No. HP, Kode OTP Tidak Valid!",
      });
    }

    if (userOrangTua.otpExpiresAt < new Date()) {
      return res.status(400).json({
        message: "Gagal Mengubah No. HP, Kode OTP Sudah Kadaluarsa!",
      });
    }
    const orangTuaNew = await prisma.orangTua.update({
      where: { id },
      data: {
        noHp: noHpBaru,
      },
      omit: {
        kodeOtp: true,
        otpExpiresAt: true,
      },
    });

    if (!orangTuaNew) {
      return res.status(404).json({
        message: "Gagal Mengubah No. HP, Akun Tidak Ditemukan!",
      });
    }
    return res.status(200).json({
      message: "No. HP Berhasil Diperbarui",
      userOrangTua: orangTuaNew,
    });
  } catch (error) {
    console.error("Gagal Mengubah No. HP, Error di ubahNoHp Controller", error);
    return res.status(500).json({
      message: "Gagal Mengubah No. HP, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const masuk = async (req: Request, res: Response) => {
  if (!req.body) {
    return res
      .status(400)
      .json({ message: "No. HP dan Kode OTP Harus Diisi!" });
  }
  const { noHp, kodeOtp } = req.body;
  try {
    if (!noHp) {
      return res
        .status(400)
        .json({ message: "No. HP dan Kode OTP Harus Diisi!" });
    }

    const userOrangTua = await prisma.orangTua.findUnique({
      where: { noHp },
    });

    if (!userOrangTua) {
      return res.status(404).json({ message: "Akun Tidak Ditemukan!" });
    }

    if (
      !userOrangTua ||
      kodeOtp !== userOrangTua.kodeOtp ||
      !userOrangTua.otpExpiresAt
    ) {
      return res.status(400).json({
        message: "Gagal Masuk, Kode OTP Tidak Valid!",
      });
    }

    if (userOrangTua.otpExpiresAt < new Date()) {
      return res.status(400).json({
        message: "Gagal Masuk, Kode OTP Sudah Kadaluarsa!",
      });
    }

    userOrangTua.kodeOtp = null; // Clear OTP after successful login
    userOrangTua.otpExpiresAt = null; // Clear OTP expiration after successful

    const token = generateToken({ userId: userOrangTua.id, role: "ORANG_TUA" });
    return res.status(200).json({
      message: "Berhasil Masuk, Selamat Datang!",
      userOrangTua: userOrangTua,
      token: token,
    });
  } catch (error) {
    console.error("Error di masuk controller", error);
    return res.status(500).json({
      message: "Gagal Login, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const masukPosyandu = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({
      message: "Kode Posyandu dan Password Harus Diisi!",
    });
  }
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
      userPosyandu: posyanduTanpaPassword,
      token: token,
    });
  } catch (error) {
    console.error("Error di masukPosyandu controller", error);
    return res.status(500).json({
      message: "Gagal Login Posyandu, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const checkAuth = (req: Request, res: Response) => {
  try {
    if (req.orangTua) {
      return res.status(200).json({
        message: "Token Valid.",
        userOrangTua: req.orangTua,
      });
    }
    if (req.posyandu) {
      return res.status(200).json({
        message: "Token Valid.",
        userPosyandu: req.posyandu,
      });
    }
    return res.status(401).json({ message: "Gagal Mengecek Otorisasi!" });
  } catch (error) {
    console.error("Error in checkAuth controller", error);
    res.status(500).json({
      message: "Gagal Mengecek Otorisasi, Terjadi Kesalahan Pada Server!",
    });
  }
};
