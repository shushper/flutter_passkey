import 'package:json_annotation/json_annotation.dart';

part 'authenticator_attestation_response.g.dart';

@JsonSerializable()
class AuthenticatorAttestationResponse {
  final String clientDataJSON;
  final String attestationObject;

  const AuthenticatorAttestationResponse({
    required this.clientDataJSON,
    required this.attestationObject,
  });

  factory AuthenticatorAttestationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AuthenticatorAttestationResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AuthenticatorAttestationResponseToJson(this);
}