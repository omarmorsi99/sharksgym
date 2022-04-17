class comments_model {
  String? SenderId;
  String? dateTime;
  String? text;



  comments_model({
    this.SenderId,
    this.dateTime,
    this.text,
  });

  comments_model.fromJson(Map<String,dynamic> json)
  {
    SenderId = json['SenderId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String,dynamic> toMap(){
    return {
      'SenderId': SenderId,
      'dateTime': dateTime,
      'text': text,
    };
  }

}