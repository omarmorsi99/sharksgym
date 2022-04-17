
class constant_training_model {

   String? name;
   String? sets;
   String? reps;
   String? image;
   String? id;

  constant_training_model({
    this.name,
    this.image,
    this.sets,
    this.reps,
    this.id,

  });

  constant_training_model.fromJson(Map<String,dynamic> json)
  {
    name = json['name'];
    sets = json['sets'];
    reps = json['reps'];
    image = json['image'];
    id = json['id'];

  }

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'reps': reps,
      'sets': sets,
      'image': image,
      'id': id,
    };
  }


}