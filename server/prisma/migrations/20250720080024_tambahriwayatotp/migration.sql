/*
  Warnings:

  - You are about to drop the `riwayat_otp` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "riwayat_otp";

-- CreateTable
CREATE TABLE "RiwayatOtp" (
    "id" SERIAL NOT NULL,
    "noHp" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RiwayatOtp_pkey" PRIMARY KEY ("id")
);
