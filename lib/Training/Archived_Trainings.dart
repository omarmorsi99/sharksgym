
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/TrainingModel.dart';
import 'package:sharksgym/Training/Training_content.dart';
import 'package:video_player/video_player.dart';

class Archived_Workout extends StatelessWidget {
  const Archived_Workout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state) {
          return  Builder(
            builder: (BuildContext context) {
              AppCubit.get(context).getArchivedTraining(AppCubit.get(context).userModel!);
              return Scaffold(
                appBar: AppBar(
                  title: Text('Archived Workout'),
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    AppCubit.get(context).getArchivedTraining(AppCubit.get(context).userModel!);
                  },
                  child: ConditionalBuilder(
                    condition: AppCubit.get(context).archivedTrainings.isNotEmpty ,
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
                              ],
                              alignment: AlignmentDirectional.bottomEnd,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics:  const BouncingScrollPhysics(),
                                itemBuilder: (context,index) => buildPostItem(context,AppCubit.get(context).archivedTrainings[index], index),
                                separatorBuilder: (context,index) => const SizedBox(
                                  height: 8,
                                ),
                                itemCount: AppCubit.get(context).archivedTrainings.length),
                          ],
                        ),
                      );

                    },
                    fallback: (BuildContext context) {
                      return Column(
                        children:  [
                          const SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Card(
                              child: Image(image: AssetImage('assets/images/background2.jpg'),
                                fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(height: 10,),
                          InkWell(
                            onTap: (){

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
                          const SizedBox(height: 10,),
                          const Center(child: CircularProgressIndicator(),)
                        ],
                      );
                    },
                  ),
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                ),
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
                Text('Archived $index',style: GoogleFonts.hahmlet(
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
