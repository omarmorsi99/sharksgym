import 'dart:io';
class messege_model {
  String? senderId;
  String? recieverId;
  String? dateTime;
  String? text;
  File? record;



  messege_model({
    this.senderId,
    this.recieverId,
    this.dateTime,
    this.text,
    this.record,
  });

  messege_model.fromJson(Map<String,dynamic> json)
  {
    senderId = json['SenderId'];
    recieverId = json['RecieverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    record = json['Record'];
  }

  Map<String,dynamic> toMap(){
    return {
      'SenderId': senderId,
      'RecieverId': recieverId,
      'dateTime': dateTime,
      'text': text,
      'Record': record,
    };
  }

}