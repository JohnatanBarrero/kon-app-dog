
import 'package:equatable/equatable.dart';



class DogModel  extends Equatable  {
    final String? dogModelName;
    final String? description;
    final int? age;
    final String? image;

 const   DogModel({
         this.dogModelName,
         this.description,
         this.age,
         this.image,
    });

    DogModel copyWith({
        String? dogModelName,
        String? description,
        int? age,
        String? image,
    }) => 
        DogModel(
            dogModelName: dogModelName ?? this.dogModelName,
            description: description ?? this.description,
            age: age ?? this.age,
            image: image ?? this.image,
        );

    factory DogModel.fromJson(Map<String, dynamic> json) => DogModel(
        dogModelName: json['dogModelName'],
        description: json['description'],
        age: json['age'],
        image: json['image'],
    );

    Map<String, dynamic> toJson() => {
        'dogModelName': dogModelName,
        'description': description,
        'age': age,
        'image': image,
    };
    
      @override
      
      List<Object?> get props =>  [
        dogModelName,
        description,
        age,
        image,
       
      ];
}
