/*
  Warnings:

  - You are about to drop the column `kode` on the `Posyandu` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[kodePosyandu]` on the table `Posyandu` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `kodePosyandu` to the `Posyandu` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Posyandu_kode_key";

-- AlterTable
ALTER TABLE "Posyandu" DROP COLUMN "kode",
ADD COLUMN     "kodePosyandu" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Posyandu_kodePosyandu_key" ON "Posyandu"("kodePosyandu");
