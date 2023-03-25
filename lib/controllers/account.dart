import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

bool validateEmail(String email) {
  return EmailValidator.validate(email);
}

bool validatePassword(String password) {

  bool length = password.length >= 8;
  bool hasUpper = password.contains(RegExp(r'[A-Z]'));
  bool hasLower = password.contains(RegExp(r'[a-z]'));
  bool hasDigit = password.contains(RegExp(r'\d'));
  bool hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  return length & hasUpper & hasLower & hasDigit & hasSpecial;
}