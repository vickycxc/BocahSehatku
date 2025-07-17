/*
  Warnings:

  - You are about to drop the column `otp` on the `OrangTua` table. All the data in the column will be lost.
  - You are about to drop the column `otp` on the `VerifikasiOtp` table. All the data in the column will be lost.
  - Added the required column `kodeOtp` to the `VerifikasiOtp` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "OrangTua" DROP COLUMN "otp",
ADD COLUMN     "kodeOtp" TEXT;

-- AlterTable
ALTER TABLE "VerifikasiOtp" DROP COLUMN "otp",
ADD COLUMN     "kodeOtp" TEXT NOT NULL;
