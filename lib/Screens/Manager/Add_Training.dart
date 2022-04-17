import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharksgym/Component/Component.dart';
import 'package:sharksgym/Cubit/AppCubit.dart';
import 'package:sharksgym/Cubit/AppStates.dart';
import 'package:sharksgym/Models/Constants_Training_Model.dart';
import 'package:sharksgym/Models/TrainingModel.dart';
import 'package:sharksgym/Models/UserModel.dart';


class AddTraining extends StatefulWidget {


  const AddTraining({Key? key}) : super(key: key);

  @override
  State<AddTraining> createState() => _AddTrainingState();
}

class _AddTrainingState extends State<AddTraining> {
  var trainingtitleController = TextEditingController();
  user_model? model;
  List<constant_training_model>? cModel = [];
  List<int> Days = [1,2,3,4,5,6,7];
  String? selectedCategory;
  int? selectedDay;

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
                    '', style: GoogleFonts.hahmlet(
                    fontSize: 12.0,
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
                                          });
                                      model = AppCubit.get(context).users[index];

                                    }, title: Text(AppCubit.get(context).users[index].userName!.toUpperCase()));
                                  }
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: trainingtitleController,
                              decoration: const InputDecoration(
                                labelText: 'User Training Title',
                              ),
                            ),
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
                                      .allTrainings!
                                      .length,
                                  itemBuilder: (BuildContext context, int index) {


                                    return ListTile(
                                        onTap: (){
                                          cModel!.add(AppCubit.get(context).allTrainings![index]);
                                          print(cModel);
                                          showToast(text: '${AppCubit.get(context).allTrainings![index].name} Added to your trainings');
                                    },
                                        title:  Text('${AppCubit.get(context).allTrainings![index].name}')
                                    );

                                  }
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          ExpansionTile(
                            title: const Text(
                              'Day',
                            ),
                            children: [
                              GridView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: Days.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: ListTile(
                                          onTap: (){
                                            setState(() {
                                              showToast(text: 'Training will be added in day  ${Days[index]}');
                                            });
                                            selectedDay = Days[index];
                                          }, title: Text('${Days[index]}')),
                                    );
                                  },
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                          ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            color: Colors.blue,
                            onPressed: (){
                             AppCubit.get(context).addTraining(
                                 uModel: model!,
                                 cmodel: cModel!,
                                 selectedDay: selectedDay,
                                 trainingTitle: trainingtitleController.text);
                                 cModel =[];
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




