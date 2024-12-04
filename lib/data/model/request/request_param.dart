// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sort_order.dart';

part 'request_param.g.dart';

@JsonSerializable()
class RequestParam extends Equatable {
  /// Số item đầu tiên được skip
  /// Ví dụ xử lý phân trang mỗi trang 20 item thì trang đầu tiên skip = 0, trang thứ hai skip = 20, trang thứ ba skip = 40
  final int skip;
  final int limit;
  final String? sortBy;
  final SortOrder? order;
  @JsonKey(name: 'q')
  final String? query;

  const RequestParam({
    this.skip = 0,
    this.limit = 20,
    this.sortBy,
    this.order,
    this.query,
  });

  static const RequestParam FIRST_PAGE = RequestParam();

  RequestParam nextPage() => copyWith(skip: skip + limit);

  factory RequestParam.fromJson(Map<String, dynamic> json) => _$RequestParamFromJson(json);
  Map<String, dynamic> toJson() => _$RequestParamToJson(this);

  RequestParam copyWith({
    int? skip,
    int? limit,
    String? sortBy,
    SortOrder? order,
    String? query,
  }) {
    return RequestParam(
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      sortBy: sortBy ?? this.sortBy,
      order: order ?? this.order,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props {
    return [
      skip,
      limit,
      sortBy,
      order,
      query,
    ];
  }
}
