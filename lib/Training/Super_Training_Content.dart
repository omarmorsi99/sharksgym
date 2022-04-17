import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/Constants_Training_Model.dart';
import 'package:sharksgym/Models/TrainingModel.dart';

class Super_Training_Content extends StatelessWidget {
  Super_Training_Content({Key? key ,required this.model}) : super(key: key);
  constant_training_model model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context,state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    Text('${model.name}', style: GoogleFonts.hahmlet(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),),
                    Image(image: NetworkImage('${model.image}',)
                    ,fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text('Sets: ${model.sets}', style: GoogleFonts.hahmlet(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),),
                        const Spacer(),
                        Text('Reps: ${model.reps} ', style: GoogleFonts.hahmlet(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),),

                      ],
                    )
                  ],
                ),
              ),
            ),

            ),
          );
      },
    );
  }
}

