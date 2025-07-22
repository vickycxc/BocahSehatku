import type { OrangTuaType, PosyanduType } from "../prisma.ts";

declare global {
  declare namespace Express {
    interface Request {
      orangTua: OrangTuaType;
      posyandu: PosyanduType;
    }
  }
}
