
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Screens/Profile/Add_Goal.dart';

class goal_page extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getUserData();
       return BlocConsumer<AppCubit,AppStates>(
         listener: (context,state){},
           builder:(context,state){ return  SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: SizedBox(
                 height: 600,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Expanded(
                       child: Row(
                         children: [
                           AutoSizeText('Muscular ', style: GoogleFonts.hahmlet(
                             fontSize: 26.0,
                             fontWeight: FontWeight.bold,
                           ),),
                           const Spacer(),
                           AutoSizeText('${AppCubit.get(context).userModel!.mGoal}', style: GoogleFonts.hahmlet(
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
                           AutoSizeText('Fitness ', style: GoogleFonts.hahmlet(
                             fontSize: 26.0,
                             fontWeight: FontWeight.bold,
                           ),),
                           const Spacer(),
                           AutoSizeText('${AppCubit.get(context).userModel!.fGoal}', style: GoogleFonts.hahmlet(
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
                           AutoSizeText('Parkour ', style: GoogleFonts.hahmlet(
                             fontSize: 26.0,
                             fontWeight: FontWeight.bold,
                           ),),
                           const Spacer(),
                           AutoSizeText('${AppCubit.get(context).userModel!.pGoal}', style: GoogleFonts.hahmlet(
                             fontSize: 22.0,
                             fontWeight: FontWeight.bold,
                           ),),
                         ],
                       ),
                     ),
                     const SizedBox(height: 10.0,),
                     Container(height: 3.0, color: Colors.redAccent,),
                     const SizedBox(height: 30.0,),
                     if(AppCubit.get(context).userModel!.isShark != true)
                       Row(
                         children: [
                           Expanded(child:
                           OutlinedButton(
                             onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => const AddGoal()));
                             },
                             child: Text('Add Goal'.toUpperCase(),
                               style: GoogleFonts.hahmlet(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 12,
                                 color: Colors.redAccent.withOpacity(0.8),
                               ),),
                           ),),
                         ],
                       ),
                   ],
                 ),
               ),
             ),
           );}

       );
  }
}
