part of 'models.dart';

class Users extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final int? age;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? birthDate;
  final String? image;
  final String? bloodGroup;
  final double? height;
  final double? weight;
  final String? university;
  final String? role;

  const Users({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.university,
    this.role,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json['id'] as int?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        maidenName: json['maidenName'] as String?,
        age: json['age'] as int?,
        gender: json['gender'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        username: json['username'] as String?,
        password: json['password'] as String?,
        birthDate: json['birthDate'] as String?,
        image: json['image'] as String?,
        bloodGroup: json['bloodGroup'] as String?,
        height: (json['height'] as num?)?.toDouble(),
        weight: (json['weight'] as num?)?.toDouble(),
        university: json['university'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'maidenName': maidenName,
        'age': age,
        'gender': gender,
        'email': email,
        'phone': phone,
        'username': username,
        'password': password,
        'birthDate': birthDate,
        'image': image,
        'bloodGroup': bloodGroup,
        'height': height,
        'weight': weight,
        'university': university,
        'role': role,
      };

  Users copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? maidenName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    String? username,
    String? password,
    String? birthDate,
    String? image,
    String? bloodGroup,
    double? height,
    double? weight,
    String? eyeColor,
    String? ip,
    String? macAddress,
    String? university,
    String? ein,
    String? ssn,
    String? userAgent,
    String? role,
  }) {
    return Users(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      maidenName: maidenName ?? this.maidenName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      image: image ?? this.image,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      university: university ?? this.university,
      role: role ?? this.role,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      maidenName,
      age,
      gender,
      email,
      phone,
      username,
      password,
      birthDate,
      image,
      bloodGroup,
      height,
      weight,
      university,
      role,
    ];
  }
}
