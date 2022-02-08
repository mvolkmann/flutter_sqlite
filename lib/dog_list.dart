import 'package:flutter/material.dart';
import './dog.dart';
import './dog_service.dart';

class DogList extends StatefulWidget {
  final List<Dog> dogs;
  final Function onDelete;

  DogList({
    required this.dogs,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<DogList> createState() => _DogListState();
}

class _DogListState extends State<DogList> {
  @override
  Widget build(BuildContext context) {
    var dogs = widget.dogs;
    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, index) => ListTile(
          title: Text(dogs[index].name),
          subtitle: Text(dogs[index].breed),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => widget.onDelete(dogs[index]),
          ),
        ),
        separatorBuilder: (_, index) => Divider(thickness: 1),
        itemCount: dogs.length,
      ),
    );
  }
}
