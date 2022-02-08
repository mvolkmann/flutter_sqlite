class Dog {
  int? id;
  int age;
  String breed;
  String name;

  Dog({
    this.id,
    required this.age,
    required this.breed,
    required this.name,
  });

  static Dog fromMap(Map<String, dynamic> map) {
    return Dog(
      age: _toInt(map['age']),
      breed: map['breed'],
      id: map['id'],
      name: map['name'],
    );
  }

  static _toInt(dynamic value) => value is int ? value : int.parse(value);

  Map<String, dynamic> toMap() {
    return {'id': id, 'age': age, 'breed': breed, 'name': name};
  }

  // For debugging
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, breed: $breed, age: $age}';
  }
}
