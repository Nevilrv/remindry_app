// To parse this JSON data, do
//
//     final healthCareResponse = healthCareResponseFromJson(jsonString);

import 'dart:convert';

HealthCareResponse healthCareResponseFromJson(String str) => HealthCareResponse.fromJson(json.decode(str));

String healthCareResponseToJson(HealthCareResponse data) => json.encode(data.toJson());

class HealthCareResponse {
  bool? success;
  int? code;
  String? message;
  Data? data;

  HealthCareResponse({this.success, this.code, this.message, this.data});

  HealthCareResponse copyWith({bool? success, int? code, String? message, Data? data}) => HealthCareResponse(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory HealthCareResponse.fromJson(Map<String, dynamic> json) => HealthCareResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "code": code, "message": message, "data": data?.toJson()};
}

class Data {
  int? nextCursor;
  List<HealthCare>? healthCare;

  Data({this.nextCursor, this.healthCare});

  Data copyWith({int? nextCursor, List<HealthCare>? healthCare}) =>
      Data(nextCursor: nextCursor ?? this.nextCursor, healthCare: healthCare ?? this.healthCare);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nextCursor: json["next_cursor"],
    healthCare: json["health_care"] == null ? [] : List<HealthCare>.from(json["health_care"]!.map((x) => HealthCare.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "next_cursor": nextCursor,
    "health_care": healthCare == null ? [] : List<dynamic>.from(healthCare!.map((x) => x.toJson())),
  };
}

class HealthCare {
  int? healthCareId;
  int? userId;
  String? healthCareType;
  String? doctorName;
  String? speciality;
  DateTime? visitDateTime;
  String? location;
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;

  HealthCare({
    this.healthCareId,
    this.userId,
    this.healthCareType,
    this.doctorName,
    this.speciality,
    this.visitDateTime,
    this.location,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  HealthCare copyWith({
    int? healthCareId,
    int? userId,
    String? healthCareType,
    String? doctorName,
    String? speciality,
    DateTime? visitDateTime,
    String? location,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => HealthCare(
    healthCareId: healthCareId ?? this.healthCareId,
    userId: userId ?? this.userId,
    healthCareType: healthCareType ?? this.healthCareType,
    doctorName: doctorName ?? this.doctorName,
    speciality: speciality ?? this.speciality,
    visitDateTime: visitDateTime ?? this.visitDateTime,
    location: location ?? this.location,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory HealthCare.fromJson(Map<String, dynamic> json) => HealthCare(
    healthCareId: json["health_care_id"],
    userId: json["user_id"],
    healthCareType: json["health_care_type"],
    doctorName: json["doctor_name"],
    speciality: json["speciality"],
    visitDateTime: json["visit_date_time"] == null ? null : DateTime.parse(json["visit_date_time"]),
    location: json["location"],
    notes: json["notes"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "health_care_id": healthCareId,
    "user_id": userId,
    "health_care_type": healthCareType,
    "doctor_name": doctorName,
    "speciality": speciality,
    "visit_date_time": visitDateTime?.toIso8601String(),
    "location": location,
    "notes": notes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
