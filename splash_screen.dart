// ============================================================
// FILE: lib/theme/app_theme.dart
// FUNGSI: Mengatur tampilan visual aplikasi (warna, font, dsb)
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // font dari Google

class AppTheme {
  // -------------------------------------------------------
  // WARNA-WARNA APLIKASI
  // static = bisa diakses tanpa membuat object AppTheme
  // const = nilai tidak berubah, lebih efisien
  // Color(0xFF...) = warna dalam format hex
  // 0xFF = prefix wajib, lalu 6 digit hex warna
  // -------------------------------------------------------

  // === DARK MODE COLORS ===
  static const Color darkBg = Color(0xFF0A0A0F); // hitam sangat gelap
  static const Color darkSurface = Color(0xFF13131A); // sedikit lebih terang
  static const Color darkCard = Color(0xFF1A1A25); // warna kartu catatan
  static const Color darkBorder = Color(0xFF2A2A3F); // garis border

  // === ACCENT / WARNA AKSEN ===
  static const Color accentPurple = Color(0xFF7C5CBF); // ungu utama
  static const Color accentBlue = Color(0xFF4A90D9); // biru
  static const Color accentTeal = Color(0xFF2DD4BF); // teal/hijau-biru
  static const Color accentPink = Color(0xFFEC4899); // pink
  static const Color accentOrange = Color(0xFFF97316); // oranye

  // === LIGHT MODE COLORS ===
  static const Color lightBg = Color(0xFFF8F7FF); // putih keunguan
  static const Color lightSurface = Color(0xFFFFFFFF); // putih
  static const Color lightCard = Color(0xFFEEECFF); // kartu warna lavender

  // === WARNA TEKS ===
  static const Color textPrimary = Color(0xFFE8E8F0); // teks terang (dark mode)
  static const Color textSecondary = Color(0xFF9898B0); // teks abu-abu
  static const Color textDark = Color(0xFF1A1A2E); // teks gelap (light mode)

  // -------------------------------------------------------
  // DAFTAR WARNA untuk pilihan warna catatan
  // User bisa memilih warna kartu catatannya
  // -------------------------------------------------------
  static const List<Color> noteColors = [
    Color(0xFF1A1A25), // default dark
    Color(0xFF1A2535), // dark blue
    Color(0xFF251A35), // dark purple
    Color(0xFF1A2520), // dark green
    Color(0xFF35251A), // dark brown
    Color(0xFF251A20), // dark pink
  ];

  // -------------------------------------------------------
  // LIGHT THEME: tampilan terang
  // ThemeData = semua pengaturan tema Flutter
  // -------------------------------------------------------
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true, // pakai Material Design 3 (yang terbaru)
    brightness: Brightness.light, // mode terang

    // ColorScheme = skema warna yang dipakai di seluruh app
    colorScheme: ColorScheme.light(
      primary: accentPurple, // warna utama
      secondary: accentTeal, // warna sekunder
      surface: lightSurface, // warna permukaan
      background: lightBg, // warna latar
      onPrimary: Colors.white, // teks di atas warna primary
      onSurface: textDark, // teks di atas surface
    ),

    // textTheme = gaya teks di seluruh aplikasi
    // GoogleFonts.plusJakartaSans = font modern dari Google
    textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
      bodyColor: textDark,
      displayColor: textDark,
    ),

    scaffoldBackgroundColor: lightBg, // warna background halaman
  );

  // -------------------------------------------------------
  // DARK THEME: tampilan gelap (default kita)
  // -------------------------------------------------------
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark, // mode gelap

    colorScheme: ColorScheme.dark(
      primary: accentPurple,
      secondary: accentTeal,
      surface: darkSurface,
      background: darkBg,
      onPrimary: Colors.white,
      onSurface: textPrimary,
    ),

    textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
      bodyColor: textPrimary,
      displayColor: textPrimary,
    ),

    scaffoldBackgroundColor: darkBg,
  );
}
