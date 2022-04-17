
import 'package:sharksgym/Models/LikesModel.dart';

class post_model {
  String? postId;
  String? ownerId;
  String? userName;
  String? mediaUrl;
  String? videoUrl;
  String? userUrl;
  String? description;
  String? timeStamp;
  List<likes_model>? likes;


  post_model({
    this.postId,
    this.ownerId,
    this.userName,
    this.mediaUrl,
    this.videoUrl,
    this.userUrl,
    this.description,
    this.timeStamp,
    this.likes,
  });

  post_model.fromJson(Map<String,dynamic> json)
  {
    postId = json['postId'];
    ownerId = json['ownerId'];
    userName = json['userName'];
    mediaUrl = json['mediaUrl'];
    videoUrl = json['videoUrl'];
    userUrl = json['userUrl'];
    description = json['description'];
    timeStamp = json['timeStamp'];
    likes = json['likes'].map<likes_model>((mapString) =>
        likes_model.fromJson(mapString)).toList();
  }

  Map<String,dynamic> toMap(){
    return {
      'postId': postId,
      'ownerId': ownerId,
      'userName': userName,
      'mediaUrl': mediaUrl,
      'videoUrl': videoUrl,
      'userUrl': userUrl,
      'description': description,
      'timeStamp': timeStamp,
      'likes': likes!.map((i) => i.toMap()).toList(),
    };
  }



}