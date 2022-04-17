
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/UserModel.dart';
import 'package:sharksgym/Screens/Home_Pages/Chat_Details_Screen.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getAdminUsers();
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  AppCubit.get(context).getAdminUsers();
                },
                child: ConditionalBuilder(
                  condition: AppCubit
                      .get(context)
                      .adminUsers
                      .isNotEmpty,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            height: 220,
                            child: Card(
                              child: Image(image: AssetImage('assets/images/logo.jpg'),
                                fit: BoxFit.cover,),
                            ),
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics:  const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  buildItem(context, AppCubit
                                      .get(context)
                                      .adminUsers[index]),
                              separatorBuilder: (context, index) => buildSeperator(),
                              itemCount: AppCubit
                                  .get(context)
                                  .adminUsers
                                  .length),
                        ],
                      ),
                    );
                  },
                  fallback: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },

                ),
                color: Colors.white,
                backgroundColor: Colors.blue,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
              );
            },


    );

  }
}

Widget buildItem(context,user_model model) => InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(model: model)));
  },
  child:   Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: SizedBox(
      height: 90,
      child: Row(
        children: [
          CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage('${model.profileUrl}',),
          ),
          const SizedBox(width: 15.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${model.userName}',style: GoogleFonts.hahmlet(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(height: 15.0,),
              Text('${model.bio}',style: GoogleFonts.hahmlet(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ],
      ),
    ),
  ),
);
Widget buildSeperator() => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Container(
    width: double.infinity,
    height: 0.5,
    color: Colors.grey,
  ),
);
