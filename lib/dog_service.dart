import 'package:sqflite/sqflite.dart';
import './dog.dart';

class DogService {
  final Database database;

  DogService({required this.database});

  Future<void> create(Dog dog) async {
    await database.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(int id) async {
    await database.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Dog>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query('dogs');
    return List.generate(maps.length, (index) {
      var map = maps[index];
      return Dog(
        id: map['id'],
        age: map['age'],
        breed: map['breed'],
        name: map['name'],
      );
    });
  }

  Future<void> update(Dog dog) async {
    await database.update(
      'dogs',
      dog.toMap(),
      where: 'id = ?',
      // This prevents SQL injection.
      whereArgs: [dog.id],
    );
  }
}
