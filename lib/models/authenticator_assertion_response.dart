import 'package:json_annotation/json_annotation.dart';

part 'authenticator_assertion_response.g.dart';

@JsonSerializable()
class AuthenticatorAssertionResponse {
  final String clientDataJSON;
  final String authenticatorData;
  final String signature;
  final String? userHandle;

  const AuthenticatorAssertionResponse({
    required this.clientDataJSON,
    required this.authenticatorData,
    required this.signature,
    this.userHandle,
  });


  factory AuthenticatorAssertionResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatorAssertionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatorAssertionResponseToJson(this);
}