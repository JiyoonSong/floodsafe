import 'package:floodsafe/model/post.dart';
import 'package:floodsafe/view/channel/add_post_view.dart';
import 'package:floodsafe/view/postPopup.dart';
import 'package:flutter/material.dart';
import 'package:floodsafe/model/user.dart';
import 'package:floodsafe/viewmodel/channel_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math' show sin, cos, sqrt, atan2;

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
      latitude: widget.user.latitude,
      longitude: widget.user.longitude,
      imageUrl: '',
      date: DateTime.now(),
      postStatus: 'active',
      name: widget.user.name,
      userId: widget.user.id,
    );

    await widget.viewModel.addPost(post, _pickedImage!);
    _textController.clear();
    setState(() {
      _pickedImage = null;
    });

    // Fetch posts again after adding a new post
    await widget.viewModel.fetchPosts();
  }

  Future<void> _reportPost(Post post) async {
    try {
      await widget.viewModel.reportPost(post);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reported successfully')),
      );
    } catch (e) {
      print('Error reporting post: $e');
    }
  }

  Future<void> _deletePost(Post post) async {
    try {
      await widget.viewModel.deletePost(post);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post deleted successfully')),
      );
      widget.viewModel.fetchPosts(); // Fetch posts after deleting
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

  double calculateDistance(
    double? lat1,
    double? lon1,
    double? lat2,
    double? lon2,
  ) {
    const double earthRadius = 6371; // Radius of the earth in kilometers

    // Convert degrees to radians
    double? lat1Rad = degreesToRadians(lat1);
    double? lon1Rad = degreesToRadians(lon1);
    double? lat2Rad = degreesToRadians(lat2);
    double? lon2Rad = degreesToRadians(lon2);

    double? dLat = lat2Rad - lat1Rad;
    double? dLon = lon2Rad - lon1Rad;

    double? a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
    double? c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double? distance = earthRadius * c;

    return distance;
  }

  double degreesToRadians(double? degrees) {
    if (degrees == null) {
      return 0.0; // Or any default value
    }
    return degrees * (3.141592653589793 / 180);
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
            height: 8,
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
                  // Sort by the latest date
                  activePosts.sort((a, b) => b.date.compareTo(a.date));

                  // Sort by the closest distance
                  final userLatitude = widget.user.latitude;
                  final userLongitude = widget.user.longitude;
                  activePosts.sort((a, b) {
                    final aDistance = calculateDistance(
                      userLatitude,
                      userLongitude,
                      a.latitude,
                      a.longitude,
                    );
                    final bDistance = calculateDistance(
                      userLatitude,
                      userLongitude,
                      b.latitude,
                      b.longitude,
                    );
                    return aDistance.compareTo(bDistance);
                  });
                  return ListView.builder(
                    itemCount: activePosts.length,
                    itemBuilder: (context, index) {
                      final post = activePosts[index];
                      final isMyPost = post.userId == widget.user.id;
                      return Column(
                        children: [
                          ListTile(
                            title: Text(post.content),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Place: ${post.place}'),
                                Text('Username: ${post.name}'),
                              ],
                            ),
                            trailing: isMyPost
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          _deletePost(post);
                                        },
                                      ),
                                    ],
                                  )
                                : IconButton(
                                    icon: Icon(Icons.report),
                                    onPressed: () {
                                      _reportPost(post);
                                    },
                                  ),
                            leading: post.imageUrl != null &&
                                    post.imageUrl.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PostPopup(
                                            imageUrl: post.imageUrl,
                                            description: post.content,
                                            place: post.place,
                                            date: post.date,
                                            name: post.name,
                                          );
                                        },
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        post.imageUrl!,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                          SizedBox(height: 16),
                        ],
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
