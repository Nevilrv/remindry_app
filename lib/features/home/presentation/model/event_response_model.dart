// To parse this JSON data, do
//
//     final eventResponseModel = eventResponseModelFromJson(jsonString);

import 'dart:convert';

EventResponseModel eventResponseModelFromJson(String str) => EventResponseModel.fromJson(json.decode(str));

String eventResponseModelToJson(EventResponseModel data) => json.encode(data.toJson());

class EventResponseModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  EventResponseModel({this.success, this.code, this.message, this.data});

  EventResponseModel copyWith({bool? success, int? code, String? message, Data? data}) => EventResponseModel(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory EventResponseModel.fromJson(Map<String, dynamic> json) => EventResponseModel(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "code": code, "message": message, "data": data?.toJson()};
}

class Data {
  int? nextCursor;
  List<Event>? event;

  Data({this.nextCursor, this.event});

  Data copyWith({int? nextCursor, List<Event>? event}) => Data(nextCursor: nextCursor ?? this.nextCursor, event: event ?? this.event);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nextCursor: json["next_cursor"],
    event: json["event"] == null ? [] : List<Event>.from(json["event"]!.map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "next_cursor": nextCursor,
    "event": event == null ? [] : List<dynamic>.from(event!.map((x) => x.toJson())),
  };
}

class Event {
  int? eventId;
  int? userId;
  String? eventTitle;
  DateTime? eventDateTime;
  String? eventCategory;
  String? eventLocation;
  String? eventNotes;
  String? eventBeforeReminderTitle;
  DateTime? eventBeforeReminderTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  Event({
    this.eventId,
    this.userId,
    this.eventTitle,
    this.eventDateTime,
    this.eventCategory,
    this.eventLocation,
    this.eventNotes,
    this.eventBeforeReminderTitle,
    this.eventBeforeReminderTime,
    this.createdAt,
    this.updatedAt,
  });

  Event copyWith({
    int? eventId,
    int? userId,
    String? eventTitle,
    DateTime? eventDateTime,
    String? eventCategory,
    String? eventLocation,
    String? eventNotes,
    String? eventBeforeReminderTitle,
    DateTime? eventBeforeReminderTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Event(
    eventId: eventId ?? this.eventId,
    userId: userId ?? this.userId,
    eventTitle: eventTitle ?? this.eventTitle,
    eventDateTime: eventDateTime ?? this.eventDateTime,
    eventCategory: eventCategory ?? this.eventCategory,
    eventLocation: eventLocation ?? this.eventLocation,
    eventNotes: eventNotes ?? this.eventNotes,
    eventBeforeReminderTitle: eventBeforeReminderTitle ?? this.eventBeforeReminderTitle,
    eventBeforeReminderTime: eventBeforeReminderTime ?? this.eventBeforeReminderTime,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    eventId: json["event_id"],
    userId: json["user_id"],
    eventTitle: json["event_title"],
    eventDateTime: json["event_date_time"] == null ? null : DateTime.parse(json["event_date_time"]),
    eventCategory: json["event_category"],
    eventLocation: json["event_location"],
    eventNotes: json["event_notes"],
    eventBeforeReminderTitle: json["event_before_reminder_title"],
    eventBeforeReminderTime: json["event_before_reminder_time"] == null ? null : DateTime.parse(json["event_before_reminder_time"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "event_id": eventId,
    "user_id": userId,
    "event_title": eventTitle,
    "event_date_time": eventDateTime?.toIso8601String(),
    "event_category": eventCategory,
    "event_location": eventLocation,
    "event_notes": eventNotes,
    "event_before_reminder_title": eventBeforeReminderTitle,
    "event_before_reminder_time": eventBeforeReminderTime?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
