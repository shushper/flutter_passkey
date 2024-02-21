// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticator_attestation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticatorAttestationResponse _$AuthenticatorAttestationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticatorAttestationResponse(
      clientDataJSON: json['clientDataJSON'] as String,
      attestationObject: json['attestationObject'] as String,
    );

Map<String, dynamic> _$AuthenticatorAttestationResponseToJson(
        AuthenticatorAttestationResponse instance) =>
    <String, dynamic>{
      'clientDataJSON': instance.clientDataJSON,
      'attestationObject': instance.attestationObject,
    };
