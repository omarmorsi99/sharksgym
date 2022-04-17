import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/PostModel.dart';
import 'package:sharksgym/Post/Add_Post.dart';
import 'package:sharksgym/Screens/Manager/Manager.dart';
import 'package:sharksgym/Screens/Profile/edit_profile.dart';
class profile_Page extends StatelessWidget {
  const profile_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppCubit.get(context).getUserData();
    var userModel = AppCubit.get(context).userModel;
    List<post_model> posts =[];
    if(AppCubit.get(context).userModel?.isAdmin == true){
      AppCubit.get(context).getAdminUserPosts(userModel!);
      AppCubit.get(context).getTraining(userModel);
      AppCubit.get(context).userPosts.forEach((element) {
        posts.add(element);
      });

    }
      else{
      AppCubit.get(context).getUserPosts(userModel!);
      AppCubit.get(context).getTraining(userModel);
      AppCubit.get(context).userPosts.forEach((element) {
        posts.add(element);
      });

    }

       return  RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            AppCubit.get(context).getUserData();
          },
          child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: AppCubit.get(context).userModel != null,
                      builder: (context) {
                        return Padding(
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
                                            image: NetworkImage("${userModel.coverUrl}"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      alignment: AlignmentDirectional.topCenter,
                                    ),
                                    CircleAvatar(
                                      radius: 63.0,
                                      backgroundColor: Colors.redAccent,
                                      child: CircleAvatar(
                                        radius: 60.0,
                                        backgroundImage: NetworkImage(
                                            "${userModel.profileUrl}"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('${userModel.userName}'.toUpperCase(),
                                style: GoogleFonts.hahmlet(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.redAccent.withOpacity(0.8),
                                ),),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('${userModel.bio} '.toUpperCase(),
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
                                            Text('${userModel.postsCount} '.toUpperCase(),
                                              style: GoogleFonts.hahmlet(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),),
                                            const SizedBox(height: 10,),
                                            Text('Post'.toUpperCase(),
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
                                Row(
                                  children: [
                                    Expanded(child:
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPost()));
                                      },
                                      child: Text('Add Post '.toUpperCase(),
                                        style: GoogleFonts.hahmlet(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.redAccent.withOpacity(0.8),
                                        ),),
                                    ),),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    if(AppCubit.get(context).userModel!.isAdmin == true)
                                      Expanded(
                                        flex: 1,
                                        child:
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManagerScreen()));
                                        },
                                        child: Text('Manage GYM'.toUpperCase(),
                                          style: GoogleFonts.hahmlet(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.redAccent.withOpacity(0.8),
                                          ),),
                                      ),),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (context) =>
                                              const EditProfile()));
                                        },
                                        child: Icon(Icons.edit,
                                          color: Colors.redAccent.withOpacity(0.8),)
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      }, fallback: (BuildContext context) =>
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    ),
                    ConditionalBuilder(
                      condition: posts.isNotEmpty,
                      builder: (context) {
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemBuilder: (context, index) => buildGridItem(posts[index],context),
                          itemCount: posts.length,
                        );
                      }, fallback: (BuildContext context) =>
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    ),
                  ],
                ),
              );
            },

          ),
          color: Colors.white,
          backgroundColor: Colors.redAccent,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
        );

  }
}
GridTile buildGridItem(post_model post,context) {

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
            ],
          ),
        ),
      ),
    ),
  );
}