/*
  Warnings:

  - You are about to drop the column `namaPosyandu` on the `Anak` table. All the data in the column will be lost.
  - You are about to drop the column `nama` on the `Posyandu` table. All the data in the column will be lost.
  - Added the required column `nama` to the `Anak` table without a default value. This is not possible if the table is not empty.
  - Added the required column `namaPosyandu` to the `Posyandu` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Anak" DROP COLUMN "namaPosyandu",
ADD COLUMN     "nama" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Posyandu" DROP COLUMN "nama",
ADD COLUMN     "namaPosyandu" TEXT NOT NULL;
