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
    print('dog.dart fromMap: map = $map');
    return Dog(
      age: int.parse(map['age']),
      breed: map['breed'],
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'age': age, 'breed': breed, 'name': name};
  }

  // For debugging
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, breed: $breed, age: $age}';
  }
}
