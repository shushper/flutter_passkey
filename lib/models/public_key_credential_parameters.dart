import 'package:flutter_passkey/models/cose_agorithm_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_key_credential_parameters.g.dart';

@JsonSerializable()
class PublicKeyCredentialParameters {
  final String type;
  final COSEAlgorithmIdentifier alg;

  PublicKeyCredentialParameters({
    required this.type,
    required this.alg,
  });

  factory PublicKeyCredentialParameters.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyCredentialParametersFromJson(json);

  Map<String, dynamic> toJson() => _$PublicKeyCredentialParametersToJson(this);
}
