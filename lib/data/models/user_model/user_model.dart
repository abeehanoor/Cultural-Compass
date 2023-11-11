// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String status;
  String message;
  Data data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String name;
  String email;
  bool otpVerify;
  dynamic city;
  String dateOfBirth;
  dynamic emailVerifiedAt;
  dynamic bio;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.otpVerify,
    required this.city,
    required this.dateOfBirth,
    required this.emailVerifiedAt,
    required this.bio,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    otpVerify: json["otp_verify"],
    city: json["city"],
    dateOfBirth: json["date_of_birth"],
    emailVerifiedAt: json["email_verified_at"],
    bio:json["bio"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "otp_verify": otpVerify,
    "city": city,
    "date_of_birth": dateOfBirth,
    "email_verified_at": emailVerifiedAt,
    "bio":bio
  };
}
