import 'package:json_annotation/json_annotation.dart';

part 'devices.g.dart';

@JsonSerializable()
class Device {
  @JsonKey(required: true)
  String name;

  @JsonKey(required: true)
  String id;

  @JsonKey(required: true)
  String type;

  @JsonKey(required: true)
  String status;

  @JsonKey(required: true)
  String store_status;

  @JsonKey(required: false)
  String? message;

  @JsonKey(required: false)
  bool? checked;

  Device({
    required this.name,
    required this.id,
    required this.type,
    required this.status,
    required this.store_status,
  });

  // Boilerplate
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
