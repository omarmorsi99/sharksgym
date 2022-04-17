import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/Constants_Training_Model.dart';
import 'package:sharksgym/Models/ProductModel.dart';

class Super_Product_Content extends StatelessWidget {
  Super_Product_Content({Key? key ,required this.model}) : super(key: key);
  product_model model;


  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${model.name}'.toUpperCase() , style: GoogleFonts.hahmlet(
              fontSize: 26,
              color: Colors.white,
            ),),
            leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),),
          ),
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
                    Image(image: NetworkImage('${model.imageUrl}',)
                      ,fit: BoxFit.contain,
                      width: double.infinity,
                      height: 300,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text('Per Piece', style: GoogleFonts.hahmlet(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),),
                        const Spacer(),
                        Text(' ${model.price} ', style: GoogleFonts.hahmlet(
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

  }
}

