// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'error_response.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> {
  final int? timestamp;
  final ErrorResponse? error;
  final T data;

  ApiResponse({
    this.timestamp,
    this.error,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(
        json,
        fromJsonT,
      );

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$ApiResponseToJson(
        this,
        toJsonT,
      );
}
