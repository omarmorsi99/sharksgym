import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/TrainingModel.dart';
import 'package:sharksgym/Models/UserModel.dart';


class DeleteTraining extends StatefulWidget {


  const DeleteTraining({Key? key}) : super(key: key);

  @override
  State<DeleteTraining> createState() => _DeleteTrainingState();
}

class _DeleteTrainingState extends State<DeleteTraining> {
  user_model? model;
  training_model? tmodel;

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
                    'Delete User Training', style: GoogleFonts.hahmlet(
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
                          ExpansionTile(
                            title: const Text('Choose User'),
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: AppCubit
                                      .get(context)
                                      .users
                                      .length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                        onTap: (){
                                          setState(() {
                                            showToast(text: '${AppCubit.get(context).users[index].userName!} is about to have training');
                                            model = AppCubit.get(context).users[index];
                                            AppCubit.get(context).getTraining(model!);
                                          });

                                        }, title: Text(AppCubit.get(context).users[index].userName!.toUpperCase()));
                                  }
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          ExpansionTile(
                            title: const Text('Choose Training'),
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: AppCubit
                                      .get(context)
                                      .trainings
                                      .length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                        onTap: (){
                                          setState(() {
                                            showToast(text: '${AppCubit.get(context).trainings[index].title} is the training you will delete');
                                            tmodel = AppCubit.get(context).trainings[index];
                                            AppCubit.get(context).getTraining(model!);
                                          });
                                        }, title: Text(AppCubit.get(context).trainings[index].title.toString()));
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
                             AppCubit.get(context).deleteTraining(
                                  model: model!,
                                  tModel: tmodel!,
                              );
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




