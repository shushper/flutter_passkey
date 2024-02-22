import 'package:flutter_passkey/models/cose_algorithm_identifier.dart';
import 'package:flutter_passkey/models/public_key_credential_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_key_credential_parameters.g.dart';

@JsonSerializable(includeIfNull: false)
class PublicKeyCredentialParameters {
  final PublicKeyCredentialType type;
  final COSEAlgorithmIdentifier alg;

  PublicKeyCredentialParameters({
    required this.type,
    required this.alg,
  });

  factory PublicKeyCredentialParameters.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyCredentialParametersFromJson(json);

  Map<String, dynamic> toJson() => _$PublicKeyCredentialParametersToJson(this);
}
