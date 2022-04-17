
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/MessegeModel.dart';
import 'package:sharksgym/Models/UserModel.dart';
import 'package:sharksgym/Screens/Profile/Profile_View.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';

class ChatDetailsScreen extends StatelessWidget {
  var messegeController = TextEditingController();
  user_model model;
  ChatDetailsScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMesseges(receiverId: model.uId!);

        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  profile_View(model: model)));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage('${model.profileUrl}'),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(model.userName!.toUpperCase()),
                      ],
                    ),
                  ),
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var messeges =
                                  AppCubit.get(context).messeges[index];
                              if (AppCubit.get(context).userModel!.uId ==
                                  messeges.senderId)
                                return buildMyMessege(messeges);

                              return buildMessege(messeges);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15.0,
                                ),
                            itemCount: AppCubit.get(context).messeges.length),
                      ),

                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  messegeController.text = '';
                                },

                                controller: messegeController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '     Write your message...',
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  AppCubit.get(context).sendMessege(
                                      recieverId: model.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messegeController.text);
                                },
                                minWidth: 1,
                                child: const Icon(
                                  Icons.send,
                                  size: 22,
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 4, right: 4),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: SocialMediaRecorder(
                                      sendRequestFunction: (soundFile) async {
                                        AppCubit.get(context).sendMessege(
                                            recieverId: model.uId!,
                                            dateTime: DateTime.now().toString(),
                                            record: soundFile);

                                        print("the current path is ${soundFile.path}");
                                      },
                                      encode: AudioEncoderType.AAC,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
}

Widget buildMessege(messege_model model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        child: Text(
          '${model.text}',
          style: GoogleFonts.hahmlet(fontSize: 18, color: Colors.black),
        ),
      ),
    );

Widget buildMyMessege(messege_model model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        child: Text(
          '${model.text}',
          style: GoogleFonts.hahmlet(fontSize: 18, color: Colors.black),
        ),
      ),
    );
