// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticator_assertion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticatorAssertionResponse _$AuthenticatorAssertionResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticatorAssertionResponse(
      clientDataJSON: json['clientDataJSON'] as String,
      authenticatorData: json['authenticatorData'] as String,
      signature: json['signature'] as String,
      userHandle: json['userHandle'] as String?,
    );

Map<String, dynamic> _$AuthenticatorAssertionResponseToJson(
        AuthenticatorAssertionResponse instance) =>
    <String, dynamic>{
      'clientDataJSON': instance.clientDataJSON,
      'authenticatorData': instance.authenticatorData,
      'signature': instance.signature,
      'userHandle': instance.userHandle,
    };
