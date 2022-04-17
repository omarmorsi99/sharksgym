import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';

class Search extends StatelessWidget {
   Search({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
      builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: TextFormField(
               controller: searchController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search from here',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
      },
    );
  }
}

