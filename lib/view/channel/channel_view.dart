import 'package:floodsafe/model/post.dart';
import 'package:floodsafe/view/channel/add_post_view.dart';
import 'package:flutter/material.dart';
import 'package:floodsafe/model/user.dart';
import 'package:floodsafe/viewmodel/channel_view_model.dart';
import 'package:image_picker/image_picker.dart';

class ChannelView extends StatefulWidget {
  final ChannelViewModel viewModel;
  final UserModel user;

  ChannelView({required this.viewModel, required this.user});

  @override
  _ChannelViewState createState() => _ChannelViewState();
}

class _ChannelViewState extends State<ChannelView> {
  final TextEditingController _textController = TextEditingController();
  PickedFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchPosts();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = image;
    });
  }

  Future<void> _addPost() async {
    if (_textController.text.isEmpty || _pickedImage == null) {
      return;
    }

    final post = Post(
      content: _textController.text,
      place: widget.user.place,
      imageUrl: '', // Initialize imageUrl
      date: DateTime.now(), // Initialize date
      postStatus: 'active', // Initialize postStatus
      name: widget.user.name, // Add username
      userId: widget.user.id,
    );

    final uploadTask = widget.viewModel.addPost(post, _pickedImage!);

    uploadTask.whenComplete(() {
      _textController.clear();
      setState(() {
        _pickedImage = null;
      });
    }).catchError((error) {
      // 업로드 실패 시 에러 처리
      print('Error uploading image: $error');
    });
  }

  Future<void> _reportPost(Post post) async {
    try {
      await widget.viewModel.reportPost(post);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('reported successfully')),
      );
    } catch (e) {
      print('Error reporting post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // 배경색을 흰색으로 변경
        title: Text(
          'Channel',
          style: TextStyle(
            color: Colors.black, // 글씨색을 검정색으로 변경
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPostView(
                    viewModel: widget.viewModel,
                    user: widget.user,
                    addPost: (String content, PickedFile image) {
                      _addPost();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8, // 원하는 간격 크기로 조정
          ),
          Expanded(
            child: StreamBuilder<List<Post>>(
              stream: widget.viewModel.postsStream, // 수정된 부분: 스트림 사용
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final posts = snapshot.data!;
                  final activePosts = posts
                      .where((post) => post.postStatus == 'active')
                      .toList();
                  return ListView.builder(
                    itemCount: activePosts.length,
                    itemBuilder: (context, index) {
                      final post = activePosts[index];
                      return ListTile(
                        title: Text(post.content),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Place: ${widget.user.place}'),
                            // Text('Username: ${widget.user.name}'),
                          ],
                        ),
                        trailing: post.userId != widget.user.id
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(
                                  //   icon: Icon(Icons.delete),
                                  //   onPressed: () {
                                  //     widget.viewModel.deletePost(post);
                                  //   },
                                  // ),
                                  IconButton(
                                    icon: Icon(Icons.report),
                                    onPressed: () {
                                      _reportPost(post);
                                    },
                                  ),
                                ],
                              )
                            : null,
                        leading:
                            post.imageUrl != null && post.imageUrl.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      post.imageUrl!,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : SizedBox.shrink(),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
