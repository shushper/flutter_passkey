import 'package:flutter_passkey/models/authenticator_assertion_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_response.g.dart';

@JsonSerializable()
class AuthenticationResponse {
  final String id;
  final String rawId;
  final String type;
  final AuthenticatorAssertionResponse response;

  const AuthenticationResponse({
    required this.id,
    required this.rawId,
    required this.type,
    required this.response,
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}