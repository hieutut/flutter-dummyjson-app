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

Map<String, dynamic> _$RequestParamToJson(RequestParam instance) {
  final val = <String, dynamic>{
    'skip': instance.skip,
    'limit': instance.limit,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sortBy', instance.sortBy);
  writeNotNull('order', _$SortOrderEnumMap[instance.order]);
  writeNotNull('q', instance.query);
  return val;
}

const _$SortOrderEnumMap = {
  SortOrder.asc: 'asc',
  SortOrder.desc: 'desc',
};
