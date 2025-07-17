/*
  Warnings:

  - The `jenisKelamin` column on the `OrangTua` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the type of `jenisKelamin` on the `Anak` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "jenisKelamin" AS ENUM ('LAKI_LAKI', 'PEREMPUAN');

-- AlterTable
ALTER TABLE "Anak" DROP COLUMN "jenisKelamin",
ADD COLUMN     "jenisKelamin" "jenisKelamin" NOT NULL;

-- AlterTable
ALTER TABLE "OrangTua" DROP COLUMN "jenisKelamin",
ADD COLUMN     "jenisKelamin" "jenisKelamin";

-- DropEnum
DROP TYPE "Gender";
