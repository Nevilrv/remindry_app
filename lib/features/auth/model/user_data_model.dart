// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  bool? success;
  int? code;
  String? message;
  Data? data;

  UserResponse({this.success, this.code, this.message, this.data});

  UserResponse copyWith({bool? success, int? code, String? message, Data? data}) =>
      UserResponse(success: success ?? this.success, code: code ?? this.code, message: message ?? this.message, data: data ?? this.data);

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "code": code, "message": message, "data": data?.toJson()};
}

class Data {
  int? userId;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  dynamic email;
  String? gender;
  bool? isPlan;
  dynamic planName;
  String? fcmToken;
  bool? isLogout;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  Data({
    this.userId,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.gender,
    this.isPlan,
    this.planName,
    this.fcmToken,
    this.isLogout,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  Data copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? countryCode,
    String? phoneNumber,
    dynamic email,
    String? gender,
    bool? isPlan,
    dynamic planName,
    String? fcmToken,
    bool? isLogout,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) => Data(
    userId: userId ?? this.userId,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    countryCode: countryCode ?? this.countryCode,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email ?? this.email,
    gender: gender ?? this.gender,
    isPlan: isPlan ?? this.isPlan,
    planName: planName ?? this.planName,
    fcmToken: fcmToken ?? this.fcmToken,
    isLogout: isLogout ?? this.isLogout,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    token: token ?? this.token,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    countryCode: json["country_code"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    gender: json["gender"],
    isPlan: json["is_plan"],
    planName: json["plan_name"],
    fcmToken: json["fcm_token"],
    isLogout: json["is_logout"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "country_code": countryCode,
    "phone_number": phoneNumber,
    "email": email,
    "gender": gender,
    "is_plan": isPlan,
    "plan_name": planName,
    "fcm_token": fcmToken,
    "is_logout": isLogout,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "token": token,
  };
}
