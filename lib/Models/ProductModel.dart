import 'package:sharksgym/Models/Constants_Training_Model.dart';

class product_model {

  String? name;
  double? price;
  String? imageUrl;



  product_model({
    this.name,
    this.price,
    this.imageUrl,

  });

  product_model.fromJson(Map<String,dynamic> json)
  {
    name = json['name'];
    price = json['price'] as double;
    imageUrl = json['imageUrl'];

  }

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }



}