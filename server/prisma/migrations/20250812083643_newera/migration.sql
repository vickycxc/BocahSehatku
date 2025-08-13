/*
  Warnings:

  - Added the required column `posyanduId` to the `Pengukuran` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rekomendasiKader` to the `Pengukuran` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rekomendasiOrtu` to the `Pengukuran` table without a default value. This is not possible if the table is not empty.
  - Added the required column `statusPertumbuhan` to the `Pengukuran` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `kategoriIMTU` on the `Pengukuran` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "kategoriIMTU" AS ENUM ('GIZI_BURUK', 'GIZI_KURANG', 'GIZI_BAIK', 'BERISIKO_GIZI_LEBIH', 'GIZI_LEBIH', 'OBESITAS');

-- AlterTable
ALTER TABLE "Pengukuran" ADD COLUMN     "posyanduId" INTEGER NOT NULL,
ADD COLUMN     "rekomendasiKader" TEXT NOT NULL,
ADD COLUMN     "rekomendasiOrtu" TEXT NOT NULL,
ADD COLUMN     "statusPertumbuhan" TEXT NOT NULL,
DROP COLUMN "kategoriIMTU",
ADD COLUMN     "kategoriIMTU" "kategoriIMTU" NOT NULL;

-- DropEnum
DROP TYPE "kategorIMTU";

-- AddForeignKey
ALTER TABLE "Pengukuran" ADD CONSTRAINT "Pengukuran_posyanduId_fkey" FOREIGN KEY ("posyanduId") REFERENCES "Posyandu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
