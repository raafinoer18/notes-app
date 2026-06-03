# 📱 NoteVerse - Panduan Lengkap Setup & Build APK

## 🗂️ Struktur Project
```
notes_app/
├── lib/
│   ├── main.dart                  ← Titik masuk app
│   ├── models/
│   │   └── note.dart              ← Blueprint data catatan
│   ├── database/
│   │   └── database_helper.dart   ← Operasi SQLite (CRUD)
│   ├── theme/
│   │   ├── app_theme.dart         ← Warna & gaya tampilan
│   │   └── theme_provider.dart    ← Manajemen dark/light mode
│   ├── screens/
│   │   ├── splash_screen.dart     ← Layar pertama (2.5 detik)
│   │   ├── notes_list_screen.dart ← Halaman utama
│   │   └── note_editor_screen.dart← Halaman tambah/edit
│   └── widgets/
│       └── note_card.dart         ← Komponen kartu catatan
├── pubspec.yaml                   ← Konfigurasi & dependencies
└── android/                       ← File Android (otomatis)
```

---

## 🚀 Langkah 1: Buat Project Flutter Baru

1. Buka **Android Studio**
2. Pilih **New Flutter Project**
3. Pilih **Flutter Application**
4. Isi:
   - Project name: `notes_app`
   - Organization: `com.example`
   - Klik **Finish**

---

## 📋 Langkah 2: Salin File Code

Salin semua file berikut ke project kamu:

| File dari sini | Tujuan di project |
|---|---|
| `lib/main.dart` | Ganti `lib/main.dart` |
| `lib/models/note.dart` | Buat file baru |
| `lib/database/database_helper.dart` | Buat folder `database/`, buat file |
| `lib/theme/app_theme.dart` | Buat folder `theme/`, buat file |
| `lib/theme/theme_provider.dart` | Di folder `theme/` |
| `lib/screens/splash_screen.dart` | Buat folder `screens/`, buat file |
| `lib/screens/notes_list_screen.dart` | Di folder `screens/` |
| `lib/screens/note_editor_screen.dart` | Di folder `screens/` |
| `lib/widgets/note_card.dart` | Buat folder `widgets/`, buat file |

---

## 📦 Langkah 3: Update pubspec.yaml

Buka `pubspec.yaml` dan ganti isinya dengan file `pubspec.yaml` yang disediakan.

Atau tambahkan dependencies ini di bagian `dependencies:`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.9.0
  google_fonts: ^6.1.0
  shared_preferences: ^2.2.2
  intl: ^0.19.0
  provider: ^6.1.1
  flutter_staggered_animations: ^1.1.1
```

**PENTING**: Tambahkan `provider: ^6.1.1` - ini wajib ada!

---

## ⬇️ Langkah 4: Install Dependencies

Di terminal Android Studio (View > Tool Windows > Terminal):

```bash
flutter pub get
```

Tunggu sampai selesai. Ini akan download semua package yang dibutuhkan.

---

## 🧪 Langkah 5: Jalankan di Emulator/HP

1. Sambungkan HP Android atau jalankan emulator
2. Klik tombol ▶️ (Run) atau tekan `Shift + F10`
3. Pilih device yang mau dipakai
4. Tunggu sampai app terbuka

---

## 📱 Langkah 6: Build APK Release

### Via Terminal:
```bash
flutter build apk --release
```

### Output APK ada di:
```
build/app/outputs/flutter-apk/app-release.apk
```

### Via Android Studio:
1. **Build** menu → **Flutter** → **Build APK**
2. Pilih **release**
3. Tunggu proses selesai

---

## ✅ Fitur yang Sudah Ada

| Fitur | Status |
|---|---|
| ✅ Splash Screen | Animasi fade + scale |
| ✅ Halaman Daftar Catatan | Grid dengan animasi masuk |
| ✅ Tambah Catatan | Form dengan pilihan warna |
| ✅ Edit Catatan | Sama seperti form tambah |
| ✅ Hapus Catatan | Dengan dialog konfirmasi |
| ✅ Search Catatan | Real-time search |
| ✅ Database Lokal | SQLite via sqflite |
| ✅ Dark Mode | Toggle dengan preferensi tersimpan |
| ✅ Build APK Release | `flutter build apk --release` |

---

## 🐛 Troubleshooting

### Error: "provider not found"
→ Pastikan `provider: ^6.1.1` ada di pubspec.yaml, lalu `flutter pub get`

### Error: "intl locale not found"
→ Pastikan `await initializeDateFormatting('id_ID', null)` ada di main()

### APK tidak bisa diinstall di HP
→ Aktifkan "Install dari sumber tidak dikenal" di Pengaturan HP

### Build APK gagal
→ Coba `flutter clean` lalu `flutter pub get` lalu build ulang

---

## 💡 Tips Presentasi

1. Jelaskan alur: Splash → List → Add/Edit → Back
2. Demo search: cari kata yang ada di catatan
3. Demo dark/light toggle
4. Jelaskan struktur folder (MVC pattern)
5. Tunjukkan APK yang berhasil diinstall di HP fisik
