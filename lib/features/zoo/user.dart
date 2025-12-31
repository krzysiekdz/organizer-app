import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

void testUser() {
  final user = User(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    password: 'password',
  );
  final u2 = user.copyWith(firstName: 'Jane');
  print(u2);
  print(user == u2);
  print(user.hashCode);
  print(u2.hashCode);
  print(user.toString());
  print(u2.toString());
  print(user.toJson());
  print(u2.toJson());
  // print(user.toMap());
  // print(u2.toMap());
}

//napisac wlasny generator klas na podstawie adnotacji
