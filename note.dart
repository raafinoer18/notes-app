// ============================================================
// FILE: lib/main.dart
// FUNGSI: Titik masuk utama aplikasi Flutter
// Semua aplikasi Flutter WAJIB punya main.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // State management
import 'package:intl/date_symbol_data_local.dart'; // untuk format tanggal Bahasa Indonesia
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';
import 'screens/splash_screen.dart';

// -------------------------------------------------------
// main() = fungsi pertama yang dipanggil saat app dimulai
// 'async' karena ada operasi asynchronous sebelum app berjalan
// -------------------------------------------------------
void main() async {
  // WidgetsFlutterBinding.ensureInitialized() WAJIB dipanggil
  // sebelum kode async lain jika ada operasi sebelum runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi format tanggal Bahasa Indonesia
  // Sehingga bisa tampilkan: "23 Mei 2026" bukan "23 May 2026"
  await initializeDateFormatting('id_ID', null);

  // Paksa aplikasi hanya di mode portrait (vertikal)
  // Tidak bisa diputar landscape
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // runApp() = mulai jalankan aplikasi Flutter
  // Semua widget Flutter berada di dalam runApp
  runApp(const MyApp());
}

// -------------------------------------------------------
// MyApp = root widget aplikasi
// Semua widget lain adalah "turunan" dari MyApp
// -------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider = menyediakan ThemeProvider
    // ke semua widget di bawahnya dalam widget tree
    // 'Provider' adalah package untuk state management
    return ChangeNotifierProvider(
      // create = cara membuat instance ThemeProvider
      // context tidak dipakai di sini tapi wajib ada sebagai parameter
      create: (_) => ThemeProvider(),

      // Consumer = widget yang "mengkonsumsi" / membaca data Provider
      // Setiap kali ThemeProvider berubah, Consumer rebuild
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            // title = nama app yang muncul di task manager HP
            title: 'NoteVerse',

            // debugShowCheckedModeBanner = hilangkan banner "DEBUG"
            // di pojok kanan atas saat development
            debugShowCheckedModeBanner: false,

            // Pilih tema berdasarkan preferensi user
            theme: AppTheme.lightTheme, // tema terang
            darkTheme: AppTheme.darkTheme, // tema gelap
            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark // pakai dark
                : ThemeMode.light, // pakai light

            // Halaman pertama yang muncul saat app dibuka
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
