import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/PostModel.dart';
import 'package:sharksgym/Models/UserModel.dart';
class profile_View extends StatelessWidget {
    profile_View({required this.model,  Key? key}) : super(key: key);
   user_model model;


  @override
  Widget build(BuildContext context) {
    List<post_model> posts =[];
    if(AppCubit.get(context).userModel?.isAdmin == true){
      AppCubit.get(context).getAdminUserPosts(model);
      AppCubit.get(context).getTraining(model);
      AppCubit.get(context).adminPosts.forEach((element) {
        posts.add(element);
      });

    }
    else{
      AppCubit.get(context).getUserPosts(model);
      AppCubit.get(context).getTraining(model);
      AppCubit.get(context).userPosts.forEach((element) {
        posts.add(element);
      });

    }
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Builder(
                builder: (context) {
                  return Scaffold(
                  appBar: AppBar(
                    title: Text('Profile',style: GoogleFonts.hahmlet(
                      fontSize: 26,
                      color: Colors.white,

                    ),),
                  ),
                  body: SingleChildScrollView(
                  child: Column(
                  children: [
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                  children: [
                  SizedBox(
                  height: 190,
                  child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                  Align(
                  child: Container(
                  height: 130.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                  ),
                  image: DecorationImage(
                  image: NetworkImage("${model.coverUrl}"),
                  fit: BoxFit.cover,
                  ),
                  ),
                  ),
                  alignment: AlignmentDirectional.topCenter,
                  ),
                  CircleAvatar(
                  radius: 73.0,
                  backgroundColor: Colors.redAccent,
                  child: CircleAvatar(
                  radius: 70.0,
                  backgroundImage: NetworkImage(
                  "${model.profileUrl}"),
                  ),
                  ),
                  ],
                  ),
                  ),
                  const SizedBox(
                  height: 5,
                  ),
                  Text('${model.userName}'.toUpperCase(),
                  style: GoogleFonts.hahmlet(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.redAccent.withOpacity(0.8),
                  ),),
                  const SizedBox(
                  height: 5,
                  ),
                  Text('${model.bio} '.toUpperCase(),
                  style: GoogleFonts.hahmlet(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.redAccent.withOpacity(0.6),
                  ),),
                  const SizedBox(
                  height: 5,
                  ),
                  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                  children: [
                  Expanded(
                  child: InkWell(
                  onTap: () {},
                  child: Column(
                  children: [
                  Text('${model.postsCount} '.toUpperCase(),
                  style: GoogleFonts.hahmlet(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                  ),),
                  const SizedBox(height: 10,),
                  Text('posts '.toUpperCase(),
                  style: GoogleFonts.hahmlet(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.black,
                  ),),
                  ],
                  ),
                  ),
                  ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('${AppCubit.get(context).trainings.length}',
                              style: GoogleFonts.hahmlet(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black,
                              ),),
                            const SizedBox(height: 10,),
                            Text('Training '.toUpperCase(),
                              style: GoogleFonts.hahmlet(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black,
                              ),),
                          ],
                        ),
                      ),
                    ),
                  ],
                  ),
                  ),
                  GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) => buildPostItem(posts[index],context),
                  itemCount: posts.length,
                  ),
                  ],
                  ),
                  ) ,
                  ],
                  ),
                  ),
                  );
                }
              );
                    },
                  );





  }
}

GridTile buildPostItem(post_model post,context) {

  return GridTile(

    child: InkWell(
      onTap: (){
        postPopup(context,post,Colors.redAccent);
      },
      child: Container(
        color: Colors.white30,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${post.timeStamp}',style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,

              ),),

              if(post.mediaUrl != '')
                Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image:  DecorationImage(
                      image: NetworkImage('${post.mediaUrl}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              if(post.mediaUrl ==  '')
                Expanded(
                  child: Text('${post.description}',style: const TextStyle(
                    fontSize: 26,
                    color: Colors.grey,
                  ),),
                ),

              Row(
                children: [
                  Row(
                    children: const [
                      Text('',style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),),
                      SizedBox(width: 5.0,),
                      Icon(Icons.monitor_heart_outlined,color: Colors.redAccent,size: 26,)
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: const [
                      Text('',style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,

                      ),),
                      SizedBox(width: 5.0,),
                      Icon(Icons.mark_chat_read,color: Colors.redAccent,size: 26,)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}