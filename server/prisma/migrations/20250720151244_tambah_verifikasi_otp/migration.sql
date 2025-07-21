-- AlterTable
ALTER TABLE "VerifikasiOtp" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CreateTable
CREATE TABLE "verifikasiAkun" (
    "id" SERIAL NOT NULL,
    "nik" TEXT NOT NULL,
    "noHpBaru" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "verifikasiAkun_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "verifikasiAkun_nik_key" ON "verifikasiAkun"("nik");

-- CreateIndex
CREATE UNIQUE INDEX "verifikasiAkun_noHpBaru_key" ON "verifikasiAkun"("noHpBaru");
