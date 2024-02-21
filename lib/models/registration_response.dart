import 'package:json_annotation/json_annotation.dart';

import 'authenticator_attestation_response.dart';

part 'registration_response.g.dart';

@JsonSerializable()
class RegistrationResponse {
  final String id;
  final String rawId;
  final String type;
  final AuthenticatorAttestationResponse response;

  const RegistrationResponse({
    required this.id,
    required this.rawId,
    required this.type,
    required this.response,
  });

  Map<String, dynamic> toJson() => _$RegistrationResponseToJson(this);

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseFromJson(json);
}