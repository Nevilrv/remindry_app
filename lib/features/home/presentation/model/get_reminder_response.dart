// To parse this JSON data, do
//
//     final quickReminderResponse = quickReminderResponseFromJson(jsonString);

import 'dart:convert';

QuickReminderResponse quickReminderResponseFromJson(String str) => QuickReminderResponse.fromJson(json.decode(str));

String quickReminderResponseToJson(QuickReminderResponse data) => json.encode(data.toJson());

class QuickReminderResponse {
  bool? success;
  int? code;
  String? message;
  Data? data;
  bool isLoading;
  String? error;

  QuickReminderResponse({
    this.success,
    this.code,
    this.message,
    this.data,
    this.isLoading = false,
    this.error,
  });

  QuickReminderResponse copyWith({
    bool? success,
    int? code,
    String? message,
    Data? data,
    bool? isLoading,
    String? error,
  }) => QuickReminderResponse(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
  );

  factory QuickReminderResponse.fromJson(Map<String, dynamic> json) => QuickReminderResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "code": code, "message": message, "data": data?.toJson()};
}

class Data {
  int? nextCursor;
  List<QuickReminder>? quickReminder;

  Data({this.nextCursor, this.quickReminder});

  Data copyWith({int? nextCursor, List<QuickReminder>? quickReminder}) =>
      Data(nextCursor: nextCursor ?? this.nextCursor, quickReminder: quickReminder ?? this.quickReminder);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nextCursor: json["next_cursor"],
    quickReminder: json["quick_reminder"] == null
        ? []
        : List<QuickReminder>.from(json["quick_reminder"]!.map((x) => QuickReminder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "next_cursor": nextCursor,
    "quick_reminder": quickReminder == null ? [] : List<dynamic>.from(quickReminder!.map((x) => x.toJson())),
  };
}

class QuickReminder {
  int? quickReminderId;
  int? userId;
  String? title;
  String? description;
  DateTime? dateTime;
  String? category;
  String? repeat;
  DateTime? createdAt;
  DateTime? updatedAt;

  QuickReminder({
    this.quickReminderId,
    this.userId,
    this.title,
    this.description,
    this.dateTime,
    this.category,
    this.repeat,
    this.createdAt,
    this.updatedAt,
  });

  QuickReminder copyWith({
    int? quickReminderId,
    int? userId,
    String? title,
    String? description,
    DateTime? dateTime,
    String? category,
    String? repeat,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => QuickReminder(
    quickReminderId: quickReminderId ?? this.quickReminderId,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    description: description ?? this.description,
    dateTime: dateTime ?? this.dateTime,
    category: category ?? this.category,
    repeat: repeat ?? this.repeat,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory QuickReminder.fromJson(Map<String, dynamic> json) => QuickReminder(
    quickReminderId: json["quick_reminder_id"],
    userId: json["user_id"],
    title: json["title"],
    description: json["description"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    category: json["category"],
    repeat: json["repeat"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "quick_reminder_id": quickReminderId,
    "user_id": userId,
    "title": title,
    "description": description,
    "date_time": dateTime?.toIso8601String(),
    "category": category,
    "repeat": repeat,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
