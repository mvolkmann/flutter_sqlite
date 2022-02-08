import 'package:flutter/material.dart';

import './dog.dart';
import './extensions/widget_extensions.dart';

class DogForm extends StatefulWidget {
  final Dog dog;

  DogForm({required this.dog, Key? key}) : super(key: key);

  @override
  State<DogForm> createState() => _DogFormState();
}

class _DogFormState extends State<DogForm> {
  final _dirty = true;

  @override
  Widget build(BuildContext context) {
    var dog = widget.dog;
    return Scaffold(
      appBar: AppBar(title: Text(dog.name), actions: [
        TextButton(
          child: Text(
            'Update',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: _dirty ? _update : null,
        ),
      ]),
      body: Form(
        child: Column(
          children: [
            _buildInput(label: 'Name', value: dog.name),
            _buildInput(label: 'Breed', value: dog.breed),
            _buildInput(
              label: 'Age',
              value: dog.age.toString(),
              inputType: TextInputType.number,
            ),
          ],
        ).gap(10),
      ).padding(20),
    );
  }

  Widget _buildInput({
    required String label,
    required String value,
    TextInputType? inputType,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      initialValue: value,
      keyboardType: inputType,
    );
  }

  void _update() {
    print('dog_form.dart _update: entered');
  }
}
