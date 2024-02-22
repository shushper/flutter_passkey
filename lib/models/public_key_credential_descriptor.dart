import 'package:flutter_passkey/models/authenticator_transport.dart';
import 'package:flutter_passkey/models/public_key_credential_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_key_credential_descriptor.g.dart';

@JsonSerializable(includeIfNull: false)
class PublicKeyCredentialDescriptor {
  final PublicKeyCredentialType type;
  final String id;
  final List<AuthenticatorTransport>? transports;

  const PublicKeyCredentialDescriptor({
    required this.type,
    required this.id,
    this.transports,
  });

  factory PublicKeyCredentialDescriptor.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyCredentialDescriptorFromJson(json);

  Map<String, dynamic> toJson() => _$PublicKeyCredentialDescriptorToJson(this);
}
