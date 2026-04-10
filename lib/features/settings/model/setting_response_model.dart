// To parse this JSON data, do
//
//     final settingResponse = settingResponseFromJson(jsonString);

import 'dart:convert';

SettingResponse settingResponseFromJson(String str) => SettingResponse.fromJson(json.decode(str));

String settingResponseToJson(SettingResponse data) => json.encode(data.toJson());

class SettingResponse {
  bool? success;
  int? code;
  String? message;
  Data? data;

  SettingResponse({this.success, this.code, this.message, this.data});

  SettingResponse copyWith({bool? success, int? code, String? message, Data? data}) =>
      SettingResponse(success: success ?? this.success, code: code ?? this.code, message: message ?? this.message, data: data ?? this.data);

  factory SettingResponse.fromJson(Map<String, dynamic> json) => SettingResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "code": code, "message": message, "data": data?.toJson()};
}

class Data {
  int? settingId;
  int? userId;
  bool? isVoiceAssistant;
  bool? isSmartSuggestions;
  String? reminderIntensity;
  bool? isEmail;
  bool? isSms;
  bool? isWhatsapp;
  bool? isCalls;
  bool? isOcrScan;
  bool? isReminder;
  bool? isLocation;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.settingId,
    this.userId,
    this.isVoiceAssistant,
    this.isSmartSuggestions,
    this.reminderIntensity,
    this.isEmail,
    this.isSms,
    this.isWhatsapp,
    this.isCalls,
    this.isOcrScan,
    this.isReminder,
    this.isLocation,
    this.createdAt,
    this.updatedAt,
  });

  Data copyWith({
    int? settingId,
    int? userId,
    bool? isVoiceAssistant,
    bool? isSmartSuggestions,
    String? reminderIntensity,
    bool? isEmail,
    bool? isSms,
    bool? isWhatsapp,
    bool? isCalls,
    bool? isOcrScan,
    bool? isReminder,
    bool? isLocation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Data(
    settingId: settingId ?? this.settingId,
    userId: userId ?? this.userId,
    isVoiceAssistant: isVoiceAssistant ?? this.isVoiceAssistant,
    isSmartSuggestions: isSmartSuggestions ?? this.isSmartSuggestions,
    reminderIntensity: reminderIntensity ?? this.reminderIntensity,
    isEmail: isEmail ?? this.isEmail,
    isSms: isSms ?? this.isSms,
    isWhatsapp: isWhatsapp ?? this.isWhatsapp,
    isCalls: isCalls ?? this.isCalls,
    isOcrScan: isOcrScan ?? this.isOcrScan,
    isReminder: isReminder ?? this.isReminder,
    isLocation: isLocation ?? this.isLocation,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    settingId: json["setting_id"],
    userId: json["user_id"],
    isVoiceAssistant: json["is_voice_assistant"],
    isSmartSuggestions: json["is_smart_suggestions"],
    reminderIntensity: json["reminder_intensity"],
    isEmail: json["is_email"],
    isSms: json["is_sms"],
    isWhatsapp: json["is_whatsapp"],
    isCalls: json["is_calls"],
    isOcrScan: json["is_ocr_scan"],
    isReminder: json["is_reminder"],
    isLocation: json["is_location"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "setting_id": settingId,
    "user_id": userId,
    "is_voice_assistant": isVoiceAssistant,
    "is_smart_suggestions": isSmartSuggestions,
    "reminder_intensity": reminderIntensity,
    "is_email": isEmail,
    "is_sms": isSms,
    "is_whatsapp": isWhatsapp,
    "is_calls": isCalls,
    "is_ocr_scan": isOcrScan,
    "is_reminder": isReminder,
    "is_location": isLocation,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
