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

    if (tujuan === "AJUKAN_UBAH_NO_HP" && !nik) {
      return res
        .status(400)
        .json({ message: "NIK Harus Diisi untuk Mengubah No. HP!" });
    }

    const cekNoHp = await prisma.orangTua.findUnique({
      where: { noHp },
    });

    let cekNik: OrangTuaType | null = null;
    if (tujuan === "AJUKAN_UBAH_NO_HP") {
      cekNik = await prisma.orangTua.findUnique({
        where: { nik },
      });
      const cekVerifikasiAkun = await prisma.verifikasiAkun.findUnique({
        where: { nik: nik },
        select: {
          noHpBaru: true,
          posyandu: { select: { namaPosyandu: true } },
        },
      });
      if (cekVerifikasiAkun) {
        return res.status(400).json({
          message: "Pengajuan Ubah No. HP Sudah Diajukan!",
          noHpBaru: cekVerifikasiAkun.noHpBaru,
          posyandu: cekVerifikasiAkun.posyandu.namaPosyandu,
        });
      }
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

    if (
      tujuan !== "DAFTAR" &&
      tujuan !== "MASUK" &&
      tujuan !== "AJUKAN_UBAH_NO_HP"
    ) {
      return res.status(400).json({
        message: "Gagal Mengirim OTP, Tujuan Tidak Valid!",
      });
    }

    if (tujuan === "MASUK" && !cekNoHp) {
      return res
        .status(400)
        .json({ message: "Gagal Mengirim OTP, Akun Tidak Ditemukan!" });
    }

    if (tujuan === "DAFTAR" || tujuan === "AJUKAN_UBAH_NO_HP") {
      if (tujuan === "AJUKAN_UBAH_NO_HP" && !cekNik) {
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

      if (tujuan === "DAFTAR" || tujuan === "AJUKAN_UBAH_NO_HP") {
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

      // Simpan riwayat pengiriman OTP
      await prisma.riwayatOtp.create({
        data: { noHp },
      });

      return res.status(200).json({
        message: "OTP berhasil Dikirim",
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
        noHpBaru: cekNik.noHp,
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

export const hapusAkun = async (req: Request, res: Response) => {
  const { id } = req.orangTua; // Ambil ID dari request yang sudah di-protect
  try {
    // Cek apakah user exists
    const existingUser = await prisma.orangTua.findUnique({
      where: { id: id }, // Pastikan ID adalah integer
    });

    if (!existingUser) {
      return res.status(404).json({
        message: "Gagal Menghapus Akun, Akun Tidak Ditemukan!",
      });
    }

    // Hapus akun
    await prisma.orangTua.delete({
      where: { id: id },
    });

    return res.status(200).json({
      message: "Akun Berhasil Dihapus",
    });
  } catch (error) {
    console.error("Gagal Menghapus Akun, Error di hapusAkun Controller", error);
    return res.status(500).json({
      message: "Gagal Menghapus Akun, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const ubahNoHp = async (req: Request, res: Response) => {
  const id = req.orangTua.id;
  if (!req.body) {
    return res
      .status(400)
      .json({ message: "Gagal Mengubah No. HP, Semua Field Harus Diisi!" });
  }
  const { noHpBaru, kodeOtp } = req.body;
  try {
    if (!noHpBaru || !kodeOtp) {
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
    if (!userOrangTua) {
      return res.status(404).json({
        message: "Gagal Mengubah No. HP, Akun Tidak Ditemukan!",
      });
    }
    if (kodeOtp !== userOrangTua?.kodeOtp || !userOrangTua.otpExpiresAt) {
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

export const verifikasiOtp = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({
      message: "Gagal Verifikasi OTP, No. HP dan Kode OTP Harus Diisi!",
    });
  }

  const { noHp, kodeOtp } = req.body;
  try {
    if (!noHp || !kodeOtp) {
      return res.status(400).json({
        message: "Gagal Verifikasi OTP, No. HP dan Kode OTP Harus Diisi!",
      });
    }

    const verifikasiOtp = await prisma.verifikasiOtp.findUnique({
      where: { noHp },
    });

    if (!verifikasiOtp || kodeOtp !== verifikasiOtp?.kodeOtp) {
      return res.status(400).json({
        message: "Gagal Memverifikasi OTP, Kode OTP Tidak Valid!",
      });
    }
    if (verifikasiOtp.otpExpiresAt < new Date()) {
      return res.status(400).json({
        message: "Gagal Memverifikasi OTP, Kode OTP Sudah Kadaluarsa!",
      });
    }

    return res.status(200).json({
      message: "Verifikasi OTP Berhasil",
    });
  } catch (error) {
    console.error("Gagal Mengubah No. HP, Error di ubahNoHp Controller", error);
    return res.status(500).json({
      message: "Gagal Mengubah No. HP, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const ajukanUbahNoHp = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({
      message: "Gagal Mengajukan Ubah No. HP, Semua Field Harus Diisi!",
    });
  }
  const { noHpBaru, kodeOtp, nik, posyanduId } = req.body;
  try {
    if (!noHpBaru || !kodeOtp || !nik || !posyanduId) {
      return res.status(400).json({
        message: "Gagal Mengajukan Ubah No. Semua Field Harus Diisi!",
      });
    }

    const verifikasiOtp = await prisma.verifikasiOtp.findUnique({
      where: { noHp: noHpBaru },
    });

    if (!verifikasiOtp || kodeOtp !== verifikasiOtp?.kodeOtp) {
      return res.status(400).json({
        message: "Gagal Memverifikasi OTP, Kode OTP Tidak Valid!",
      });
    }
    if (verifikasiOtp.otpExpiresAt < new Date()) {
      return res.status(400).json({
        message: "Gagal Memverifikasi OTP, Kode OTP Sudah Kadaluarsa!",
      });
    }

    if (!verifikasiOtp || kodeOtp !== verifikasiOtp?.kodeOtp) {
      return res.status(400).json({
        message: "Gagal Memverifikasi OTP, Kode OTP Tidak Valid!",
      });
    }
    if (verifikasiOtp.otpExpiresAt < new Date()) {
      return res.status(400).json({
        message: "Gagal Memverifikasi OTP, Kode OTP Sudah Kadaluarsa!",
      });
    }

    const cekPengajuanUbahNoHp = await prisma.verifikasiAkun.findUnique({
      where: { nik: nik },
      select: {
        noHpBaru: true,
        posyandu: { select: { namaPosyandu: true } },
      },
    });

    if (cekPengajuanUbahNoHp) {
      return res.status(400).json({
        message: "Pengajuan Ubah No. HP Sudah Diajukan!",
        noHpBaru: cekPengajuanUbahNoHp.noHpBaru,
        posyandu: cekPengajuanUbahNoHp.posyandu.namaPosyandu,
      });
    }

    const cekPosyandu = await prisma.posyandu.findUnique({
      where: { id: posyanduId },
    });

    if (!cekPosyandu) {
      return res.status(404).json({
        message: "Gagal Mengajukan Ubah No. HP, Posyandu Tidak Ditemukan!",
      });
    }

    const userOrangTua = await prisma.orangTua.findUnique({
      where: { nik },
    });
    if (!userOrangTua) {
      return res.status(404).json({
        message: "Gagal Mengajukan Ubah No. HP, Akun Tidak Ditemukan!",
      });
    }

    const verifikasiAkun = await prisma.verifikasiAkun.create({
      data: {
        noHpBaru: noHpBaru,
        orangTua: { connect: { nik: nik } },
        posyandu: { connect: { id: posyanduId } },
      },
    });

    if (!verifikasiAkun) {
      return res
        .status(400)
        .json({ message: "Gagal Mengajukan Ubah No. HP, Silakan Coba Lagi!" });
    }

    await prisma.verifikasiOtp.delete({
      where: { noHp: noHpBaru },
    });

    return res.status(200).json({
      message:
        "Pengajuan Ubah No. HP Berhasil Diajukan, Silakan Menuju Ke Posyandu Untuk Verifikasi",
    });
  } catch (error) {
    console.error(
      "Gagal Mengubah No. HP, Error di ajukanUbahNoHp Controller",
      error
    );
    return res.status(500).json({
      message: "Gagal Mengubah No. HP, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const batalkanPengajuanUbahNoHp = async (
  req: Request,
  res: Response
) => {
  if (!req.body) {
    return res.status(400).json({
      message: "Gagal Membatalkan Pengajuan Ubah No. HP, NIK Harus Diisi!",
    });
  }
  const { nik } = req.body;

  try {
    const cekPengajuanUbahNoHp = await prisma.verifikasiAkun.findUnique({
      where: { nik: nik },
    });
    if (!cekPengajuanUbahNoHp) {
      return res.status(404).json({
        message:
          "Gagal Membatalkan Pengajuan Ubah No. HP, Pengajuan Tidak Ditemukan!",
      });
    }
    await prisma.verifikasiAkun.delete({
      where: { nik: nik },
    });

    return res.status(200).json({
      message: "Pengajuan Ubah No. HP Berhasil Dibatalkan",
    });
  } catch (error) {
    console.error(
      "Gagal Membatalkan Pengajuan No. HP, Error di batalkanPengajuanUbahNoHp Controller",
      error
    );
    return res.status(500).json({
      message:
        "Gagal Membatalkan Pengajuan No. HP, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const cekVerifikasiAkun = async (req: Request, res: Response) => {
  const { id } = req.posyandu;
  try {
    const verifikasiAkun = await prisma.verifikasiAkun.findMany({
      where: { posyanduId: id },
      include: {
        orangTua: true,
      },
    });
    return res.status(200).json({
      message: "Berhasil Mengecek Verifikasi Akun",
      verifikasiAkun: verifikasiAkun,
    });
  } catch (error) {
    console.error(
      "Gagal Mengecek Verifikasi Akun, Error di cekVerifikasiAkun Controller",
      error
    );
    return res.status(500).json({
      message: "Gagal Mengecek Verifikasi Akun, Terjadi Kesalahan Pada Server!",
    });
  }
};

export const verifikasiAkun = async (req: Request, res: Response) => {
  const { id: posyanduId } = req.posyandu;
  if (!req.body) {
    return res.status(400).json({
      message: "Gagal Memverifikasi Akun, Semua Field Harus Diisi!",
    });
  }
  const { nik } = req.body;
  try {
    if (!nik) {
      return res.status(400).json({
        message: "Gagal Memverifikasi Akun, NIK Harus Diisi!",
      });
    }

    const verifikasiAkun = await prisma.verifikasiAkun.findUnique({
      where: { nik: nik, posyanduId: posyanduId },
    });

    if (!verifikasiAkun) {
      return res.status(404).json({
        message:
          "Gagal Memverifikasi Akun, Pengajuan Verifikasi Akun Tidak Ditemukan!",
      });
    }

    const orangTua = await prisma.orangTua.update({
      where: { nik: nik },
      data: {
        noHp: verifikasiAkun.noHpBaru,
        posyandu: { connect: { id: posyanduId } },
      },
    });
    if (orangTua) {
      await prisma.verifikasiAkun.delete({
        where: { id: verifikasiAkun.id },
      });
      return res.status(200).json({
        message:
          "Akun Berhasil Diverifikasi, Silakan Sampaikan Kepada Orang Tua Untuk Masuk Dengan No. HP Baru",
      });
    } else {
      return res.status(400).json({
        message: "Gagal Memverifikasi Akun, Silakan Coba Lagi!",
      });
    }
  } catch (error) {
    console.error(
      "Gagal Memverifikasi Akun, Error di verifikasiAkun Controller",
      error
    );
    return res.status(500).json({
      message: "Gagal Memverifikasi Akun, Terjadi Kesalahan Pada Server!",
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
        message: "Token Valid",
        userOrangTua: req.orangTua,
      });
    }
    if (req.posyandu) {
      return res.status(200).json({
        message: "Token Valid",
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
