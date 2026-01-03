import 'package:organizer/dev/annotations.dart';

part 'animal.json.dart';
part 'animal.copy_with.dart';

@MyJsonSerializable()
@MyCopyWith()
class Animal {
  final String name;
  final int age;
  final String species;
  final String color;
  final String gender;
  final String diet;
  final String habitat;
  final String behavior;
  final String sound;
  final String image;
  final String location;
  Animal({
    required this.name,
    required this.age,
    required this.species,
    required this.color,
    required this.gender,
    required this.diet,
    required this.habitat,
    required this.behavior,
    required this.sound,
    required this.image,
    required this.location,
  });
}
