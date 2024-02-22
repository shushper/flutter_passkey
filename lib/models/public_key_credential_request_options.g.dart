// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_key_credential_request_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicKeyCredentialRequestOptions _$PublicKeyCredentialRequestOptionsFromJson(
        Map<String, dynamic> json) =>
    PublicKeyCredentialRequestOptions(
      challenge: json['challenge'] as String,
      timeout: json['timeout'] as int,
      rpId: json['rpId'] as String,
      allowCredentials: (json['allowCredentials'] as List<dynamic>)
          .map((e) =>
              PublicKeyCredentialDescriptor.fromJson(e as Map<String, dynamic>))
          .toList(),
      userVerification: $enumDecodeNullable(
          _$UserVerificationRequirementEnumMap, json['userVerification']),
    );

Map<String, dynamic> _$PublicKeyCredentialRequestOptionsToJson(
    PublicKeyCredentialRequestOptions instance) {
  final val = <String, dynamic>{
    'challenge': instance.challenge,
    'timeout': instance.timeout,
    'rpId': instance.rpId,
    'allowCredentials': instance.allowCredentials,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userVerification',
      _$UserVerificationRequirementEnumMap[instance.userVerification]);
  return val;
}

const _$UserVerificationRequirementEnumMap = {
  UserVerificationRequirement.required: 'required',
  UserVerificationRequirement.preferred: 'preferred',
  UserVerificationRequirement.discouraged: 'discouraged',
};
