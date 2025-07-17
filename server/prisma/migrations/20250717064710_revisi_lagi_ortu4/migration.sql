/*
  Warnings:

  - You are about to drop the column `desa` on the `Posyandu` table. All the data in the column will be lost.
  - Added the required column `desaKelurahan` to the `Posyandu` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Posyandu" DROP COLUMN "desa",
ADD COLUMN     "desaKelurahan" TEXT NOT NULL;
