
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/TrainingModel.dart';
import 'package:sharksgym/Training/Archived_Trainings.dart';
import 'package:sharksgym/Training/Training_content.dart';
import 'package:video_player/video_player.dart';

class Workout extends StatelessWidget {
  const Workout({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
        builder: (context,state) {
          return  Builder(
            builder: (BuildContext context) {
              AppCubit.get(context).getTraining(AppCubit.get(context).userModel!);
              AppCubit.get(context).getArchivedTraining(AppCubit.get(context).userModel!);
           return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ConditionalBuilder(
                condition: AppCubit.get(context).trainings.isNotEmpty ,
                builder: (BuildContext context) {
                  return  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              height: 170,
                              child: Card(
                                child: Image(image: AssetImage('assets/images/background2.jpg'),
                                  fit: BoxFit.cover,),
                              ),
                            ),
                            CircleAvatar(
                              radius: 25.0,
                              child: CircleAvatar(
                                child: IconButton(
                                    onPressed: () {
                                      // AppCubit.get(context).removePosts();
                                    }, icon: const Icon(Icons.delete)),
                              ),
                            ),
                          ],
                          alignment: AlignmentDirectional.bottomEnd,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics:  const BouncingScrollPhysics(),
                            itemBuilder: (context,index) => buildPostItem(context,AppCubit.get(context).trainings[index], index),
                            separatorBuilder: (context,index) => const SizedBox(
                              height: 8,
                            ),
                            itemCount: AppCubit.get(context).trainings.length),
                      ],
                    ),
                  );

                },
                fallback: (BuildContext context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      const SizedBox(
                        width: double.infinity,
                        height: 180,
                        child: Card(
                          child: Image(image: AssetImage('assets/images/background2.jpg'),
                            fit: BoxFit.cover,),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      if(AppCubit.get(context).userModel!.isShark == true)
                      InkWell(
                        onTap: (){
                          if(AppCubit.get(context).archivedTrainings.isNotEmpty) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Archived_Workout()));
                          }
                          else{
                            showToast(text: 'No Workouts Archived');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                          const Icon(Icons.fitness_center_outlined,color: Colors.blue,),
                          Text('Archived Trainings',style: GoogleFonts.hahmlet(
                            fontSize: 26,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],),
                      ),
                      if(AppCubit.get(context).userModel!.isShark == false)
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text('Contact Admins to Have a Trainings', style: GoogleFonts.hahmlet(
                            fontSize: 26,
                            height: 1.3,
                            color: Colors.black,
                          ),),
                        ),

                    ],
                  );
                },
              ),
              color: Colors.white,
              backgroundColor: Colors.blue,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
            );
            },
          );
        });
  }
}

InkWell buildPostItem(BuildContext context, training_model trainingModel,int index) {

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Training_Content(model: trainingModel,)));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Day:${trainingModel.selectedDay}', style: GoogleFonts.hahmlet(
                  fontSize: 26,
                  height: 1.3,
                  color: Colors.black,
                ),),
                const SizedBox(width: 5,),
                Text(trainingModel.title!.toUpperCase(),style: GoogleFonts.hahmlet(
                  fontSize: 26,
                  height: 1.3,
                  color: Colors.black,
                ),),

              ],
            ),
          ],
          ),
        ),
      ),
    );

}
