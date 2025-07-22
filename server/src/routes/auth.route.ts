import express from "express";
import {
  perbaruiProfil,
  masuk,
  masukPosyandu,
  daftar,
  kirimOtp,
  ubahNoHp,
  checkAuth,
  ajukanUbahNoHp,
  verifikasiAkun,
  cekVerifikasiAkun,
  verifikasiOtp,
} from "../controller/auth.controller.ts";
import { protectRoute } from "../middleware/auth.middleware.ts";

const router = express.Router();

router.post("/kirim-otp", kirimOtp);
router.post("/daftar", daftar);
router.put("/perbarui-profil", protectRoute, perbaruiProfil);
router.post("/ubah-no-hp", protectRoute, ubahNoHp);
router.post("/verifikasi-otp", verifikasiOtp);
router.post("/ajukan-ubah-no-hp", ajukanUbahNoHp);
router.get("/cek-verifikasi-akun", protectRoute, cekVerifikasiAkun);
router.put("/verifikasi-akun", protectRoute, verifikasiAkun);
router.post("/masuk", masuk);
router.post("/masuk-posyandu", masukPosyandu);
router.get("/", protectRoute, checkAuth);

export default router;
