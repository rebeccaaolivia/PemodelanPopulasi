# Cara Menjalankan Program: Panduan Pengguna

Kode ini mengimplementasikan dua model untuk memprediksi populasi penduduk di Kabupaten Toba:

1. Model Logistik:
* Memprediksi populasi berdasarkan kurva logistik.
* Menggunakan regresi linear untuk mendapatkan parameter model.
* Menampilkan plot kurva logistik dan data populasi.
* Memprediksi populasi 200 tahun ke depan.

2. Model Integrasi Numerik:
* Memprediksi perubahan populasi tahunan.
* Menggunakan regresi linear untuk mendapatkan parameter model perubahan populasi.
* Menampilkan plot kurva perubahan populasi dan data perubahan populasi tahunan.
* Menghitung populasi di masa depan dengan menjumlahkan populasi awal dan integral dari perubahan populasi tahunan.
* Menampilkan plot kurva perbandingan model logistik dan integrasi numerik.

## Langkah-langkah penggunaan:

1. Pastikan Anda memiliki file kab_toba.xlsx yang berisi data populasi penduduk Kabupaten Toba.
2. Jalankan kode di software pemrograman yang mendukung MATLAB.
3. Kode akan menghasilkan empat plot:
* Kurva model logistik dan data populasi
* Proyeksi jangka panjang populasi
* Kurva regresi linier untuk perubahan populasi
* Kurva perbandingan model logistik dan integrasi numerik
4. Anda dapat menganalisis hasil plot untuk memahami tren populasi di Kabupaten Toba.

## Catatan:
* Kode ini menggunakan beberapa fungsi yang tidak didefinisikan dalam kode yang diberikan. Anda perlu mendefinisikan fungsi-fungsi tersebut sebelum menjalankan kode.
* Kode ini dapat dimodifikasi untuk menggunakan data populasi dari wilayah lain.
* Anda dapat menggunakan metode lain untuk memprediksi populasi, seperti model regresi non-linier atau jaringan saraf tiruan.

### Penjelasan singkat beberapa bagian kode:
    * populasi = data(:,2);: Memuat data populasi dari kolom kedua file Excel.
    * [u, b, Sr] = regresi_fun(twaktu,Y);: Melakukan regresi linear untuk mendapatkan parameter model.
    * poplog = @(t) (k./(1+a*exp(-r*t)));: Mendefinisikan fungsi model logistik.
    * f = @(x) (k./(1+a*exp(-r*x))) - 0.8*k;: Mendefinisikan fungsi untuk mencari akar persamaan.
    * ea_fun = @(xn,xo) abs(xn-xo)/abs(xn)*100;: Mendefinisikan fungsi untuk menghitung error relatif.
    * while ea > tol: Melakukan iterasi metode biseksi untuk mencari akar persamaan.
    * g(i-1)=(populasi(i+1)-populasi(i-1))/2;: Menghitung perubahan populasi tahunan.
    * [u2, b2, Sr2] = regresi_fun(tg,g);: Melakukan regresi linear untuk mendapatkan parameter model perubahan populasi.
    * yg = @(t2) u2 + b2*t2;: Mendefinisikan fungsi model perubahan populasi.
    * I(i) = tm(yg,u2,i);: Menghitung integral dari perubahan populasi tahunan.
    * Pk(i+1)=Pk(1)+I(i);: Menghitung populasi di masa depan.