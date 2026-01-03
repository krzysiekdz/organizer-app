// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:organizer/dev/annotations.dart';

// part 'user.freezed.dart';
// part 'user.g.dart';
part 'user.json.dart';
part 'user.copy_with.dart';
// @freezed
// abstract class User with _$User {
//   const factory User({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String password,
//   }) = _User;

//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
// }

@MyJsonSerializable()
@MyCopyWith()
class User {
  final String name;
  final String lastName;
  final int age;
  final String email;
  final String password;
  User({
    required this.name,
    required this.lastName,
    required this.age,
    required this.email,
    required this.password,
  });
}

void testUser() {
  final user = User(
    name: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    password: 'password',
    age: 30,
  );
  print(user.toJson());
  final u2 = user.copyWith(name: 'Jan', lastName: 'Kowalski');
  print(u2.toJson());
  // print(user == u2);
  // print(user.hashCode);
  // print(u2.hashCode);
  // print(user.toString());
  // print(u2.toString());
  // print(user.toJson());
  // print(u2.toJson());
  // print(user.toMap());
  // print(u2.toMap());
}

//napisac wlasny generator klas na podstawie adnotacji
