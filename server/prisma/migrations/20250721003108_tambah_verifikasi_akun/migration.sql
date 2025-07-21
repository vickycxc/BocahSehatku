/*
  Warnings:

  - Added the required column `posyanduId` to the `verifikasiAkun` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "verifikasiAkun" ADD COLUMN     "posyanduId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "verifikasiAkun" ADD CONSTRAINT "verifikasiAkun_posyanduId_fkey" FOREIGN KEY ("posyanduId") REFERENCES "Posyandu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
