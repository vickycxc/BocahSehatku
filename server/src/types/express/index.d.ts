import type { OrangTuaType, PosyanduType } from "../prisma.js";

declare global {
  declare namespace Express {
    interface Request {
      orangTua: OrangTuaType;
      posyandu: PosyanduType;
    }
  }
}
