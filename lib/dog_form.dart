import 'package:flutter/material.dart';

import './dog.dart';
import './extensions/widget_extensions.dart';

class DogForm extends StatefulWidget {
  final Dog dog;
  final Function onUpdate;

  DogForm({
    required this.dog,
    required this.onUpdate,
    Key? key,
  }) : super(key: key);

  @override
  State<DogForm> createState() => _DogFormState();
}

class _DogFormState extends State<DogForm> {
  var _dirty = false;
  var _map = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    _map = widget.dog.toMap();
  }

  @override
  Widget build(BuildContext context) {
    var dog = widget.dog;
    return Scaffold(
      appBar: AppBar(title: Text(dog.name), actions: [
        if (_dirty)
          TextButton(
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _update,
          ),
      ]),
      body: Form(
        child: Column(
          children: [
            _buildInput(label: 'Name', property: 'name'),
            _buildInput(label: 'Breed', property: 'breed'),
            _buildInput(
              label: 'Age',
              property: 'age',
              inputType: TextInputType.number,
            ),
          ],
        ).gap(10),
      ).padding(20),
    );
  }

  Widget _buildInput({
    required String label,
    required String property,
    TextInputType? inputType,
  }) {
    var value = _map[property].toString();
    var keyboardType = value is int ? TextInputType.number : TextInputType.text;
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      initialValue: value,
      keyboardType: keyboardType,
      onChanged: (value) {
        _map[property] = value;
        setState(() => _dirty = true);
      },
    );
  }

  void _update() {
    var dog = Dog.fromMap(_map);
    widget.onUpdate(dog);
    Navigator.pop(context);
  }
}
