// lib/database_helper.dart
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'donor.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE donors(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        email TEXT,
        sex TEXT,
        sex1 Text,
        last date TEXT
      )
    ''');
  }

  Future<int> insertDonor(Map<String, dynamic> donor) async {
    final db = await database;
    return await db.insert('donors', donor);
  }


  Future<int> deleteDonor(int id) async {
    final db = await database;
    return await db.delete(
      'donors',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<List<Map<String, dynamic>>> getDonors() async {
    final db = await database;
    return await db.query('donors');
  }
}