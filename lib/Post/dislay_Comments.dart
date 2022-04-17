
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/CommentsModel.dart';
import 'package:sharksgym/Models/PostModel.dart';
import 'package:sharksgym/Models/UserModel.dart';


class displayCommentScreen extends StatefulWidget {
  post_model model;
  displayCommentScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<displayCommentScreen> createState() => _displayCommentScreenState();
}

class _displayCommentScreenState extends State<displayCommentScreen> {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getComments(widget.model,widget.model.ownerId!);
        AppCubit.get(context).getCommentsUsers(widget.model);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                            '${widget.model.mediaUrl}'
                        ),
                      ),
                      const SizedBox(width: 15.0,),
                      Text('${widget.model.userName!.toUpperCase()}\'s Post '),
                    ],
                  ),

                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var comments = AppCubit.get(context).comments[index];
                                return buildMessege(context,comments,AppCubit.get(context).commenterUsers[index]);

                            },
                            separatorBuilder: (context,index) => const SizedBox(height: 15.0,),
                            itemCount: AppCubit.get(context).comments.length,
                        ),
                      ),

                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                onFieldSubmitted: (value){
                                  commentController.text ='';
                                },
                                controller: commentController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write your message...',
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.blue,
                              child: MaterialButton(onPressed: () {
                               setState(() {
                                 AppCubit.get(context).commentAdminPost(
                                     comment: commentController.text,
                                     model: widget.model,
                                     dateTime: DateTime.now().toString());
                               });
                              },
                                minWidth: 1,
                                child: const Icon(Icons.send, size: 22,),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                )





            );
          },
        );
      },
    );
  }
}

Widget buildMessege(context,comments_model model,user_model Umodel,) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('${Umodel.profileUrl}'),
        ),
        const SizedBox(width: 15.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText('${Umodel.userName}',style: GoogleFonts.hahmlet(
      fontSize: 16,
      color: Colors.black
  ),),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
              BoxDecoration(color: Colors.grey[300],
                borderRadius:  const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
              child: Text('${model.text}',style: GoogleFonts.hahmlet(
                  fontSize: 16,
                  color: Colors.black
              ),),

            ),
          ],
        ),
      ],
    ),
  );
}

