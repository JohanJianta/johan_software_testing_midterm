part of 'models.dart';

class User extends Equatable {
  final int? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? email;
  final String? image;

  const User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        username: json['username'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        gender: json['gender'] as String?,
        email: json['email'] as String?,
        image: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'email': email,
        'role': image,
      };

  User copyWith({
    int? id,
    String? username,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    String? birthDate,
    String? image,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      username,
      firstName,
      lastName,
      gender,
      email,
      image,
    ];
  }
}
