import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:video_player/video_player.dart';

class AddPost extends StatelessWidget {


  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inputController = TextEditingController();
    var UserModel = AppCubit.get(context).userModel;
    var PostModel = AppCubit.get(context).postModel;
    var PostImage = AppCubit.get(context).postImage;

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){ return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Add Post".toUpperCase(),style: GoogleFonts.hahmlet(
              fontSize: 16.0,
                  color: Colors.blue,
          ),),
          leading: IconButton( icon: const Icon(Icons.arrow_back_ios,color: Colors.blue,), onPressed: (){
            Navigator.pop(context);
          },),
          actions: [
            TextButton(onPressed: (){
              var now = DateTime.now();

             if(UserModel!.isAdmin == true)
               {
                 if(AppCubit.get(context).postImage == null && AppCubit.get(context).postVideoFile == null) {
                   AppCubit.get(context).createAdminPost(
                       text: inputController.text,
                       postId: inputController.text,
                       dateTime: now.toString());
                 }
                 else if(AppCubit.get(context).postImage != null && AppCubit.get(context).postVideoFile != null){

                 }
                 else if(AppCubit.get(context).postImage != null){
                   AppCubit.get(context).uploadAdminPostImage(
                       text: inputController.text,
                       dateTime: now.toString());
                 }
                 else if(AppCubit.get(context).postVideoFile != null){

                 }
               }
             else{
               if(AppCubit.get(context).postImage == null && AppCubit.get(context).postVideoFile == null) {
                 AppCubit.get(context).createPost(
                     text: inputController.text,
                     postId: inputController.text,
                     dateTime: now.toString());
               }
               else if(AppCubit.get(context).postImage != null && AppCubit.get(context).postVideoFile != null){

               }
               else if(AppCubit.get(context).postImage != null){
                 AppCubit.get(context).uploadPostImage(
                     text: inputController.text,
                     dateTime: now.toString());
               }
               else if(AppCubit.get(context).postVideoFile != null){

               }
             }
            }, child: Text("Post".toUpperCase(),style: GoogleFonts.hahmlet(
                fontSize: 16.0
            ),),)
          ],
        ),
      body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                  const LinearProgressIndicator(
                    minHeight: 2,
                    color: Colors.blue,
                  ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                 CircleAvatar(
                    radius: 40.0,
                   backgroundImage:  NetworkImage("${UserModel!.profileUrl}"),
                 ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text("${UserModel.userName}".toUpperCase(),style: GoogleFonts.hahmlet(
                            fontSize: 16.0
                          ),),

                        ],
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: TextFormField(
                    controller: inputController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Post content cannot be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        fillColor: Colors.white60,
                        filled: true,
                        hintMaxLines: 2,
                        hintText: 'what is on your mind ...',
                        border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if(AppCubit.get(context).postImage != null || AppCubit.get(context).postVideo != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(AppCubit.get(context).postImage != null)
                      Expanded(
                        child: Container(
                          height: 200.0,
                          width: double.infinity,
                          decoration:   BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image:  FileImage(AppCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      if(AppCubit.get(context).postVideo != null)
                      Expanded(
                        child: SizedBox(
                          height: 200.0,
                          width: double.infinity,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              AspectRatio(
                                aspectRatio: AppCubit.get(context).postVideo!.value.aspectRatio,
                                child: VideoPlayer(AppCubit.get(context).postVideo!),
                              ),
                              CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blue,
                                child: IconButton(onPressed: (){
                                  if(AppCubit.get(context).postVideo!.value.isPlaying){
                                    AppCubit.get(context).postVideo!.pause();
                                  }
                                  else {
                                    AppCubit.get(context).postVideo!.play();
                                  }
                                },
                                  icon: const Icon(Icons.play_arrow_outlined),color: Colors.white,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.blue,
                        child: IconButton(onPressed: (){
                          AppCubit.get(context).removePostData();
                        },
                          icon: const Icon(Icons.close),color: Colors.white,),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Row(children: [
                    Expanded(
                          child: TextButton(onPressed: (){
                           AppCubit.get(context).getPostImage();
                           },
                          child: Row(
                        children:  [
                          const Icon(Icons.image_search_outlined,color: Colors.blue,),
                          Text('Photo', style: GoogleFonts.hahmlet(
                            color: Colors.blue,
                            fontSize: 16,
                          ),),
                        ],
                      )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){
                        AppCubit.get(context).getPostVideo();

                      }, child: Row(
                        children:  [
                          const Icon(Icons.video_file_outlined,color: Colors.blue,),
                          Text('Video', style: GoogleFonts.hahmlet(
                            color: Colors.blue,
                            fontSize: 16,
                          ),),
                        ],
                      )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){}, child: Text('#tags', style: GoogleFonts.hahmlet(
                        color: Colors.blue,
                        fontSize: 16,
                      ),)),
                    ),
                  ],),
                ),
              ],
            ),
          ),
      );
        },



    );

  }
}
