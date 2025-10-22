// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestParam _$RequestParamFromJson(Map<String, dynamic> json) => RequestParam(
      skip: (json['skip'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
      sortBy: json['sortBy'] as String?,
      order: $enumDecodeNullable(_$SortOrderEnumMap, json['order']),
      query: json['q'] as String?,
    );

Map<String, dynamic> _$RequestParamToJson(RequestParam instance) =>
    <String, dynamic>{
      'skip': instance.skip,
      'limit': instance.limit,
      if (instance.sortBy case final value?) 'sortBy': value,
      if (_$SortOrderEnumMap[instance.order] case final value?) 'order': value,
      if (instance.query case final value?) 'q': value,
    };

const _$SortOrderEnumMap = {
  SortOrder.asc: 'asc',
  SortOrder.desc: 'desc',
};
