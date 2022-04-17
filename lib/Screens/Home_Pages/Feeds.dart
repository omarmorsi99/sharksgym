import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/PostModel.dart';
import 'package:sharksgym/Post/dislay_Comments.dart';
import 'package:sharksgym/Screens/Profile/Profile_View.dart';
import '../../Post/display_Likes.dart';
class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getAdminPosts();
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
      return  ConditionalBuilder(
        condition: AppCubit.get(context).adminPosts.isNotEmpty && AppCubit.get(context).adminUsers.isNotEmpty,
        builder: (BuildContext context) {
        return  SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              children: [
                Stack(
                  children: const [
                    SizedBox(
                      width: double.infinity,
                      height: 220,
                      child: Card(
                        child: Image(image: AssetImage('assets/images/logo.jpg'),
                        fit: BoxFit.cover,),
                      ),
                    ),
                  ],
                ),
                ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics:  const BouncingScrollPhysics(),
          itemBuilder: (context,index) {
                        return buildPostItem(context,AppCubit.get(context).adminPosts[index], index);
          },
                    separatorBuilder: (context,index) => const SizedBox(
                      height: 8,
                    ),
                    itemCount: AppCubit.get(context).adminPosts.length),
              ],
            ),
        );


        },
        fallback: (BuildContext context) {
          return Column(
            children: const [
              SizedBox(
                width: double.infinity,
                height: 220,
                child: Card(
                  child: Image(image: AssetImage('assets/images/logo.jpg'),
                    fit: BoxFit.cover,),
                ),
              ),
              SizedBox(height: 10,),
              Center(child: CircularProgressIndicator(),)
            ],
          );
        },
      );
      },
    );
  }
}

Widget buildPostItem(BuildContext context, post_model postModel,int index) {
  AppCubit.get(context).getLikeAdminPostCount(postModel);
  AppCubit.get(context).getUserFromPost(postModel.ownerId!);
  var commentController = TextEditingController();
  if(AppCubit.get(context).userModel!.isAdmin == true) {
    return Slidable(
    key: const ValueKey(1),

    // The start action pane is the one at the left or the top side.
    startActionPane:  ActionPane(
      // A motion is a widget used to control how the pane animates.
      motion: const ScrollMotion(),

      // All actions are defined in the children parameter.
      children: [
        // A SlidableAction can have an icon and/or a label.
        SlidableAction(
          onPressed: (context){
           AppCubit.get(context).deleteAdminPost( model: postModel);
           showToast(text: 'Post Deleted');

          },
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
        SlidableAction(
          onPressed: (context){},
          backgroundColor: const Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          icon: Icons.share,
          label: 'Share',
        ),
      ],
    ),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${postModel.userUrl}'),
                  ),
                ),
                const SizedBox(width: 20.0,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => profile_View(model: AppCubit.get(context).userDisplay!)));
                        },
                        child: Row(
                          children: [
                            Text('${postModel.userName}', style: GoogleFonts.hahmlet(
                              fontSize: 18,
                              height: 1.3,
                              color: Colors.black,

                            ), ),
                            const SizedBox(width: 5.0,),
                            const Icon(Icons.check_circle_outline_sharp,  size: 16.0,color: Colors.blue,),
                          ],
                        ),
                      ),

                      const SizedBox(height: 5,),
                      Text(postModel.timeStamp.toString(),

                        style: GoogleFonts.hahmlet(
                            fontSize: 12,
                            height: 1.3,
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold
                        ), ),

                    ],
                  ),
                ),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.more_horiz_outlined)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('${postModel.description}',
                style: GoogleFonts.hahmlet(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            if(postModel.mediaUrl != '')
              InkWell(
                onTap: (){
                  postPopup(context,postModel,Colors.blue);
                },
                child: Container(
                  height: 180.0,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image:  DecorationImage(
                      image: NetworkImage('${postModel.mediaUrl}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  InkWell(
                    child:  Row(
                      children: [
                        IconButton(
                          color: Colors.blue,
                          onPressed: () {
                            // likePopup(context, postModel,  Colors.blue,);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => displayLikes(model: postModel)));
                          },
                          icon: const FaIcon(FontAwesomeIcons.heartbeat,
                            color: Colors.blue,
                          ),
                        ),
                        Text('Likes' , style: GoogleFonts.hahmlet(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                        ),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         IconButton(
                           color: Colors.blue,
                           onPressed: () {
                             // commentPopup(context, postModel,  Colors.blue,);
                             Navigator.push(context, MaterialPageRoute(builder: (context) => displayCommentScreen(model: postModel)));
                           },
                           icon: const FaIcon(FontAwesomeIcons.rocketchat,
                      color: Colors.blue,
                    ),
                         ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: (){},
                  child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.profileUrl}'),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                               showToast(text: 'Comment Cannot be empty');
                              }
                            },

                          controller: commentController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          onFieldSubmitted: (value){
                          },
                          decoration:  const InputDecoration(
                            focusColor: Colors.redAccent,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: InputBorder.none,

                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          AppCubit.get(context).commentAdminPost(
                              model: postModel,
                              comment: commentController.text,
                              dateTime: DateTime.now().toString()
                          );

               } ,
                        child:  Text('comment',style: GoogleFonts.hahmlet(
                          fontSize: 12,
                          color: Colors.white,
                          backgroundColor: Colors.blue
                        ),),
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () async {
                    showToast(text: 'Post Liked');
                   AppCubit.get(context).likeAdminPost(postModel);
                   AppCubit.get(context).getLikeAdminPostCount(postModel);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const FaIcon(FontAwesomeIcons.heartbeat,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 5.0,),
                      Text('Like', style: GoogleFonts.hahmlet(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      ),),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    ),
  );
  }
  else{
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${postModel.userUrl}'),
                  ),
                ),
                const SizedBox(width: 20.0,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => profile_View(model: AppCubit.get(context).userDisplay!)));
                        },
                        child: Row(
                          children: [
                            Text('${postModel.userName}', style: GoogleFonts.hahmlet(
                              fontSize: 18,
                              height: 1.3,
                              color: Colors.black,

                            ), ),
                            const SizedBox(width: 5.0,),
                            const Icon(Icons.check_circle_outline_sharp,  size: 16.0,color: Colors.blue,),
                          ],
                        ),
                      ),

                      const SizedBox(height: 5,),
                      Text(postModel.timeStamp.toString(),

                        style: GoogleFonts.hahmlet(
                            fontSize: 12,
                            height: 1.3,
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold
                        ), ),

                    ],
                  ),
                ),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.more_horiz_outlined)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('${postModel.description}',
                style: GoogleFonts.hahmlet(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            if(postModel.mediaUrl != '')
              InkWell(
                onTap: (){
                  postPopup(context,postModel,Colors.blue);
                },
                child: Container(
                  height: 180.0,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image:  DecorationImage(
                      image: NetworkImage('${postModel.mediaUrl}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  InkWell(
                    child:  IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        // likePopup(context, postModel,  Colors.blue,);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => displayLikes(model: postModel)));
                      },
                      icon: const Icon(Icons.monitor_heart_sharp),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          color: Colors.blue,
                          onPressed: () {
                            // commentPopup(context, postModel,  Colors.blue,);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => displayCommentScreen(model: postModel)));
                          },
                          icon: const Icon(Icons.mark_chat_unread_rounded),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: (){},
                  child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.profileUrl}'),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    onFieldSubmitted: (value){
                    },
                    decoration:  const InputDecoration(
                      focusColor: Colors.redAccent,
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: InputBorder.none,

                    ),
                  ),
                ),
                Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        AppCubit.get(context).commentAdminPost(
                            model: postModel,
                            comment: commentController.text,
                            dateTime: DateTime.now().toString()
                        );


                      } ,
                      child:  Text('Comment',style: GoogleFonts.hahmlet(
                          fontSize: 10,
                          color: Colors.white,
                          backgroundColor: Colors.blue
                      ),),
                    )
                ),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    AppCubit.get(context).likeAdminPost(postModel);
                    AppCubit.get(context).getLikeAdminPostCount(postModel);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.monitor_heart_sharp,
                        size: 18.0,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 5.0,),
                      Text('Like' , style: GoogleFonts.hahmlet(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      ),),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

