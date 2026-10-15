# Museum Brawijaya — Mobile App (Flutter & Dart)

Aplikasi mobile resmi Museum Brawijaya untuk UTS Frontend Development. Proyek ini dibangun menggunakan **Flutter stable** dan bahasa pemrograman **Dart**, siap dijalankan di **VS Code** dan di-commit ke repositori **GitHub**.

---

## 📱 Ringkasan Fitur & Halaman

1. **Splash Screen**
    - Efek latar belakang gelap dengan _ambient green radial glow_ di tengah layar.
    - Teks 2 baris: **Museum Brawijaya** dengan animasi kemunculan halus (_fade-scale_).
    - Durasi tampil ~8 detik sebelum berpindah otomatis ke _Login Screen_ secara mulus.
    - Manajemen _timer_ & _animation controller_ aman dari _memory leak_.

2. **Login Screen**
    - Panel melayang dengan sudut membulat besar (_rounded corner_) dan garis tepi tipis sesuai desain referensi.
    - Input field: **Email** dan **Kata Sandi** (dengan ikon mata untuk menampilkan/menyembunyikan kata sandi).
    - Tombol utama hijau **Login**.
    - Tautan **Lupa Password ?** menuju halaman reset kata sandi.
    - Garis pemisah **atau**.
    - Tombol putih **Lanjutkan dengan Google** dengan logo Google 4 warna.
    - Tautan **Tidak meiliki akun ? Buat Akun Baru**.
    - Navigasi mulus menuju **Dashboard Screen** setelah login berhasil.

3. **Reset Password Screen & Validasi Alur**
    - Judul 2 baris: **Reset Kata Sandi** dengan petunjuk verifikasi identitas.
    - Input field: **Email yang terkait**.
    - Tombol baris: **Kembali** (ikon panah lengkung ke kiri) dan **Konfirmasi** (tombol hijau).
    - **Kondisi A (Email Kosong/Tidak Valid):** Menampilkan validasi inline tanpa membuka bottom sheet.
    - **Kondisi B (Email Tidak Terdaftar):** Menampilkan dialog pop-up bertuliskan _“Akun tidak terdaftar”_. Bottom sheet _“Periksa Email Anda”_ tidak dibuka.
    - **Kondisi C (Email Terdaftar):** Membuka **Draggable Feedback Sheet** dengan efek _backdrop blur_ dan transisi _slide-up_ halus.

4. **Draggable Feedback Sheet (“Periksa Email Anda”)**
    - Latar belakang redup dengan efek **Backdrop Blur**.
    - **Drag Handle:** Indikator pil abu-abu di bagian atas.
    - **Judul:** _“Periksa Email Anda”_.
    - **Deskripsi:** _“Kami telah mengirim link reset password akun Anda menuju email berikut”_.
    - **Ilustrasi Amplop & Surat:** Komponen visual amplop terbuka dengan lembaran surat di dalamnya.
    - **Email Tersamar Dinamis:** Contoh `bu**********21@gmail.com` atau `de******st@museum.test` dengan warna aksen hijau.
    - **Countdown 30 Detik:** _“Tidak menerima email? Tunggu 30 Detik”_ menghitung mundur setiap detik, kemudian berubah menjadi tautan interaktif _“Kirim ulang email”_.
    - **Gesture Menutup:** Mendukung _swipe_ ke bawah, _swipe_ ke atas, atau ketukan di luar panel (_backdrop tap_) untuk kembali ke Reset Password Screen.

5. **Dashboard Screen (Museum Brawijaya)**
    - **Top Bar:** Avatar pengguna berbingkai emas, sapaan _“Hola, Alexandra”_, dan tombol menu _hamburger_.
    - **Branding Header:** _“Museum”_ dan lencana hijau _“Brawijaya”_.
    - **Hero Banner:** Efek tumpukan kartu (_stacked card_) bertajuk _“Rahasia di Balik Bilah Keris Kuno”_, narasi filosofi keris pusaka, tombol _“Cari Tahu →”_, dan latar etalase museum.
    - **Kategori:** Tab filter pil _“Pelayanan”_ (aktif), _“Sejarah”_ (dengan dot notifikasi merah), dan _“CS”_.
    - **2x2 Feature Cards Grid:**
        1. _Pindai & Jelajahi Sejarah_ (Scan)
        2. _Jelajah Sejarah Lewat Peta Interaktif_ (Maps)
        3. _Bagikan Kesan Kunjunganmu_ (Feedback)
        4. _Pesan Tiket_ (Tiket & Tombol `+`)

---

## 🔑 Kredensial Akun Demo (Data Uji Bersama)

| Field        | Akun Demo 1        | Akun Demo 2               |
| :----------- | :----------------- | :------------------------ |
| **Email**    | `demo@museum.test` | `budipramono21@gmail.com` |
| **Password** | `Museum123!`       | `Museum123!`              |
| **Nama**     | Alexandra          | Budi Pramono              |

---

## 🚀 Panduan Menjalankan di VS Code

1. Buka folder proyek di VS Code.
2. Unduh dependencies:
    ```bash
    flutter pub get
    ```
