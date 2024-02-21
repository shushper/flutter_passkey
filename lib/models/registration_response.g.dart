// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResponse _$RegistrationResponseFromJson(
        Map<String, dynamic> json) =>
    RegistrationResponse(
      id: json['id'] as String,
      rawId: json['rawId'] as String,
      type: json['type'] as String,
      response: AuthenticatorAttestationResponse.fromJson(
          json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegistrationResponseToJson(
        RegistrationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rawId': instance.rawId,
      'type': instance.type,
      'response': instance.response,
    };
