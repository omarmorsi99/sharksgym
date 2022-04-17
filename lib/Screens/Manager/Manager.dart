import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Screens/Manager/Add_Product.dart';
import 'package:sharksgym/Screens/Manager/Add_Training.dart';
import 'package:sharksgym/Screens/Manager/Delete_Constant_Training.dart';
import 'package:sharksgym/Screens/Manager/Delete_Product.dart';
import 'package:video_player/video_player.dart';

import 'Add_Constant_Training.dart';
import 'Delete_Training.dart';

class ManagerScreen extends StatelessWidget {


  const ManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Manager", style: GoogleFonts.hahmlet(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),),
            leading: IconButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),),
          ),
        body: Container(
          height: 6000,
          decoration: BoxDecoration(color: Colors.brown[50]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Container(
                              height: 130.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),

                                image: DecorationImage(
                                  image: NetworkImage("${AppCubit.get(context).userModel!.coverUrl}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          CircleAvatar(
                            radius: 63.0,
                            backgroundColor: Colors.redAccent,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                  "${AppCubit.get(context).userModel!.profileUrl}"),
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${AppCubit.get(context).userModel!.userName}'.toUpperCase(),
                      style: GoogleFonts.hahmlet(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.redAccent.withOpacity(0.8),
                      ),),
                    Text('As Admin'.toUpperCase(),
                      style: GoogleFonts.hahmlet(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.redAccent.withOpacity(0.8),
                      ),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddConstantTraining()));
                                    },

                                    child: Text('Add Training'.toUpperCase(),
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  DeleteConstantTraining()));
                                    },

                                    child: Text('Delete Training'.toUpperCase(),
                                      style: GoogleFonts.hahmlet(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.redAccent.withOpacity(0.8),
                                      ),),
                                  ),
                                ),
                              ],
                            ),

                          ),
                          const SizedBox(height: 20,),
                          SizedBox(
                            width: double.infinity,
                            child: SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTraining()));
                                            },

                                            child: Text('Add User Training'.toUpperCase(),
                                              style: GoogleFonts.hahmlet(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.redAccent.withOpacity(0.8),
                                              ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DeleteTraining()));
                                            },
                                            child: Text('Delete User Training'.toUpperCase(),
                                              style: GoogleFonts.hahmlet(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.redAccent.withOpacity(0.8),
                                              ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          SizedBox(
                            width: double.infinity,
                            child: SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: Column(
                                children: [
                                  const SizedBox(height: 5,),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProduct()));
                                            },

                                            child: Text('Add Product'.toUpperCase(),
                                              style: GoogleFonts.hahmlet(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.redAccent.withOpacity(0.8),
                                              ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DeleteProduct()));
                                            },
                                            child: Text('Delete Product'.toUpperCase(),
                                              style: GoogleFonts.hahmlet(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.redAccent.withOpacity(0.8),
                                              ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      },



    );

  }
}
