import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.kebab)
enum UserVerificationRequirement {
  required,
  preferred,
  discouraged
}