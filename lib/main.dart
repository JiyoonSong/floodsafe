import 'package:firebase_auth/firebase_auth.dart';
import 'package:floodsafe/view/auth/login_view.dart';
import 'package:floodsafe/viewmodel/channel_view_model.dart';
import 'package:floodsafe/viewmodel/volunteer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  //await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 앱 초기화

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VolunteerViewModel()),
      ],
      child: MaterialApp(
        title: 'FloodSafe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginView(),
      ),
    );
  }
}
