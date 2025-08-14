import bcryptjs from "bcryptjs";
import generateToken from "../lib/jwt.ts";
import prisma from "../lib/prisma.ts";
import type { Request, Response } from "express";
import type { OrangTuaType } from "../types/prisma.ts";
import axios from "axios";

export const kirimOtp = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({ pesanError: "HP_TUJUAN_KOSONG" });
  }
  const { noHp, tujuan, nik } = req.body;
  try {
    if (!noHp || !tujuan) {
      return res.status(400).json({ pesanError: "HP_TUJUAN_KOSONG" });
    }

    if (tujuan === "AJUKAN_UBAH_NO_HP" && !nik) {
      return res.status(400).json({ pesanError: "NIK_KOSONG" });
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
          pesanError: "SUDAH_DIAJUKAN",
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
        pesanError: "TERLALU_BANYAK_PERMINTAAN_OTP",
        waktuTungguOtp: sisaWaktu,
      });
    }

    if (
      tujuan !== "DAFTAR" &&
      tujuan !== "MASUK" &&
      tujuan !== "AJUKAN_UBAH_NO_HP"
    ) {
      return res.status(400).json({
        pesanError: "TUJUAN_TIDAK_VALID",
      });
    }

    if (tujuan === "MASUK" && !cekNoHp) {
      return res.status(400).json({ pesanError: "AKUN_TIDAK_VALID" });
    }

    if (tujuan === "DAFTAR" || tujuan === "AJUKAN_UBAH_NO_HP") {
      if (tujuan === "AJUKAN_UBAH_NO_HP" && !cekNik) {
        return res.status(400).json({ pesanError: "AKUN_TIDAK_VALID" });
      }
      if (cekNoHp) {
        return res.status(400).json({
          pesanError: "OTP_HP_SUDAH_TERDAFTAR",
        });
      }
    }

    // const response = await axios.post(
    //   "https://api.fazpass.com/v1/otp/generate",
    //   {
    //     phone: noHp,
    //     gateway_key: process.env.GATEWAY_KEY!,
    //   },
    //   {
    //     headers: {
    //       Authorization: "Bearer " + process.env.MERCHANT_KEY!,
    //       "Content-Type": "application/json",
    //     },
    //   }
    // );

    // if (response.data.status === true) {
    if (true) {
      const kodeOtp = "0000";
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

      return res.status(200);
    } else {
      //TODO HANDLE NO. HP TIDAK VALID
      return res.status(400).json({
        pesanError: "OTP_GAGAL_DIKIRIM",
      });
    }
  } catch (error) {
    console.error("Gagal Mengirim OTP, Error di kirimOtp Controller", error);
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};

export const daftar = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({
      pesanError: "HP_OTP_TIDAK_VALID",
    });
  }
  const { noHp, kodeOtp } = req.body;
  try {
    if (!noHp || !kodeOtp) {
      return res.status(400).json({
        pesanError: "HP_OTP_TIDAK_VALID",
      });
    }
    const existingUser = await prisma.orangTua.findUnique({
      where: { noHp },
    });

    if (existingUser) {
      return res.status(400).json({ pesanError: "HP_SUDAH_TERDAFTAR" });
    }

    const verifikasiOtp = await prisma.verifikasiOtp.findUnique({
      where: { noHp },
    });

    if (!verifikasiOtp || kodeOtp !== verifikasiOtp?.kodeOtp) {
      return res.status(400).json({
        pesanError: "OTP_TIDAK_VALID",
      });
    }
    if (verifikasiOtp.otpExpiresAt < new Date()) {
      return res.status(400).json({
        pesanError: "OTP_KADALUARSA",
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
      userOrangTua: userOrangTua,
      token: token,
    });
  } catch (error) {
    console.error("Error di register controller", error);
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};

export const perbaruiProfil = async (req: Request, res: Response) => {
  const id = req.orangTua.id; // Ambil ID dari request yang sudah di-protect
  if (!req.body) {
    return res.status(400).json({
      pesanError: "FIELD_TIDAK_LENGKAP",
    });
  }
  const { nama, nik, jenisKelamin, alamat, posyanduId } = req.body;
  try {
    if (!nama || !nik || !jenisKelamin || !alamat || !posyanduId) {
      return res.status(400).json({
        pesanError: "FIELD_TIDAK_LENGKAP",
      });
    }

    if (!["LAKI_LAKI", "PEREMPUAN"].includes(jenisKelamin)) {
      return res.status(400).json({
        pesanError: "JENIS_KELAMIN_TIDAK_VALID",
      });
    }

    // Cek apakah user exists
    const existingUser = await prisma.orangTua.findUnique({
      where: { id: id }, // Pastikan ID adalah integer
    });

    if (!existingUser) {
      return res.status(404).json({
        pesanError: "AKUN_TIDAK_DITEMUKAN",
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
        pesanError: "NIK_SUDAH_TERDAFTAR",
        noHpBaru: cekNik.noHp,
      });
    }

    // Cek apakah posyandu exists
    const existingPosyandu = await prisma.posyandu.findUnique({
      where: { id: parseInt(posyanduId) },
    });

    if (!existingPosyandu) {
      return res.status(404).json({
        pesanError: "POSYANDU_TIDAK_DITEMUKAN",
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
      userOrangTua: userOrangTua,
    });
  } catch (error) {
    console.error(
      "Gagal Memperbarui Profil, Error di lengkapiProfil Controller",
      error
    );
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
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
        pesanError: "AKUN_TIDAK_DITEMUKAN",
      });
    }

    // Hapus akun
    await prisma.orangTua.delete({
      where: { id: id },
    });

    return res.status(200);
  } catch (error) {
    console.error("Gagal Menghapus Akun, Error di hapusAkun Controller", error);
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};

export const ubahNoHp = async (req: Request, res: Response) => {
  const id = req.orangTua.id;
  if (!req.body) {
    return res.status(400).json({ pesanError: "NO_HP_OTP_KOSONG" });
  }
  const { noHpBaru, kodeOtp } = req.body;
  try {
    if (!noHpBaru || !kodeOtp) {
      return res.status(400).json({ pesanError: "NO_HP_OTP_KOSONG" });
    }

    const existingUser = await prisma.orangTua.findUnique({
      where: { noHp: noHpBaru },
    });

    if (existingUser) {
      return res.status(400).json({ pesanError: "NO_HP_SUDAH_TERDAFTAR" });
    }

    const userOrangTua = await prisma.orangTua.findUnique({
      where: { id },
    });
    if (!userOrangTua) {
      return res.status(404).json({
        pesanError: "AKUN_TIDAK_DITEMUKAN",
      });
    }
    if (kodeOtp !== userOrangTua?.kodeOtp || !userOrangTua.otpExpiresAt) {
      return res.status(400).json({
        pesanError: "OTP_TIDAK_VALID",
      });
    }

    if (userOrangTua.otpExpiresAt < new Date()) {
      return res.status(400).json({
        pesanError: "OTP_KADALUARSA",
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
      userOrangTua: orangTuaNew,
    });
  } catch (error) {
    console.error("Gagal Mengubah No. HP, Error di ubahNoHp Controller", error);
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};

export const verifikasiOtp = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({
      pesanError: "NO_HP_OTP_KOSONG",
    });
  }

  const { noHp, kodeOtp } = req.body;
  try {
    if (!noHp || !kodeOtp) {
      return res.status(400).json({
        pesanError: "NO_HP_OTP_KOSONG",
      });
    }

    const verifikasiOtp = await prisma.verifikasiOtp.findUnique({
      where: { noHp },
    });

    if (!verifikasiOtp || kodeOtp !== verifikasiOtp?.kodeOtp) {
      return res.status(400).json({
        pesanError: "OTP_TIDAK_VALID",
      });
    }
    if (verifikasiOtp.otpExpiresAt < new Date()) {
      return res.status(400).json({
        pesanError: "OTP_KADALUARSA",
      });
    }

    return res.status(200);
  } catch (error) {
    console.error(
      "Gagal Memverifikasi OTP, Error di verifikasiOtp Controller",
      error
    );
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};

export const ajukanUbahNoHp = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({
      pesanError: "NO_HP_KODE_OTP_NIK_POSYANDU_KOSONG",
    });
  }
  const { noHpBaru, kodeOtp, nik, posyanduId } = req.body;
  try {
    if (!noHpBaru || !kodeOtp || !nik || !posyanduId) {
      return res.status(400).json({
        pesanError: "NO_HP_KODE_OTP_NIK_POSYANDU_KOSONG",
      });
    }

    const verifikasiOtp = await prisma.verifikasiOtp.findUnique({
      where: { noHp: noHpBaru },
    });

    if (!verifikasiOtp || kodeOtp !== verifikasiOtp?.kodeOtp) {
      return res.status(400).json({
        pesanError: "OTP_TIDAK_VALID",
      });
    }
    if (verifikasiOtp.otpExpiresAt < new Date()) {
      return res.status(400).json({
        pesanError: "OTP_KADALUARSA",
      });
    }

    if (!verifikasiOtp || kodeOtp !== verifikasiOtp?.kodeOtp) {
      return res.status(400).json({
        pesanError: "OTP_TIDAK VALID",
      });
    }
    if (verifikasiOtp.otpExpiresAt < new Date()) {
      return res.status(400).json({
        pesanError: "OTP_KADALUARSA",
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
        pesanError: "PENGAJUAN_SUDAH_DILAKUKAN",
        noHpBaru: cekPengajuanUbahNoHp.noHpBaru,
        posyandu: cekPengajuanUbahNoHp.posyandu.namaPosyandu,
      });
    }

    const cekPosyandu = await prisma.posyandu.findUnique({
      where: { id: posyanduId },
    });

    if (!cekPosyandu) {
      return res.status(404).json({
        pesanError: "POSYANDU_TIDAK_DITEMUKAN",
      });
    }

    const userOrangTua = await prisma.orangTua.findUnique({
      where: { nik },
    });
    if (!userOrangTua) {
      return res.status(404).json({
        pesanError: "AKUN_TIDAK_DITEMUKAN",
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
      return res.status(500).json({ pesanError: "INTERNAL_ERROR" });
    }

    await prisma.verifikasiOtp.delete({
      where: { noHp: noHpBaru },
    });

    return res.status(200);
  } catch (error) {
    console.error(
      "Gagal Mengubah No. HP, Error di ajukanUbahNoHp Controller",
      error
    );
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};

export const batalkanPengajuanUbahNoHp = async (
  req: Request,
  res: Response
) => {
  if (!req.body) {
    return res.status(400).json({
      pesanError: "NIK_KOSONG",
    });
  }
  const { nik } = req.body;

  if (!nik) {
    return res.status(400).json({
      pesanError: "NIK_KOSONG",
    });
  }

  try {
    const cekPengajuanUbahNoHp = await prisma.verifikasiAkun.findUnique({
      where: { nik: nik },
    });
    if (!cekPengajuanUbahNoHp) {
      return res.status(404).json({
        pesanError: "PENGAJUAN_TIDAK_DITEMUKAN",
      });
    }
    await prisma.verifikasiAkun.delete({
      where: { nik: nik },
    });

    return res.status(200);
  } catch (error) {
    console.error(
      "Gagal Membatalkan Pengajuan No. HP, Error di batalkanPengajuanUbahNoHp Controller",
      error
    );
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};

// export const cekVerifikasiAkun = async (req: Request, res: Response) => {
//   const { id } = req.posyandu;
//   try {
//     const verifikasiAkun = await prisma.verifikasiAkun.findMany({
//       where: { posyanduId: id },
//       include: {
//         orangTua: true,
//       },
//     });
//     return res.status(200).json({
//       message: "Berhasil Mengecek Verifikasi Akun",
//       verifikasiAkun: verifikasiAkun,
//     });
//   } catch (error) {
//     console.error(
//       "Gagal Mengecek Verifikasi Akun, Error di cekVerifikasiAkun Controller",
//       error
//     );
//     return res.status(500).json({
//       message: "Gagal Mengecek Verifikasi Akun, Terjadi Kesalahan Pada Server!",
//     });
//   }
// };

// export const verifikasiAkun = async (req: Request, res: Response) => {
//   const { id: posyanduId } = req.posyandu;
//   if (!req.body) {
//     return res.status(400).json({
//       pesanError: "NIK_KOSONG",
//     });
//   }
//   const { nik } = req.body;
//   try {
//     if (!nik) {
//       return res.status(400).json({
//         pesanError: "NIK_KOSONG",
//       });
//     }

//     const verifikasiAkun = await prisma.verifikasiAkun.findUnique({
//       where: { nik: nik, posyanduId: posyanduId },
//     });

//     if (!verifikasiAkun) {
//       return res.status(404).json({
//         pesanError: "PENGAJUAN_TIDAK_DITEMUKAN",
//       });
//     }

//     const orangTua = await prisma.orangTua.update({
//       where: { nik: nik },
//       data: {
//         noHp: verifikasiAkun.noHpBaru,
//         posyandu: { connect: { id: posyanduId } },
//       },
//     });
//     if (!orangTua) {
//       return res.status(500).json({
//         pesanError: "INTERNAL_ERROR",
//       });
//     }
//     await prisma.verifikasiAkun.delete({
//       where: { id: verifikasiAkun.id },
//     });
//     return res.status(200);
//   } catch (error) {
//     console.error(
//       "Gagal Memverifikasi Akun, Error di verifikasiAkun Controller",
//       error
//     );
//     return res.status(500).json({
//       message: "INTERNAL_ERROR",
//     });
//   }
// };

export const masuk = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({ pesanError: "NO_HP_OTP_KOSONG" });
  }
  const { noHp, kodeOtp } = req.body;
  try {
    if (!noHp) {
      return res.status(400).json({ pesanError: "NO_HP_OTP_KOSONG" });
    }

    const userOrangTua = await prisma.orangTua.findUnique({
      where: { noHp },
    });

    if (!userOrangTua) {
      return res.status(404).json({ pesanError: "AKUN_TIDAK_DITEMUKAN" });
    }

    if (
      !userOrangTua ||
      kodeOtp !== userOrangTua.kodeOtp ||
      !userOrangTua.otpExpiresAt
    ) {
      return res.status(400).json({
        pesanError: "OTP_TIDAK_VALID",
      });
    }

    if (userOrangTua.otpExpiresAt < new Date()) {
      return res.status(400).json({
        pesanError: "OTP_KADALUARSA",
      });
    }

    userOrangTua.kodeOtp = null;
    userOrangTua.otpExpiresAt = null;

    const token = generateToken({ userId: userOrangTua.id, role: "ORANG_TUA" });
    return res.status(200).json({
      userOrangTua: userOrangTua,
      token: token,
    });
  } catch (error) {
    console.error("Error di masuk controller", error);
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};

export const masukPosyandu = async (req: Request, res: Response) => {
  if (!req.body) {
    return res.status(400).json({
      pesanError: "KODE_POSYANDU_PASSWORD_KOSONG",
    });
  }
  const { kodePosyandu, password } = req.body;
  try {
    if (!kodePosyandu || !password) {
      return res.status(400).json({
        pesanError: "KODE_POSYANDU_PASSWORD_KOSONG",
      });
    }

    const posyandu = await prisma.posyandu.findUnique({
      where: { kodePosyandu },
    });

    if (!posyandu) {
      return res.status(404).json({ pesanError: "KODE_POSYANDU_TIDAK_VALID" });
    }

    const { password: userPassword, ...posyanduTanpaPassword } = posyandu;
    const isPasswordCorrect = await bcryptjs.compare(password, userPassword);

    if (!isPasswordCorrect) {
      return res.status(400).json({ pesanError: "PASSWORD_TIDAK_VALID" });
    }
    const token = generateToken({
      userId: posyanduTanpaPassword.id,
      role: "KADER_POSYANDU",
    });
    return res.status(200).json({
      userPosyandu: posyanduTanpaPassword,
      token: token,
    });
  } catch (error) {
    console.error("Error di masukPosyandu controller", error);
    return res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};

export const checkAuth = (req: Request, res: Response) => {
  try {
    if (req.orangTua) {
      return res.status(200).json({
        userOrangTua: req.orangTua,
      });
    }
    if (req.posyandu) {
      return res.status(200).json({
        userPosyandu: req.posyandu,
      });
    }
    return res.status(401).json({ message: "Gagal Mengecek Otorisasi!" });
  } catch (error) {
    console.error("Error in checkAuth controller", error);
    res.status(500).json({
      pesanError: "INTERNAL_ERROR",
    });
  }
};
