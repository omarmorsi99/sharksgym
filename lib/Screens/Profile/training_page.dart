
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';

class Training_Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getArchivedTraining(AppCubit.get(context).userModel!);
    AppCubit.get(context).getTraining(AppCubit.get(context).userModel!);
    double percent =0.0;
    if(AppCubit.get(context).trainings.isEmpty && AppCubit.get(context).archivedTrainings.isEmpty) {
      percent=0;
    } else{
      percent = AppCubit.get(context).trainings.length / AppCubit.get(context).archivedTrainings.length;
    }
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 600,
              child: Column(
                children: [
                  Row(
                    children: [
                      AutoSizeText('Finished Days', style: GoogleFonts.hahmlet(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      const Spacer(),
                      AutoSizeText('${AppCubit.get(context).archivedTrainings.length}', style: GoogleFonts.hahmlet(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Container(height: 3.0, color: Colors.redAccent,),
                  const SizedBox(height: 10.0,),
                  Expanded(
                    child: Row(
                      children: [
                        AutoSizeText('Level Duration', style: GoogleFonts.hahmlet(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),),
                        const Spacer(),
                        AutoSizeText('${AppCubit.get(context).trainings.length} Day', style: GoogleFonts.hahmlet(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Container(height: 3.0, color: Colors.redAccent,),
                  const SizedBox(height: 10.0,),
                  Expanded(
                    child: Row(
                      children: [
                        AutoSizeText('Level Progress', style: GoogleFonts.hahmlet(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),),
                        const Spacer(),
                        CircularPercentIndicator(
                          radius: 66.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: percent,
                          center:  Text(
                            "$percent",
                            style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Container(height: 3.0, color: Colors.redAccent,),
                  const SizedBox(height: 10.0,),
                  Row(
                    children: [
                      AutoSizeText('Days Left ', style: GoogleFonts.hahmlet(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      const Spacer(),
                      AutoSizeText('${21 - AppCubit.get(context).archivedTrainings.length }', style: GoogleFonts.hahmlet(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),),
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
