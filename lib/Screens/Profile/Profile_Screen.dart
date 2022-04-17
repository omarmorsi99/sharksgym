import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Screens/Login_Screen.dart';
import 'package:sharksgym/Screens/Profile/aboutus_page.dart';
import 'package:sharksgym/Screens/Profile/goal_page.dart';
import 'package:sharksgym/Screens/Profile/profiile_page.dart';
import 'package:sharksgym/Screens/Profile/training_page.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state) {
        return  DefaultTabController(
              length: 4,
             child: Scaffold(
                   appBar: AppBar(
       title: Text("Profile", style: GoogleFonts.hahmlet(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),),
    leading: IconButton(
    onPressed: () {
    Navigator.pop(context);
    },
    icon: const Icon(Icons.arrow_back_ios),),
    actions: [
    Badge(
    badgeContent: const Text('8',style: TextStyle(color: Colors.white),),
    badgeColor: Colors.white30,
    toAnimate: true,
    elevation: 15.0,
    position: BadgePosition.topEnd(top: 5,end: 0.5),
    child: IconButton(
    onPressed: (){
    },
    icon: const FaIcon(FontAwesomeIcons.stickyNote)),
    ),
    Badge(
    badgeContent: const Text('8',style: TextStyle(color: Colors.white),),
    badgeColor: Colors.white30,
    toAnimate: true,
    elevation: 15.0,
    position: BadgePosition.topEnd(top: 5,end: 0.5),
    child: IconButton(
    onPressed: (){
    },
    icon: const Icon(Icons.notifications_active)),
    ),
    TextButton(
    onPressed: (){
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Screen()));
    },
    child: const Icon(Icons.logout,color: Colors.white,),
    ),
    ],
    backgroundColor: Colors.redAccent,
    elevation: 20,
    titleSpacing: 10,

    bottom: const TabBar(
    indicatorColor: Colors.black,
    indicatorWeight: 5.0,
    tabs: [
    Tab(icon: Icon(Icons.account_circle), text: 'Profile'),
    Tab(icon: Icon(Icons.model_training_outlined), text: 'My Training'),
    Tab(icon: Icon(Icons.paste_rounded), text: 'Goals'),
    Tab(icon: Icon(Icons.fitness_center_outlined), text: 'About Us'),
    ],
    )
    ),
    body:  TabBarView(
    children: [
      profile_Page(),
    Training_Page(),
    goal_page(),
    about_us_page(),
    ],
    ),
    ),
    );
    },
    );

      }



  }

