import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas1/main.dart'; // Pastikan nama package 'tugas1' sesuai dengan pubspec.yaml Anda

void main() {
  testWidgets('Test fitur tambah pendaftaran barongsai', (WidgetTester tester) async {
    // 1. Render aplikasi
    await tester.pumpWidget(const BarongsaiApp());

    // 2. Pastikan awalnya muncul pesan "Belum ada jadwal"
    expect(find.text('Belum ada jadwal kunjungan.'), findsOneWidget);

    // 3. Tekan tombol FloatingActionButton (Tambah Jadwal)
    // Mencari tombol berdasarkan teks label karena kita menggunakan FloatingActionButton.extended
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(); // Tunggu animasi transisi halaman selesai

    // 4. Isi Form Pendaftaran
    // Mengisi TextField Nama Pemesan (TextField pertama)
    await tester.enterText(find.byIcon(Icons.person), 'Budi Barongsai');
    
    // Mengisi TextField Nomor HP (TextField kedua)
    await tester.enterText(find.byIcon(Icons.phone), '0812345678');

    // Mengisi TextField Tanggal (TextField ketiga)
    await tester.enterText(find.byIcon(Icons.calendar_month), '25 Februari 2024');

    // Mengisi TextField Alamat (TextField keempat)
    await tester.enterText(find.byIcon(Icons.home), 'Jl. Naga Emas No. 88');

    // 5. Tekan tombol SIMPAN DATA
    await tester.tap(find.text('SIMPAN DATA'));
    await tester.pumpAndSettle(); // Tunggu kembali ke halaman utama

    // 6. Verifikasi apakah data baru muncul di List halaman utama
    expect(find.text('Budi Barongsai'), findsOneWidget);
    expect(find.text('Jl. Naga Emas No. 88'), findsOneWidget);
    
    // Pastikan pesan "Belum ada jadwal" sudah hilang
    expect(find.text('Belum ada jadwal kunjungan.'), findsNothing);
  });
}