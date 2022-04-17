import 'package:sharksgym/Models/PostModel.dart';

class user_model {
  String? coverUrl;
  String? profileUrl;
  String? userName;
  String? phone;
  String? bio;
  String? uId;
  bool? isEmailVerified;
  int? postsCount;
  bool? isAdmin;
  bool? isShark;
  String? mGoal;
  String? fGoal;
  String? pGoal;


  user_model({
    this.profileUrl,
    this.bio,
    this.coverUrl,
    this.userName,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.postsCount,
    this.isAdmin,
    this.isShark,
    this.mGoal,
    this.fGoal,
    this.pGoal,
  });

  user_model.fromJson(Map<String,dynamic> json)
  {
    profileUrl = json['profileUrl'];
    coverUrl = json['CoverUrl'];
    bio = json['bio'];
    userName = json['userName'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    postsCount = json['postsCount'];
    isAdmin = json['isAdmin'];
    mGoal = json['mGoal'];
    fGoal = json['fGoal'];
    pGoal = json['pGoal'];
  }

  Map<String,dynamic> toMap(){
    return {
      'profileUrl': profileUrl,
      'CoverUrl': coverUrl,
      'userName': userName,
      'bio': bio,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'postsCount': postsCount,
      'isAdmin': isAdmin,
      'isShark': isShark,
      'mGoal': mGoal,
      'fGoal': fGoal,
      'pGoal': pGoal,

    };
  }


}