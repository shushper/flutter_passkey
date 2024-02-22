// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      id: json['id'] as String,
      rawId: json['rawId'] as String,
      type: json['type'] as String,
      response: AuthenticatorAssertionResponse.fromJson(
          json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rawId': instance.rawId,
      'type': instance.type,
      'response': instance.response,
    };
