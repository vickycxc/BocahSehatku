/*
  Warnings:

  - You are about to drop the `verifikasiAkun` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "verifikasiAkun" DROP CONSTRAINT "verifikasiAkun_nik_fkey";

-- DropForeignKey
ALTER TABLE "verifikasiAkun" DROP CONSTRAINT "verifikasiAkun_posyanduId_fkey";

-- DropTable
DROP TABLE "verifikasiAkun";

-- CreateTable
CREATE TABLE "VerifikasiAkun" (
    "id" SERIAL NOT NULL,
    "nik" TEXT NOT NULL,
    "posyanduId" INTEGER NOT NULL,
    "noHpBaru" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "VerifikasiAkun_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "VerifikasiAkun_nik_key" ON "VerifikasiAkun"("nik");

-- CreateIndex
CREATE UNIQUE INDEX "VerifikasiAkun_noHpBaru_key" ON "VerifikasiAkun"("noHpBaru");

-- AddForeignKey
ALTER TABLE "VerifikasiAkun" ADD CONSTRAINT "VerifikasiAkun_nik_fkey" FOREIGN KEY ("nik") REFERENCES "OrangTua"("nik") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VerifikasiAkun" ADD CONSTRAINT "VerifikasiAkun_posyanduId_fkey" FOREIGN KEY ("posyanduId") REFERENCES "Posyandu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
