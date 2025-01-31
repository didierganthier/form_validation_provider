import 'package:flutter/material.dart';

enum FormStateEnum {
  initial,
  validating,
  valid,
  invalid,
  submitting,
  submitted
}

class FormProvider extends ChangeNotifier {
  String _name = '';
  String get name => _name;

  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  FormStateEnum _state = FormStateEnum.initial;
  FormStateEnum get state => _state;

  String _nameError = '';
  String get nameError => _nameError;

  String _emailError = '';
  String get emailError => _emailError;

  String _passwordError = '';
  String get passwordError => _passwordError;

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = email;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = password;
    notifyListeners();
  }

  void validateForm() {
    _state = FormStateEnum.validating;
    _nameError = validateName(_name);
    _emailError = validateEmail(_email);
    _passwordError = validatePassword(_password);

    if (_nameError.isEmpty && _emailError.isEmpty && _passwordError.isEmpty) {
      _state = FormStateEnum.valid;
    } else {
      _state = FormStateEnum.invalid;
    }
    notifyListeners();
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return '';
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }

    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Invalid Email';
    }

    return '';
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return '';
  }

  Future<void> submitForm() async {
    _state = FormStateEnum.submitting;
    notifyListeners();

    await Future.delayed(
      Duration(
        seconds: 3,
      ),
    );

    _state = FormStateEnum.submitted;
    notifyListeners();
  }

  void resetForm() {
    _state = FormStateEnum.initial;
    _name = "";
    _email = "";
    _password = "";
    _nameError = "";
    _emailError = "";
    _passwordError = "";
    notifyListeners();
  }
}
