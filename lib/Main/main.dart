import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AuthenticationCubit.dart';
import 'package:sharksgym/Screens/Home.dart';
import 'package:sharksgym/Screens/Login_Screen.dart';
import 'package:sharksgym/shared/BlocObserver.dart';

import '../Screens/Register_Screen.dart';

Future<void> main() async {
    BlocOverrides.runZoned(() {
    }, blocObserver: SimpleBlocObserver());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((event) {

  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final currentUserRef = FirebaseAuth.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(create: (context) => AppCubit()..getAdminPosts()..getUserData()..getProducts(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        ),
        home: currentUserRef.currentUser != null ? Home_Screen() : Login_Screen(),
      ),
    );
  }
}



