import 'package:flutter_passkey/models/public_key_credential_parameters.dart';
import 'package:flutter_passkey/models/public_key_credential_rp.dart';
import 'package:flutter_passkey/models/public_key_credential_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_key_credential_creation_options.g.dart';

//https://w3c.github.io/webauthn/#dictdef-publickeycredentialcreationoptionsjson
@JsonSerializable()
class PublicKeyCredentialCreationOptions {
  final PublicKeyCredentialRp rp;
  final PublicKeyCredentialUser user;
  final String challenge;
  final List<PublicKeyCredentialParameters> pubKeyCredParams;
  final int timeout;

  PublicKeyCredentialCreationOptions({
    required this.rp,
    required this.user,
    required this.challenge,
    required this.pubKeyCredParams,
    required this.timeout,
  });

  factory PublicKeyCredentialCreationOptions.fromJson(
          Map<String, dynamic> json) =>
      _$PublicKeyCredentialCreationOptionsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PublicKeyCredentialCreationOptionsToJson(this);
}
