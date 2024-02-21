// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_key_credential_creation_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicKeyCredentialCreationOptions _$PublicKeyCredentialCreationOptionsFromJson(
        Map<String, dynamic> json) =>
    PublicKeyCredentialCreationOptions(
      rp: PublicKeyCredentialRp.fromJson(json['rp'] as Map<String, dynamic>),
      user: PublicKeyCredentialUser.fromJson(
          json['user'] as Map<String, dynamic>),
      challenge: json['challenge'] as String,
      pubKeyCredParams: (json['pubKeyCredParams'] as List<dynamic>)
          .map((e) =>
              PublicKeyCredentialParameters.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeout: json['timeout'] as int,
      authenticatorSelection: json['authenticatorSelection'] == null
          ? null
          : AuthenticatorSelectionCriteria.fromJson(
              json['authenticatorSelection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PublicKeyCredentialCreationOptionsToJson(
        PublicKeyCredentialCreationOptions instance) =>
    <String, dynamic>{
      'rp': instance.rp,
      'user': instance.user,
      'challenge': instance.challenge,
      'pubKeyCredParams': instance.pubKeyCredParams,
      'timeout': instance.timeout,
      'authenticatorSelection': instance.authenticatorSelection,
    };
