
import 'package:equatable/equatable.dart';



class DogModel  extends Equatable  {
    final String? dogName;
    final String? description;
    final int? age;
    final String? image;

 const   DogModel({
         this.dogName,
         this.description,
         this.age,
         this.image,
    });

    DogModel copyWith({
        String? dogName,
        String? description,
        int? age,
        String? image,
    }) => 
        DogModel(
            dogName: dogName ?? this.dogName,
            description: description ?? this.description,
            age: age ?? this.age,
            image: image ?? this.image,
        );

    factory DogModel.fromJson(Map<String, dynamic> json) => DogModel(
        dogName: json['dogName'],
        description: json['description'],
        age: json['age'],
        image: json['image'],
    );

    Map<String, dynamic> toJson() => {
        'dogName': dogName,
        'description': description,
        'age': age,
        'image': image,
    };
    
      @override
      
      List<Object?> get props =>  [
        dogName,
        description,
        age,
        image,
       
      ];
}
