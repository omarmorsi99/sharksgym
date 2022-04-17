class likes_model {
  String? likerId;
  bool? isLiked;


  likes_model({
    this.likerId,
    this.isLiked,
  });

  likes_model.fromJson(Map<String,dynamic> json)
  {
    likerId = json['likerId'];
    isLiked = json['isLiked'];
  }

  Map<String,dynamic> toMap(){
    return {
      'likerId': likerId,
      'isLiked': isLiked,
    };
  }

}