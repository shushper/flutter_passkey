import 'package:json_annotation/json_annotation.dart';

part 'public_key_credential_rp.g.dart';

@JsonSerializable()
class PublicKeyCredentialRp {
  final String id;
  final String name;

  const PublicKeyCredentialRp({
    required this.id,
    required this.name,
  });

  factory PublicKeyCredentialRp.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyCredentialRpFromJson(json);

  Map<String, dynamic> toJson() => _$PublicKeyCredentialRpToJson(this);
}
