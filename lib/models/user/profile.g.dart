// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'username',
      'email_verified',
      'is_trustworthy',
      'email'
    ],
  );
  return Profile(
    username: json['username'] as String,
    emailVerified: json['email_verified'] as bool,
    isTrustworthy: json['is_trustworthy'] as bool,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'username': instance.username,
      'email_verified': instance.emailVerified,
      'is_trustworthy': instance.isTrustworthy,
      'email': instance.email,
    };
