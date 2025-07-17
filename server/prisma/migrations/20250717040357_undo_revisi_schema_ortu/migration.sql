-- DropForeignKey
ALTER TABLE "OrangTua" DROP CONSTRAINT "OrangTua_posyanduId_fkey";

-- AlterTable
ALTER TABLE "OrangTua" ALTER COLUMN "nama" DROP NOT NULL,
ALTER COLUMN "nik" DROP NOT NULL,
ALTER COLUMN "jenisKelamin" DROP NOT NULL,
ALTER COLUMN "alamat" DROP NOT NULL,
ALTER COLUMN "posyanduId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "OrangTua" ADD CONSTRAINT "OrangTua_posyanduId_fkey" FOREIGN KEY ("posyanduId") REFERENCES "Posyandu"("id") ON DELETE SET NULL ON UPDATE CASCADE;
