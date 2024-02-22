import 'package:flutter_passkey/models/user_verification_requirement.dart';
import 'package:json_annotation/json_annotation.dart';

import 'authenticator_attachment.dart';

part 'authenticator_selection_criteria.g.dart';

@JsonSerializable()
class AuthenticatorSelectionCriteria {
  final AuthenticatorAttachment? authenticatorAttachment;
  final UserVerificationRequirement? userVerification;

  const AuthenticatorSelectionCriteria({
    this.authenticatorAttachment,
    this.userVerification,
  });

  factory AuthenticatorSelectionCriteria.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatorSelectionCriteriaFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatorSelectionCriteriaToJson(this);
}
