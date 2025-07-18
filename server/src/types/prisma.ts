import type { Prisma } from "../../generated/prisma/index.js";

// Basic model types
export type OrangTuaType = Prisma.OrangTuaGetPayload<{}>;
export type PosyanduType = Prisma.PosyanduGetPayload<{}>;
export type AnakType = Prisma.AnakGetPayload<{}>;

// Model with relations
export type OrangTuaWithRelations = Prisma.OrangTuaGetPayload<{
  include: {
    posyandu: true;
    anak: true;
  };
}>;

export type PosyanduWithOrangTua = Prisma.PosyanduGetPayload<{
  include: {
    orangTua: true;
  };
}>;

// Create/Update input types
export type OrangTuaCreateInput = Prisma.OrangTuaCreateInput;
export type OrangTuaUpdateInput = Prisma.OrangTuaUpdateInput;
export type PosyanduCreateInput = Prisma.PosyanduCreateInput;
export type PosyanduUpdateInput = Prisma.PosyanduUpdateInput;
