/*
  Warnings:

  - You are about to drop the column `nama` on the `Anak` table. All the data in the column will be lost.
  - Added the required column `namaPosyandu` to the `Anak` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Anak" DROP COLUMN "nama",
ADD COLUMN     "namaPosyandu" TEXT NOT NULL;
