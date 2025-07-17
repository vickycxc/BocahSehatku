/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Profile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE');

-- CreateEnum
CREATE TYPE "kategoriBBU" AS ENUM ('SANGAT_KURANG', 'KURANG', 'NORMAL', 'LEBIH');

-- CreateEnum
CREATE TYPE "kategoriTBU" AS ENUM ('SANGAT_PENDEK', 'PENDEK', 'NORMAL', 'TINGGI');

-- CreateEnum
CREATE TYPE "kategoriBBTB" AS ENUM ('GIZI_BURUK', 'GIZI_KURANG', 'GIZI_BAIK', 'BERISIKO_GIZI_LEBIH', 'GIZI_LEBIH', 'OBESITAS');

-- CreateEnum
CREATE TYPE "kategorIMTU" AS ENUM ('GIZI_BURUK', 'GIZI_KURANG', 'GIZI_BAIK', 'BERISIKO_GIZI_LEBIH', 'GIZI_LEBIH', 'OBESITAS');

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Profile" DROP CONSTRAINT "Profile_userId_fkey";

-- DropTable
DROP TABLE "Post";

-- DropTable
DROP TABLE "Profile";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "OrangTua" (
    "id" SERIAL NOT NULL,
    "noHp" TEXT NOT NULL,
    "nama" TEXT,
    "nik" TEXT,
    "jenisKelamin" "Gender",
    "alamat" TEXT,
    "posyanduId" INTEGER,

    CONSTRAINT "OrangTua_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Posyandu" (
    "id" SERIAL NOT NULL,
    "kode" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "nama" TEXT NOT NULL,
    "kecamatan" TEXT NOT NULL,
    "puskesmas" TEXT NOT NULL,
    "desa" TEXT NOT NULL,
    "alamat" TEXT NOT NULL,

    CONSTRAINT "Posyandu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Anak" (
    "id" SERIAL NOT NULL,
    "nama" TEXT NOT NULL,
    "tanggalLahir" TIMESTAMP(3) NOT NULL,
    "jenisKelamin" "Gender" NOT NULL,
    "nik" TEXT,
    "bbLahir" DOUBLE PRECISION,
    "tbLahir" DOUBLE PRECISION,
    "mingguLahir" INTEGER,
    "orangTuaId" INTEGER,

    CONSTRAINT "Anak_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pengukuran" (
    "id" SERIAL NOT NULL,
    "tanggalPengukuran" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "beratBadan" DOUBLE PRECISION NOT NULL,
    "tinggiBadan" DOUBLE PRECISION NOT NULL,
    "anakId" INTEGER NOT NULL,
    "imt" DOUBLE PRECISION NOT NULL,
    "kategoriBBU" "kategoriBBU" NOT NULL,
    "kategoriTBU" "kategoriTBU" NOT NULL,
    "kategoriBBTB" "kategoriBBTB" NOT NULL,
    "kategoriIMTU" "kategorIMTU" NOT NULL,

    CONSTRAINT "Pengukuran_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "OrangTua_noHp_key" ON "OrangTua"("noHp");

-- CreateIndex
CREATE UNIQUE INDEX "OrangTua_nik_key" ON "OrangTua"("nik");

-- CreateIndex
CREATE UNIQUE INDEX "Posyandu_kode_key" ON "Posyandu"("kode");

-- CreateIndex
CREATE UNIQUE INDEX "Anak_nik_key" ON "Anak"("nik");

-- AddForeignKey
ALTER TABLE "OrangTua" ADD CONSTRAINT "OrangTua_posyanduId_fkey" FOREIGN KEY ("posyanduId") REFERENCES "Posyandu"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Anak" ADD CONSTRAINT "Anak_orangTuaId_fkey" FOREIGN KEY ("orangTuaId") REFERENCES "OrangTua"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pengukuran" ADD CONSTRAINT "Pengukuran_anakId_fkey" FOREIGN KEY ("anakId") REFERENCES "Anak"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
