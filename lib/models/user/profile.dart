import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  @JsonKey(required: true)
  String username;

  @JsonKey(required: true, name: 'email_verified')
  bool emailVerified;

  @JsonKey(required: true, name: 'is_trustworthy')
  bool isTrustworthy;

  @JsonKey(required: true)
  String email;

  Profile({
    required this.username,
    required this.emailVerified,
    required this.isTrustworthy,
    required this.email,
  });

  // Boilerplate
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
