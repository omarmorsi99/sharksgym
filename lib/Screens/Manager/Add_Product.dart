import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/Constants_Training_Model.dart';
import 'package:sharksgym/Models/TrainingModel.dart';
import 'package:sharksgym/Models/UserModel.dart';


class AddProduct extends StatefulWidget {


  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var productNameController = TextEditingController();
  var productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Builder(
        builder: (context) {
          AppCubit.get(context).getUsers();
          AppCubit.get(context).getAllTrainings();

          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Add Product', style: GoogleFonts.hahmlet(
                    fontSize: 26.0,
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
                          const SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: productNameController,
                              decoration: const InputDecoration(
                                labelText: 'Product Name',
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: productPriceController,
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              decoration: const InputDecoration(
                                labelText: 'Product Price',
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          IconButton(onPressed: () async {

                            AppCubit.get(context).getProductImage();
                          },
                            icon: const Icon(Icons.camera_alt_outlined),color: Colors.redAccent,),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            color: Colors.blue,
                            onPressed: (){
                              AppCubit.get(context).uploadProductImage(
                                  price: double.parse(productPriceController.text),
                                  name: productNameController.text,
                              );
                              showToast(text: 'Product Added Successfully');
                            },
                            child: Text('Submit'.toUpperCase(),style: const TextStyle(
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




