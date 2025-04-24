// To parse this JSON data, do
//
//     final bufferDetailsResponse = bufferDetailsResponseFromJson(jsonString);

import 'dart:convert';

BufferDetailsResponse bufferDetailsResponseFromJson(String str) => BufferDetailsResponse.fromJson(json.decode(str));

String bufferDetailsResponseToJson(BufferDetailsResponse data) => json.encode(data.toJson());

class BufferDetailsResponse {
  bool? statusOk;
  int? statusCode;
  List<dynamic>? message;
  Payload? payload;
  List<dynamic>? error;

  BufferDetailsResponse({
    this.statusOk,
    this.statusCode,
    this.message,
    this.payload,
    this.error,
  });

  factory BufferDetailsResponse.fromJson(Map<String, dynamic> json) => BufferDetailsResponse(
    statusOk: json["statusOk"],
    statusCode: json["statusCode"],
    message: json["message"] == null ? [] : List<dynamic>.from(json["message"]!.map((x) => x)),
    payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
    error: json["error"] == null ? [] : List<dynamic>.from(json["error"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "statusOk": statusOk,
    "statusCode": statusCode,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
    "payload": payload?.toJson(),
    "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
  };
}

class Payload {
  int? bufferBefore430;
  int? bufferAfter430;
  String? isWednesday;
  int? wednesdayBufferBefore430;
  int? wednesdayBufferAfter430;

  Payload({
    this.bufferBefore430,
    this.bufferAfter430,
    this.isWednesday,
    this.wednesdayBufferBefore430,
    this.wednesdayBufferAfter430,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    bufferBefore430: json["buffer_before_4_30"],
    bufferAfter430: json["buffer_after_4_30"],
    isWednesday: json["is_wednesday"],
    wednesdayBufferBefore430: json["wednesday_buffer_before_4_30"],
    wednesdayBufferAfter430: json["wednesday_buffer_after_4_30"],
  );

  Map<String, dynamic> toJson() => {
    "buffer_before_4_30": bufferBefore430,
    "buffer_after_4_30": bufferAfter430,
    "is_wednesday": isWednesday,
    "wednesday_buffer_before_4_30": wednesdayBufferBefore430,
    "wednesday_buffer_after_4_30": wednesdayBufferAfter430,
  };
}
