/*
  Warnings:

  - Made the column `nama` on table `OrangTua` required. This step will fail if there are existing NULL values in that column.
  - Made the column `nik` on table `OrangTua` required. This step will fail if there are existing NULL values in that column.
  - Made the column `jenisKelamin` on table `OrangTua` required. This step will fail if there are existing NULL values in that column.
  - Made the column `alamat` on table `OrangTua` required. This step will fail if there are existing NULL values in that column.
  - Made the column `posyanduId` on table `OrangTua` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "OrangTua" DROP CONSTRAINT "OrangTua_posyanduId_fkey";

-- AlterTable
ALTER TABLE "OrangTua" ALTER COLUMN "nama" SET NOT NULL,
ALTER COLUMN "nik" SET NOT NULL,
ALTER COLUMN "jenisKelamin" SET NOT NULL,
ALTER COLUMN "alamat" SET NOT NULL,
ALTER COLUMN "posyanduId" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "OrangTua" ADD CONSTRAINT "OrangTua_posyanduId_fkey" FOREIGN KEY ("posyanduId") REFERENCES "Posyandu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
