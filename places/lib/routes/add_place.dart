import 'package:flutter/material.dart';
import 'package:places/widgets/image_input.dart';

class AddPlacesScreen extends StatefulWidget {
  const AddPlacesScreen({super.key});
  static const routeName = '/add-place';

  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _inputTitlecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(label: Text('Title')),
                      controller: _inputTitlecontroller,
                    ),
                    const SizedBox(height: 50),
                    const ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fixedSize: MaterialStateProperty.all<Size>(
                const Size.fromHeight(50),
              ),
            ),
          )
        ],
      ),
    );
  }
}
