import 'package:sharksgym/Models/Constants_Training_Model.dart';

class training_model {

  int? selectedDay;
  List<constant_training_model>? trainings;
  String? title;
  String? uId;
  String? tId;
  bool? isPassed;



  training_model({
  this.uId,
  this.tId,
  this.selectedDay,
  this.trainings,
  this.title,
  this.isPassed,

  });

  training_model.fromJson(Map<String,dynamic> json)
  {
    selectedDay = json['selectedDay'];
    tId = json['tId'];
    uId = json['uId'];
    title = json['title'];
    isPassed = json['isPassed'];
    trainings = json['trainings'].map<constant_training_model>((mapString) =>
        constant_training_model.fromJson(mapString)).toList();

  }

  Map<String,dynamic> toMap(){
    return {

      'uId': uId,
      'isPassed': isPassed,
      'tId': tId,
      'title': title,
      'selectedDay': selectedDay,
      'trainings': trainings!.map((i) => i.toMap()).toList(),

    };
  }



}