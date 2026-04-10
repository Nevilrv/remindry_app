// To parse this JSON data, do
//
//     final warrantiesResponse = warrantiesResponseFromJson(jsonString);

import 'dart:convert';

WarrantiesResponse warrantiesResponseFromJson(String str) => WarrantiesResponse.fromJson(json.decode(str));

String warrantiesResponseToJson(WarrantiesResponse data) => json.encode(data.toJson());

class WarrantiesResponse {
  bool? success;
  int? code;
  String? message;
  Data? data;

  WarrantiesResponse({this.success, this.code, this.message, this.data});

  WarrantiesResponse copyWith({bool? success, int? code, String? message, Data? data}) => WarrantiesResponse(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory WarrantiesResponse.fromJson(Map<String, dynamic> json) => WarrantiesResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "code": code, "message": message, "data": data?.toJson()};
}

class Data {
  int? nextCursor;
  List<Warranty>? warranties;

  Data({this.nextCursor, this.warranties});

  Data copyWith({int? nextCursor, List<Warranty>? warranties}) =>
      Data(nextCursor: nextCursor ?? this.nextCursor, warranties: warranties ?? this.warranties);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nextCursor: json["next_cursor"],
    warranties: json["warranties"] == null ? [] : List<Warranty>.from(json["warranties"]!.map((x) => Warranty.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "next_cursor": nextCursor,
    "warranties": warranties == null ? [] : List<dynamic>.from(warranties!.map((x) => x.toJson())),
  };
}

class Warranty {
  int? warrantiesId;
  int? userId;
  String? productName;
  String? brand;
  String? category;
  DateTime? purchaseDateTime;
  DateTime? garrantyDuration;
  DateTime? warrantyDuration;
  String? invoiceNumber;
  String? storeLocation;
  DateTime? createdAt;
  DateTime? updatedAt;

  Warranty({
    this.warrantiesId,
    this.userId,
    this.productName,
    this.brand,
    this.category,
    this.purchaseDateTime,
    this.garrantyDuration,
    this.warrantyDuration,
    this.invoiceNumber,
    this.storeLocation,
    this.createdAt,
    this.updatedAt,
  });

  Warranty copyWith({
    int? warrantiesId,
    int? userId,
    String? productName,
    String? brand,
    String? category,
    DateTime? purchaseDateTime,
    DateTime? garrantyDuration,
    DateTime? warrantyDuration,
    String? invoiceNumber,
    String? storeLocation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Warranty(
    warrantiesId: warrantiesId ?? this.warrantiesId,
    userId: userId ?? this.userId,
    productName: productName ?? this.productName,
    brand: brand ?? this.brand,
    category: category ?? this.category,
    purchaseDateTime: purchaseDateTime ?? this.purchaseDateTime,
    garrantyDuration: garrantyDuration ?? this.garrantyDuration,
    warrantyDuration: warrantyDuration ?? this.warrantyDuration,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    storeLocation: storeLocation ?? this.storeLocation,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Warranty.fromJson(Map<String, dynamic> json) => Warranty(
    warrantiesId: json["warranties_id"],
    userId: json["user_id"],
    productName: json["product_name"],
    brand: json["brand"],
    category: json["category"],
    purchaseDateTime: json["purchase_date_time"] == null ? null : DateTime.parse(json["purchase_date_time"]),
    garrantyDuration: json["garranty_duration"] == null ? null : DateTime.parse(json["garranty_duration"]),
    warrantyDuration: json["warranty_duration"] == null ? null : DateTime.parse(json["warranty_duration"]),
    invoiceNumber: json["invoice_number"],
    storeLocation: json["store_location"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "warranties_id": warrantiesId,
    "user_id": userId,
    "product_name": productName,
    "brand": brand,
    "category": category,
    "purchase_date_time": purchaseDateTime?.toIso8601String(),
    "garranty_duration": garrantyDuration?.toIso8601String(),
    "warranty_duration": warrantyDuration?.toIso8601String(),
    "invoice_number": invoiceNumber,
    "store_location": storeLocation,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
