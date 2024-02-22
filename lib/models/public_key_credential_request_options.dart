import 'package:flutter_passkey/models/user_verification_requirement.dart';
import 'package:json_annotation/json_annotation.dart';

import 'public_key_credential_descriptor.dart';

part 'public_key_credential_request_options.g.dart';

@JsonSerializable()
class PublicKeyCredentialRequestOptions {
  final String challenge;
  final int timeout;
  final String rpId;
  final List<PublicKeyCredentialDescriptor> allowCredentials;
  final UserVerificationRequirement userVerification;

  const PublicKeyCredentialRequestOptions({
    required this.challenge,
    required this.timeout,
    required this.rpId,
    required this.allowCredentials,
    required this.userVerification,
  });

  factory PublicKeyCredentialRequestOptions.fromJson(
          Map<String, dynamic> json) =>
      _$PublicKeyCredentialRequestOptionsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PublicKeyCredentialRequestOptionsToJson(this);
}

