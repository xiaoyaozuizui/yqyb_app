// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'id', 'type', 'status', 'store_status'],
  );
  return Device(
    name: json['name'] as String,
    id: json['id'] as String,
    type: json['type'] as String,
    status: json['status'] as String,
    store_status: json['store_status'] as String,
  )
    ..message = json['message'] as String?
    ..checked = json['checked'] as bool?;
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'type': instance.type,
      'status': instance.status,
      'store_status': instance.store_status,
      'message': instance.message,
      'checked': instance.checked,
    };
