// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_key_credential_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicKeyCredentialUser _$PublicKeyCredentialUserFromJson(
        Map<String, dynamic> json) =>
    PublicKeyCredentialUser(
      id: json['id'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$PublicKeyCredentialUserToJson(
        PublicKeyCredentialUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
    };
