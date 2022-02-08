import 'package:flutter/material.dart';
import './dog.dart';
import './dog_form.dart';
import './extensions/widget_extensions.dart';

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
    return ListView.separated(
      itemBuilder: (_, index) => ListTile(
        title: Text(dogs[index].name),
        subtitle: Text(dogs[index].breed),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => widget.onDelete(dogs[index]),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DogForm(
                dog: dogs[index],
                onUpdate: widget.onUpdate,
              ),
            ),
          ).then((_) {
            // This is called when navigation returns to this page.
            // The argument will be null.
            // Calling setState forces this widget to call build again
            // which is needed if the value of dog.like changed.
            setState(() {});
          });
        },
      ),
      separatorBuilder: (_, index) => Divider(thickness: 1),
      itemCount: dogs.length,
    ).expanded;
  }
}
