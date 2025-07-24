-- DropForeignKey
ALTER TABLE "verifikasiAkun" DROP CONSTRAINT "verifikasiAkun_nik_fkey";

-- DropForeignKey
ALTER TABLE "verifikasiAkun" DROP CONSTRAINT "verifikasiAkun_posyanduId_fkey";

-- AddForeignKey
ALTER TABLE "verifikasiAkun" ADD CONSTRAINT "verifikasiAkun_nik_fkey" FOREIGN KEY ("nik") REFERENCES "OrangTua"("nik") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "verifikasiAkun" ADD CONSTRAINT "verifikasiAkun_posyanduId_fkey" FOREIGN KEY ("posyanduId") REFERENCES "Posyandu"("id") ON DELETE CASCADE ON UPDATE CASCADE;
