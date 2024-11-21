import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/contact.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'contacts.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT,
            name TEXT,
            gender TEXT,
            email TEXT,
            rating REAL,
            address TEXT,
            city TEXT,
            state TEXT,
            zipCode TEXT,
            phone TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveContact(String userId, Contact contact) async {
    final db = await database;
    await db.insert(
      'contacts',
      {
        'userId': userId,
        ...contact.toMap(), // Convert contact to Map before saving
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>> getContacts(String userId) async {
    final db = await database;
    final result = await db.query(
      'contacts',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return result.map((map) => Contact.fromMap(map)).toList();
  }
}
