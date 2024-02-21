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
      userVerification: json['userVerification'] as String?,
    );

Map<String, dynamic> _$AuthenticatorSelectionCriteriaToJson(
        AuthenticatorSelectionCriteria instance) =>
    <String, dynamic>{
      'authenticatorAttachment':
          _$AuthenticatorAttachmentEnumMap[instance.authenticatorAttachment],
      'userVerification': instance.userVerification,
    };

const _$AuthenticatorAttachmentEnumMap = {
  AuthenticatorAttachment.platform: 'platform',
  AuthenticatorAttachment.crossPlatform: 'cross-platform',
};
