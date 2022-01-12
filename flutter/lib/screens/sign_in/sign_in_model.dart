import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:online_yoklama/screens/sign_in/signin_page.dart';
import 'package:online_yoklama/services/auth.dart';
import 'package:online_yoklama/validators.dart';

class SignInModel with EmailAndPasswordValidator, ChangeNotifier {
  AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool submitted;
  bool isLoading;

  SignInModel({
    required this.auth,
    this.email = "",
    this.password = "",
    this.formType = EmailSignInFormType.signIn,
    this.submitted = false,
    this.isLoading = false,
  });

  void updateWith(
      {String? email,
      String? password,
      EmailSignInFormType? formType,
      bool? submitted,
      bool? isLoading}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.submitted = submitted ?? this.submitted;
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }

  void toggleFormType() {
    var formtype = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
        email: "",
        password: "",
        formType: formtype,
        submitted: false,
        isLoading: false);
  }

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (this.formType == EmailSignInFormType.signIn) {
        auth.signInWithEmailAndPassword(this.email, this.password);
      } else {
        auth.createUserWithEmailandPassword(this.email, this.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  String? get emailErrorText {
    return submitted && emailValidator.isValid(email)
        ? "E-mail can't be empty."
        : null;
  }

  String? get passwordErrorText {
    return submitted && passwordValidator.isValid(password)
        ? "Password can't be empty."
        : null;
  }

  String get primaryTextButton {
    return formType == EmailSignInFormType.signIn ? "Sign In" : "Register";
  }

  String get secondaryTextButton {
    return formType == EmailSignInFormType.signIn
        ? "Need an account? Register"
        : "Have an Account ? Sign In";
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
}
