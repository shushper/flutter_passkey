// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_key_credential_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicKeyCredentialParameters _$PublicKeyCredentialParametersFromJson(
        Map<String, dynamic> json) =>
    PublicKeyCredentialParameters(
      type: json['type'] as String,
      alg: $enumDecode(_$COSEAlgorithmIdentifierEnumMap, json['alg']),
    );

Map<String, dynamic> _$PublicKeyCredentialParametersToJson(
        PublicKeyCredentialParameters instance) =>
    <String, dynamic>{
      'type': instance.type,
      'alg': _$COSEAlgorithmIdentifierEnumMap[instance.alg]!,
    };

const _$COSEAlgorithmIdentifierEnumMap = {
  COSEAlgorithmIdentifier.ES256: -7,
  COSEAlgorithmIdentifier.ES384: -35,
  COSEAlgorithmIdentifier.ES512: -36,
  COSEAlgorithmIdentifier.EdDSA: -8,
};
