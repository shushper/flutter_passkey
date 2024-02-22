// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticator_selection_criteria.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticatorSelectionCriteria _$AuthenticatorSelectionCriteriaFromJson(
        Map<String, dynamic> json) =>
    AuthenticatorSelectionCriteria(
      authenticatorAttachment: $enumDecodeNullable(
          _$AuthenticatorAttachmentEnumMap, json['authenticatorAttachment']),
      userVerification: $enumDecodeNullable(
          _$UserVerificationRequirementEnumMap, json['userVerification']),
    );

Map<String, dynamic> _$AuthenticatorSelectionCriteriaToJson(
    AuthenticatorSelectionCriteria instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('authenticatorAttachment',
      _$AuthenticatorAttachmentEnumMap[instance.authenticatorAttachment]);
  writeNotNull('userVerification',
      _$UserVerificationRequirementEnumMap[instance.userVerification]);
  return val;
}

const _$AuthenticatorAttachmentEnumMap = {
  AuthenticatorAttachment.platform: 'platform',
  AuthenticatorAttachment.crossPlatform: 'cross-platform',
};

const _$UserVerificationRequirementEnumMap = {
  UserVerificationRequirement.required: 'required',
  UserVerificationRequirement.preferred: 'preferred',
  UserVerificationRequirement.discouraged: 'discouraged',
};
