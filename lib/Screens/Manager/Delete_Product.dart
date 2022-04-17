import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/Constants_Training_Model.dart';
import 'package:sharksgym/Models/ProductModel.dart';
import 'package:sharksgym/Models/TrainingModel.dart';
import 'package:sharksgym/Models/UserModel.dart';


class DeleteProduct extends StatelessWidget {
  const DeleteProduct({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getProducts();
    return Builder(
        builder: (context) {
          product_model model = product_model();
          AppCubit.get(context).getProducts();
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Delete Product".toUpperCase(), style: GoogleFonts.hahmlet(
                    fontSize: 16.0,
                    color: Colors.redAccent,
                  ),),
                  leading: IconButton(icon: const Icon(
                    Icons.arrow_back_ios, color: Colors.redAccent,),
                    onPressed: () {
                      Navigator.pop(context);
                    },),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          ExpansionTile(

                            title: const Text('Choose Product'),
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: AppCubit
                                      .get(context)
                                      .products
                                      .length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                        onTap: (){
                                          model = AppCubit.get(context).products[index];
                                          print(model.name);
                                        },
                                        title: Text('${AppCubit.get(context).products[index].name}'));
                                  }
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            color: Colors.blue,
                            onPressed: (){
                              AppCubit.get(context).deleteProduct(name: model.name.toString());

                            },
                            child: Text('Delete'.toUpperCase(),style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            },


          );
        }
    );

  }
}




