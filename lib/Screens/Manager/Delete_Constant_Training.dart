import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/Constants_Training_Model.dart';
import 'package:sharksgym/Models/TrainingModel.dart';
import 'package:sharksgym/Models/UserModel.dart';


class DeleteConstantTraining extends StatelessWidget {
  const DeleteConstantTraining({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Builder(
        builder: (context) {
          constant_training_model model = constant_training_model();
          AppCubit.get(context).getAllTrainings();
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Delete Training".toUpperCase(), style: GoogleFonts.hahmlet(
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

                            title: const Text('Choose training'),
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: AppCubit
                                      .get(context)
                                      .allTrainings!
                                      .length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: (){
                                        model = AppCubit.get(context).allTrainings![index];
                                        print(model.id);
                                      },
                                        title: Text(AppCubit.get(context).allTrainings![index].name!));
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
                        AppCubit.get(context).deleteConstantTraining(id: '${model.id}');
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




