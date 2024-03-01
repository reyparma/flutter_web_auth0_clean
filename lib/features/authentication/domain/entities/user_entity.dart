import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final bool? isEmailVerified;
  final String? name;
  final String? nickname;
  final String? pictureUrl;
  final DateTime? updatedAt;

  const UserEntity(
      {this.email,
      this.isEmailVerified,
      this.name,
      this.nickname,
      this.pictureUrl,
      this.updatedAt});

  @override
  List<Object?> get props {
    return [email, isEmailVerified, name, nickname, pictureUrl, updatedAt];
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      email: map['email'],
      name: map['name'],
      isEmailVerified: map['isEmailVerified'],
      pictureUrl: map['pictureUrl'],
      updatedAt: map['updatedAt'],
      nickname: map['nickname'],
    );
  }
}
