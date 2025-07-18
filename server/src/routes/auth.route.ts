import express from "express";
import {
  perbaruiProfil,
  masuk,
  masukPosyandu,
  daftar,
  kirimOtp,
  ubahNoHp,
} from "../controller/auth.controller.ts";

const router = express.Router();

router.post("/kirim-otp", kirimOtp);
router.post("/daftar", daftar);
router.put("/lengkapi-profil", perbaruiProfil);
router.post("/ubah-no-hp", ubahNoHp);
router.post("/masuk", masuk);
router.post("/masuk-posyandu", masukPosyandu);

export default router;
