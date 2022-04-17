import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/TrainingModel.dart';
import 'package:sharksgym/Models/UserModel.dart';


class AddConstantTraining extends StatelessWidget {
  var trainingNameController = TextEditingController();
  var trainingSetsController = TextEditingController();
  var trainingRepsController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: Text(
                      'Add Training', style: GoogleFonts.hahmlet(
                      fontSize: 12.0,
                      color: Colors.redAccent,
                    ),),
                    leading: IconButton(icon: const Icon(
                      Icons.arrow_back_ios, color: Colors.redAccent,),
                      onPressed: () {
                        Navigator.pop(context);
                      },),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: trainingNameController,
                            decoration: const InputDecoration(
                              labelText: 'Training Name',
                            ),
                          ),
                          TextFormField(
                            controller: trainingSetsController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'sets',
                            ),
                          ),
                          TextFormField(
                            controller: trainingRepsController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'reps',
                            ),
                          ),
                          IconButton(onPressed: () async {

                            AppCubit.get(context).getTrainingImage();
                          },
                            icon: const Icon(Icons.camera_alt_outlined),color: Colors.redAccent,),
                          OutlinedButton(
                            onPressed: () {
                              AppCubit.get(context).uploadTrainingImage(
                                  name: trainingNameController.text,
                                  sets: trainingSetsController.text,
                                  reps: trainingRepsController.text,

                              );
                            },

                            child: Text('Add Training'.toUpperCase(),
                              style: GoogleFonts.hahmlet(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.redAccent.withOpacity(0.8),
                              ),),
                          ),
                        ],
                      ),
                    ),
                  )
              );
            },


          );
        }
    );
  }
}




