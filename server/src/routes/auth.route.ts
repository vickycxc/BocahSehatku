import express from "express";
import {
  perbaruiProfil,
  masuk,
  masukPosyandu,
  daftar,
  kirimOtp,
  ubahNoHp,
  checkAuth,
} from "../controller/auth.controller.ts";
import { protectRoute } from "../middleware/auth.middleware.ts";

const router = express.Router();

router.post("/kirim-otp", kirimOtp);
router.post("/daftar", daftar);
router.put("/lengkapi-profil", protectRoute, perbaruiProfil);
router.post("/ubah-no-hp", protectRoute, ubahNoHp);
router.post("/masuk", masuk);
router.post("/masuk-posyandu", masukPosyandu);
router.get("/", protectRoute, checkAuth);

export default router;
