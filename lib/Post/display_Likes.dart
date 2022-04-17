
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
import 'package:sharksgym/Screens/Profile/Profile_View.dart';


class displayLikes extends StatefulWidget {
  post_model model;
  displayLikes({Key? key, required this.model}) : super(key: key);

  @override
  State<displayLikes> createState() => _displayLikesState();
}

class _displayLikesState extends State<displayLikes> {

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
    AppCubit.get(context).getLikeAdminPostCount(widget.model);
    AppCubit.get(context).getLikeAdminPostUsers(widget.model);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                AppCubit.get(context).getLikeAdminPostCount(widget.model);
                AppCubit.get(context).getLikeAdminPostUsers(widget.model);
              },
              child: Scaffold(
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
                            scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return buildLike(context,AppCubit.get(context).likerUsers[index]);
                              },
                              separatorBuilder: (context,index) => const SizedBox(height: 15.0,),
                              itemCount: AppCubit.get(context).likerUsers.length
                          ),
                        ),
                      ],
                    ),

                  )





              ),
              color: Colors.white,
              backgroundColor: Colors.blue,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
            );
          },
        );
      },
    );
  }
}

Widget buildLike(context,user_model Umodel,) {
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => profile_View(model: Umodel)));
    },
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

          ],
        ),
      ],
    ),
  );
}

