---
title: "Registri takson"
sidebar:
  order: 0
---

Registri berisi nama takson yang tersedia untuk proyek ini. Catatan spesimen menunjuk ke takson terdaftar untuk identifikasinya.

Tambahkan takson secara manual atau impor berkas `.xlsx`, `.csv`, atau `.tsv`. Pendaftaran manual meminta `Taxon rank` terlebih dahulu, lalu menampilkan kolom nama sampai tingkat tersebut. Impor menerima catatan kelas, ordo, famili, genus, spesies, dan subspesies. Setiap baris memerlukan kolom klasifikasi dari kelas sampai tingkat yang dipilih. Periksa setiap pemetaan kolom yang terdeteksi sebelum mengimpor.

Berkas boleh tidak menyertakan `Taxon rank`, `Kingdom`, `Phylum`, dan `Class`. Jika `Class` belum dipetakan, pilih kelas yang didukung dan sama untuk semua baris melalui `Select the class shared by all rows`. NAHPU mengisi kerajaan dan filum yang kosong untuk kelas yang dikenali serta mempertahankan nilai yang disediakan. Bila tingkat takson tidak diberikan, ordo, famili, genus, dan epitet spesifik harus lengkap; tingkatnya spesies, atau subspesies bila epitet subspesifik tersedia. Berkas yang berisi beberapa kelas memerlukan kolom `Class`.

Panel menghitung ordo, famili, dan nama spesies lengkap yang berbeda di dalam registri. Jumlah total takson muncul bila registri juga memuat nama di atas atau di bawah tingkat spesies. Ini adalah hitungan registri; panel statistik melaporkan takson yang benar-benar dipakai catatan spesimen.

Untuk impor QR, pilih `Scan QR`, lalu `Single taxon` atau `Multiple taxa`. Satu pemindaian valid membuka pratinjau; mode beberapa takson membiarkan kamera terbuka sampai `Done` dipilih. Tinjau dan impor takson yang dipilih untuk menyimpannya. Takson yang sudah ada dinonaktifkan dan tidak pernah ditimpa.

Mengedit takson terdaftar mengubah catatan nama bersama. Untuk memperbaiki identifikasi satu spesimen saja, pilih takson yang sesuai pada spesimen tersebut.

## Pelajari lebih lanjut

- [Registri Takson](https://nahpu.app/id/usages/taxon/)
