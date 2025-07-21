-- AddForeignKey
ALTER TABLE "verifikasiAkun" ADD CONSTRAINT "verifikasiAkun_nik_fkey" FOREIGN KEY ("nik") REFERENCES "OrangTua"("nik") ON DELETE RESTRICT ON UPDATE CASCADE;
