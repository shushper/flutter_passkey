import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum PublicKeyCredentialType {
  publicKey('public-key');

  const PublicKeyCredentialType(this.value);

  final String value;
}