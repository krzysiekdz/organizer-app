import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false)
class UserModel extends User {
  const UserModel({required super.id, super.email});

  factory UserModel.fromEntity(User user) {
    // If already a UserModel, return as-is (no need to create new instance)
    if (user is UserModel) return user;
    return UserModel(id: user.id, email: user.email);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return UserModel(id: firebaseUser.uid, email: firebaseUser.email);
  }
}
