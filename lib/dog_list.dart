import 'package:flutter/material.dart';
import './dog.dart';
import './dog_form.dart';

class DogList extends StatefulWidget {
  final List<Dog> dogs;
  final Function onDelete;
  final Function onUpdate;

  DogList({
    required this.dogs,
    required this.onDelete,
    required this.onUpdate,
    Key? key,
  }) : super(key: key);

  @override
  State<DogList> createState() => _DogListState();
}

class _DogListState extends State<DogList> {
  @override
  Widget build(BuildContext context) {
    var dogs = widget.dogs;
    dogs.sort((d1, d2) => d1.name.compareTo(d2.name));

    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, index) => _buildTile(dogs[index]),
        itemCount: dogs.length,
        /* When using ReorderableListView.builder ...
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) newIndex--;
          setState(() {
            var dog = dogs.removeAt(oldIndex);
            dogs.insert(newIndex, dog);
          });
        },
        */
        separatorBuilder: (_, index) => Divider(thickness: 1),
      ),
    );
  }

  Widget _buildTile(Dog dog) {
    var subtitle = '${dog.breed} - age ${dog.age}';
    return ListTile(
      title: Text(dog.name),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => widget.onDelete(dog),
      ),
      onTap: () => _goToForm(dog),
    );
  }

  void _goToForm(Dog dog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DogForm(
          dog: dog,
          onUpdate: widget.onUpdate,
        ),
      ),
    );
  }
}
