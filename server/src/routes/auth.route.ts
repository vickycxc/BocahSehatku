import express from "express";
import {
  completeProfile,
  login,
  loginPosyandu,
  register,
} from "../controller/auth.controller.ts";

const router = express.Router();

router.post("/register", register);
router.post("/complete-profile", completeProfile);
router.post("/login", login);
router.post("/login-posyandu", loginPosyandu);

export default router;
