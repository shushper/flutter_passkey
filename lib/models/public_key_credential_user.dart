import 'package:json_annotation/json_annotation.dart';

part 'public_key_credential_user.g.dart';

@JsonSerializable()
class PublicKeyCredentialUser {
  final String id;
  final String name;
  final String displayName;

  const PublicKeyCredentialUser({
    required this.id,
    required this.name,
    required this.displayName,
  });

  factory PublicKeyCredentialUser.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyCredentialUserFromJson(json);

  Map<String, dynamic> toJson() => _$PublicKeyCredentialUserToJson(this);
}
