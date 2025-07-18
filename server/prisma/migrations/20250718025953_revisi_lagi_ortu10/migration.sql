/*
  Warnings:

  - Added the required column `updatedAt` to the `Anak` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `OrangTua` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Posyandu` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Anak" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "OrangTua" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Posyandu" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;
