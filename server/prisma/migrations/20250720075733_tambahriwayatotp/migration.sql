-- CreateTable
CREATE TABLE "riwayat_otp" (
    "id" SERIAL NOT NULL,
    "noHp" TEXT NOT NULL,
    "nik" TEXT,
    "tujuan" TEXT NOT NULL,
    "berhasil" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "riwayat_otp_pkey" PRIMARY KEY ("id")
);
