import 'package:floodsafe/view/postPopup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';
import '../../model/post.dart';
import '../../viewmodel/channel_view_model.dart';

class AdminPage extends StatelessWidget {
  final UserModel user;

  AdminPage({required this.user});

  @override
  Widget build(BuildContext context) {
    final channelViewModel = Provider.of<ChannelViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Colors.grey,
      ),
      body: StreamBuilder<List<Post>>(
        stream: channelViewModel.postsStream,
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post> inactivePosts = snapshot.data!
                .where((post) => post.postStatus == 'reported')
                .toList();

            return ListView.builder(
              itemCount: inactivePosts.length,
              itemBuilder: (BuildContext context, int index) {
                Post post = inactivePosts[index];

                return ListTile(
                  title: Text(post.content),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Place: ${post.place}'),
                      Text('User: ${post.name}'),
                    ],
                  ),
                  leading: post.imageUrl != null && post.imageUrl.isNotEmpty
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
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
