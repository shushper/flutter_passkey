import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum AuthenticatorAttachment {
  platform('platform'),
  crossPlatform('cross-platform');

  const AuthenticatorAttachment(this.value);

  final String value;
}
