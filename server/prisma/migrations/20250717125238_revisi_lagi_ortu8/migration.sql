-- AlterTable
ALTER TABLE "OrangTua" ADD COLUMN     "otp" TEXT,
ADD COLUMN     "otpExpiresAt" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "VerifikasiOtp" (
    "id" SERIAL NOT NULL,
    "noHp" TEXT NOT NULL,
    "otp" TEXT NOT NULL,
    "otpExpiresAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VerifikasiOtp_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "VerifikasiOtp_noHp_key" ON "VerifikasiOtp"("noHp");
