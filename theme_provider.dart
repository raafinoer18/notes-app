// ============================================================
// FILE: lib/database/database_helper.dart
// FUNGSI: Semua operasi database SQLite (CRUD)
// C = Create (tambah), R = Read (baca), U = Update (edit), D = Delete (hapus)
// ============================================================

// Import library yang dibutuhkan
import 'package:sqflite/sqflite.dart'; // library SQLite untuk Flutter
import 'package:path/path.dart'; // library untuk path/alamat file
import '../models/note.dart'; // import model Note yang sudah kita buat

class DatabaseHelper {
  // -------------------------------------------------------
  // SINGLETON PATTERN
  // Artinya: kelas ini hanya boleh punya SATU instance saja
  // di seluruh aplikasi. Hemat memori dan konsisten.
  // -------------------------------------------------------

  // '_instance' adalah satu-satunya object DatabaseHelper
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Factory constructor: setiap kali orang tulis DatabaseHelper(),
  // mereka SELALU dapat object yang sama (si _instance itu)
  factory DatabaseHelper() => _instance;

  // Constructor private - hanya bisa dipanggil dari dalam kelas ini
  // '_internal' adalah nama bebas, tanda underscore = private
  DatabaseHelper._internal();

  // Objek Database yang akan kita pakai
  // '?' artinya bisa null (belum dibuka)
  static Database? _database;

  // Konstanta nama database dan tabel
  static const String _databaseName = 'notes_modern.db';
  static const String _tableName = 'notes';
  static const int _databaseVersion = 1;

  // -------------------------------------------------------
  // GETTER: database
  // Getter adalah cara mengakses nilai seperti property
  // tapi bisa ada logika di dalamnya
  // 'async' = asynchronous, tidak blocking aplikasi
  // 'Future' = hasil yang akan datang (belum ada sekarang)
  // -------------------------------------------------------
  Future<Database> get database async {
    // Jika database sudah ada, langsung kembalikan
    if (_database != null) return _database!;

    // Jika belum ada, buat database baru
    _database = await _initDatabase();
    return _database!;
  }

  // -------------------------------------------------------
  // METHOD: _initDatabase()
  // Membuka/membuat file database di storage HP
  // -------------------------------------------------------
  Future<Database> _initDatabase() async {
    // getDatabasesPath() = mendapatkan folder khusus database di HP
    // Biasanya di: /data/data/com.example.notes_app/databases/
    final databasesPath = await getDatabasesPath();

    // join() = menggabungkan path: folder + nama file
    // Hasil: /data/data/com.example.notes_app/databases/notes_modern.db
    final path = join(databasesPath, _databaseName);

    // openDatabase() = membuka file database
    // Jika belum ada, otomatis dibuat
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createTable, // panggil fungsi ini saat database baru dibuat
    );
  }

  // -------------------------------------------------------
  // METHOD: _createTable()
  // Membuat tabel 'notes' di database
  // Dipanggil SEKALI SAJA saat database pertama kali dibuat
  // -------------------------------------------------------
  Future<void> _createTable(Database db, int version) async {
    // SQL = bahasa untuk database
    // CREATE TABLE = perintah membuat tabel baru
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID otomatis bertambah
        title TEXT NOT NULL,                   -- Judul, tidak boleh kosong
        content TEXT NOT NULL,                 -- Isi, tidak boleh kosong
        color INTEGER NOT NULL DEFAULT 0,      -- Warna catatan
        created_at TEXT NOT NULL,              -- Tanggal dibuat
        updated_at TEXT NOT NULL               -- Tanggal diubah
      )
    ''');
  }

  // ============================================================
  // C - CREATE: Menyimpan catatan baru ke database
  // Mengembalikan ID catatan yang baru dibuat
  // ============================================================
  Future<int> insertNote(Note note) async {
    // Dapatkan referensi database
    final db = await database;

    // insert() = memasukkan data baru ke tabel
    // conflictAlgorithm = apa yang dilakukan jika ada konflik ID
    // ConflictAlgorithm.replace = timpa data lama jika ID sama
    return await db.insert(
      _tableName,
      note.toMap(), // ubah Note menjadi Map dulu
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ============================================================
  // R - READ: Membaca SEMUA catatan dari database
  // Mengembalikan List (daftar) berisi semua catatan
  // ============================================================
  Future<List<Note>> getAllNotes() async {
    final db = await database;

    // query() = mengambil data dari tabel
    // orderBy: urut berdasarkan updated_at terbaru (DESC = terbaru di atas)
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'updated_at DESC', // catatan terbaru muncul paling atas
    );

    // Ubah setiap Map menjadi objek Note menggunakan fromMap()
    // '.map()' = proses setiap item dalam list
    // '.toList()' = ubah hasilnya menjadi List biasa
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  // ============================================================
  // R - READ: Mencari catatan berdasarkan kata kunci
  // 'query' = kata yang dicari user
  // ============================================================
  Future<List<Note>> searchNotes(String query) async {
    final db = await database;

    // LIKE = SQL untuk pencarian yang mengandung teks tertentu
    // '%$query%' = apapun sebelum dan sesudah kata kunci
    // Contoh: '%belajar%' akan menemukan "ayo belajar flutter"
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'title LIKE ? OR content LIKE ?', // cari di judul ATAU isi
      whereArgs: ['%$query%', '%$query%'], // '?' diganti dengan ini
      orderBy: 'updated_at DESC',
    );

    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  // ============================================================
  // U - UPDATE: Mengubah catatan yang sudah ada
  // ============================================================
  Future<int> updateNote(Note note) async {
    final db = await database;

    // update() = mengubah data yang sudah ada
    // where: hanya update catatan dengan ID ini
    // whereArgs: nilai untuk '?' di where
    return await db.update(
      _tableName,
      note.toMap(),
      where: 'id = ?', // kondisi: ID harus sama
      whereArgs: [note.id], // ID catatan yang mau diubah
    );
  }

  // ============================================================
  // D - DELETE: Menghapus catatan berdasarkan ID
  // ============================================================
  Future<int> deleteNote(int id) async {
    final db = await database;

    // delete() = menghapus data dari tabel
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // -------------------------------------------------------
  // METHOD: getNoteCount()
  // Menghitung total jumlah catatan
  // -------------------------------------------------------
  Future<int> getNoteCount() async {
    final db = await database;
    // rawQuery = SQL bebas yang lebih kompleks
    // COUNT(*) = hitung semua baris
    final result = await db.rawQuery('SELECT COUNT(*) FROM $_tableName');
    // 'Sqflite.firstIntValue' = ambil angka pertama dari hasil query
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
