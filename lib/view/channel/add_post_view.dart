import 'package:floodsafe/model/post.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/user.dart';
import '../../viewmodel/channel_view_model.dart';

class AddPostView extends StatefulWidget {
  final void Function(String content, PickedFile image) addPost;
  final ChannelViewModel viewModel;
  final UserModel user;

  const AddPostView({
    Key? key,
    required this.viewModel,
    required this.user,
    required this.addPost,
  }) : super(key: key);

  @override
  _AddPostViewState createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final TextEditingController _textController = TextEditingController();
  PickedFile? _pickedImage;

  Future<void> _pickImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = image;
    });
  }

  void _savePost() {
    final content = _textController.text;
    if (content.isNotEmpty && _pickedImage != null) {
      widget.viewModel.addPost(
          Post(
            content: content,
            place: widget.user.place,
            latitude: widget.user.latitude,
            longitude: widget.user.longitude,
            userId: widget.user.id,
            imageUrl: '',
            date: DateTime.now(),
            postStatus: 'active',
            name: widget.user.name,
          ),
          _pickedImage!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter your post',
              ),
            ),
            // Text('Name: ${widget.user.name}'), // Display user name
            Text('Address: ${widget.user.place}'), // Display user address

            SizedBox(height: 16),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.grey), // 원하는 색상으로 변경
              ),
              icon: Icon(Icons.image),
              label: Text('Choose Image'),
              onPressed: _pickImage,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.grey), // 원하는 색상으로 변경
              ),
              child: Text('Save'),
              onPressed: _savePost,
            ),
          ],
        ),
      ),
    );
  }
}
