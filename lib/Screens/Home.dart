import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Post/Add_Post.dart';
import 'package:sharksgym/Screens/Login_Screen.dart';
import 'package:sharksgym/Screens/Profile/Profile_Screen.dart';
import 'package:sharksgym/Screens/Profile/Profile_View.dart';
class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if(state is AddPostState)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPost()));
          }
        },
        builder: (context,state)
        {

          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              leading: IconButton(
                onPressed: () {
                  if(AppCubit.get(context).currentUserRef.currentUser != null)
                   {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile_Screen()));
                     }
                  else {
                    Navigator.push(context,
                        PageTransition(type: PageTransitionType.leftToRight,
                            duration: const Duration(seconds: 2),
                            child: Login_Screen()));
                  }
                },
                icon: Badge(
                    badgeContent: const Text('16',style: TextStyle(color: Colors.white),),
                    badgeColor: Colors.white30,
                    toAnimate: true,
                    elevation: 15.0,
                    child: const FaIcon(FontAwesomeIcons.userEdit)),),

              actions: [
                IconButton(
                    onPressed: (){
                      showSearch(context: context,delegate: SearchData(),);
                    },
                    icon: Icon(Icons.search_rounded))
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              iconSize: 25.0,
              selectedItemColor: Colors.blue.withOpacity(0.4),
              unselectedItemColor: Colors.blue,
              showUnselectedLabels: true,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.social_distance_outlined,)
                    , label: 'Feed'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center_outlined,)
                  ,label: 'Workout',),
                BottomNavigationBarItem(
                  icon: Icon(Icons.upload_file_outlined,)
                  ,label: 'Add Post',),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_shopping_cart_outlined),
                    label: 'Product'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_sharp),
                    label: 'Admin'),
              ],
            ),
          );
        }
    );
  }
}


class SearchData extends SearchDelegate<String>
{
  @override
  List<Widget>? buildActions(BuildContext context) {

  }

  @override
  Widget? buildLeading(BuildContext context) {

  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('data');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? AppCubit.get(context).adminUsers : AppCubit.get(context).trainings;
    return ListView.builder(
        itemBuilder:(context,index) {
         return ListTile(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => profile_View(model: AppCubit.get(context).users[index])));
           },
            leading: CircleAvatar(child: Image.network(AppCubit.get(context).users[index].profileUrl.toString()),),
            title: Text('${AppCubit.get(context).users[index].userName}'),
          );
        },
        itemCount: suggestionList.length,
    );
  }
}
