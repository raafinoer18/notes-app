// ============================================================
// FILE: lib/theme/theme_provider.dart
// FUNGSI: Mengatur dan menyimpan preferensi dark/light mode
// Menggunakan ChangeNotifier = memberitahu widget saat ada perubahan
// ============================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // untuk simpan preferensi

// ChangeNotifier = kelas yang bisa "memberitahu" widget lain
// saat ada perubahan. Ini bagian dari pattern "Provider"
class ThemeProvider extends ChangeNotifier {
  // Key untuk menyimpan di SharedPreferences
  // Seperti nama variabel di "local storage" HP
  static const String _themeKey = 'is_dark_mode';

  // Status dark mode: true = gelap, false = terang
  // Default: true (kita pakai dark mode sebagai default)
  bool _isDarkMode = true;

  // GETTER: cara mengakses nilai _isDarkMode dari luar
  // Gunakan: themeProvider.isDarkMode
  bool get isDarkMode => _isDarkMode;

  // Constructor: dipanggil saat ThemeProvider pertama dibuat
  // Langsung load preferensi tersimpan dari HP
  ThemeProvider() {
    _loadThemePreference();
  }

  // -------------------------------------------------------
  // METHOD: _loadThemePreference()
  // Membaca preferensi dark mode dari storage HP
  // Jadi saat app dibuka ulang, tema tersimpan
  // -------------------------------------------------------
  Future<void> _loadThemePreference() async {
    // SharedPreferences = seperti "settings" yang tersimpan di HP
    final prefs = await SharedPreferences.getInstance();

    // getBool() = ambil nilai boolean, defaultnya true jika belum ada
    _isDarkMode = prefs.getBool(_themeKey) ?? true;

    // notifyListeners() = kasih tahu semua widget yang mendengarkan
    // bahwa ada perubahan, mereka harus rebuild
    notifyListeners();
  }

  // -------------------------------------------------------
  // METHOD: toggleTheme()
  // Dipanggil saat user menekan tombol ganti tema
  // -------------------------------------------------------
  Future<void> toggleTheme() async {
    // Balik nilai: jika true jadi false, jika false jadi true
    _isDarkMode = !_isDarkMode;

    // Simpan ke storage HP supaya tersimpan saat app ditutup
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);

    // Beritahu semua widget untuk rebuild dengan tema baru
    notifyListeners();
  }
}
