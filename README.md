# 🐉 DragonGuard - Aplikasi Pendaftaran Kunjungan Barongsai

**Tugas 1: Pemrograman Aplikasi Bergerak**

Aplikasi mobile berbasis **Flutter** ini dirancang untuk mendigitalkan proses manajemen jadwal kunjungan dan pertunjukan Barongsai. Aplikasi ini mempermudah tim manajemen dalam mencatat pesanan, mengubah jadwal, dan mengelola data klien secara efisien, menggantikan pencatatan manual yang rawan kesalahan.

---

## 👨‍💻 Identitas Mahasiswa

| Informasi | Detail |
| :--- | :--- |
| **Nama** | **Dharma Pala Candra** |
| **NIM** | **2409116065** |
| **Mata Kuliah** | **Pemrograman Aplikasi Bergerak** |
| **Tema Aplikasi** | Pendaftaran Kunjungan Barongsai |

---

## 🚀 Fitur Utama

Aplikasi ini telah memenuhi seluruh **Persyaratan Wajib** dan **Nilai Tambah** (Bonus Points) dengan implementasi fitur **CRUD** (Create, Read, Update, Delete) yang lengkap:

1.  **Create (Tambah Data)**
    * Formulir input data pelanggan baru (Nama, Nomor HP, Tanggal, Alamat).
    * Validasi input (tidak boleh kosong).
2.  **Read (Lihat Data)**
    * Menampilkan daftar seluruh jadwal kunjungan yang tersimpan.
    * Tampilan antarmuka menggunakan `Card` dan `ListTile` yang informatif.
3.  **Update (Edit Data) ✨ _(Nilai Tambah)_**
    * Fitur untuk mengedit data jadwal yang sudah ada tanpa perlu menghapus dan membuat ulang.
    * Formulir otomatis terisi (*pre-filled*) dengan data lama saat mode edit.
4.  **Delete (Hapus Data)**
    * Menghapus jadwal yang sudah selesai atau dibatalkan.
    * Dilengkapi dengan `AlertDialog` konfirmasi untuk mencegah penghapusan tidak sengaja.
5.  **Multi-Page Navigation ✨ _(Nilai Tambah)_**
    * Navigasi antar halaman (Halaman Utama ↔ Halaman Formulir) yang mulus menggunakan `Navigator.push` dan `Navigator.pop`.

---

## 🛠️ Widget yang Digunakan

Berikut adalah komponen widget utama yang digunakan dalam membangun antarmuka aplikasi ini:

* **Struktur:** `MaterialApp`, `Scaffold`, `AppBar`.
* **Layout & List:** `ListView.builder` (untuk efisiensi memori), `Card`, `ListTile`, `Column`, `Row`, `SingleChildScrollView`.
* **Input & Form:** `Form`, `TextFormField` (dengan controller & validator), `FloatingActionButton`, `ElevatedButton`.
* **Interaksi & Navigasi:** `Navigator` (Push/Pop), `AlertDialog`, `SnackBar` (notifikasi pop-up), `InkWell/GestureDetector`.

---

## 📱 Tampilan Aplikasi (Screenshots)

*(Opsional: Anda bisa menambahkan screenshot aplikasi di sini agar README terlihat lebih pro)*

| Halaman Utama | Form Input/Edit |
| :---: | :---: |
| <img width="383" height="535" alt="Screenshot 2026-02-24 000419" src="https://github.com/user-attachments/assets/dd29115d-d115-4cd9-8708-58a51f150461" /> | <img width="382" height="535" alt="Screenshot 2026-02-24 000536" src="https://github.com/user-attachments/assets/a75f5991-e08d-45a6-9913-ca2d1245288c" /> |
---

## ⚙️ Cara Menjalankan Aplikasi

Pastikan Flutter SDK sudah terinstal di komputer Anda.

1.  **Clone Repository ini:**
    ```bash
    git clone [https://github.com/username-anda/nama-repo.git](https://github.com/username-anda/nama-repo.git)
    ```
2.  **Masuk ke direktori project:**
    ```bash
    cd nama-repo
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Jalankan aplikasi:**
    ```bash
    flutter run
    ```

---

*Dibuat dengan ❤️ menggunakan Flutter & Dart.*
