import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum PhotoOptions { camera, library }

class ChannelPage extends StatefulWidget {
  @override
  _ChannelPage createState() => _ChannelPage();
}

class _ChannelPage extends State<ChannelPage> {
  File? _image;
  final _formKey = GlobalKey<FormState>();

  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _selectPhotoFromPhotoLibrary() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void _selectPhotoFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void _optionSelected(PhotoOptions option) {
    switch (option) {
      case PhotoOptions.camera:
        _selectPhotoFromCamera();
        break;
      case PhotoOptions.library:
        _selectPhotoFromPhotoLibrary();
        break;
    }
  }

  void _saveIncident(BuildContext context) async {
    // validate the form
    if (_formKey.currentState!.validate()) {}
  }

  Widget _buildLoadingWidget() {
    return Text("Loading...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Channel"), backgroundColor: Colors.grey),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(
                      child: _image == null
                          ? Image.asset("assets/images/default.jpg")
                          : Image.asset(_image!.path),
                      width: 300,
                      height: 300),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {},
                      child: PopupMenuButton<PhotoOptions>(
                        child: Text("Add Photo"),
                        onSelected: _optionSelected,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Take a picture"),
                            value: PhotoOptions.camera,
                          ),
                          PopupMenuItem(
                              child: Text("Select from photo library"),
                              value: PhotoOptions.library)
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Title is required!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Enter your address"),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Description is required!";
                      }
                      return null;
                    },
                    maxLines: null,
                    decoration: InputDecoration(hintText: "Enter description"),
                  ),
                  TextButton(
                    child: Text("Submit"),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _saveIncident(context);
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  _buildLoadingWidget()
                ]),
              ),
            ),
          ),
        ));
  }
}
