import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/TrainingModel.dart';

import 'Super_Training_Content.dart';

class Training_Content extends StatelessWidget {
   Training_Content({Key? key ,required this.model}) : super(key: key);
   training_model model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context,state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Day: ${model.selectedDay}' ,style: GoogleFonts.hahmlet(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      ),),
                      const Spacer(),
                      Text(model.title!.toUpperCase(),style: GoogleFonts.hahmlet(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      ),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Super_Training_Content(model: model.trainings![index])));
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Row(
                              children: [
                                Text('${model.trainings![index].name}'),
                                const Spacer(),
                                Image(image: NetworkImage('${model.trainings![index].image}'),)
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        );
                      },
                      itemCount: model.trainings!.length),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                           Navigator.pop(context);
                          },

                          child: Text('Back'.toUpperCase(),
                            style: GoogleFonts.hahmlet(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.redAccent.withOpacity(0.8),
                            ),),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                           model.isPassed = true;
                           AppCubit.get(context).archiveTraining(model);
                           Navigator.pop(context);
                          },
                          child: Text('Finish'.toUpperCase(),
                            style: GoogleFonts.hahmlet(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.redAccent.withOpacity(0.8),
                            ),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

