import 'dart:async';

import 'package:flutter/material.dart';
import 'package:online_yoklama/screens/sign_in/sign_in_model.dart';
import 'package:online_yoklama/services/auth.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType { signIn, register }

class SignInPage extends StatefulWidget {
  SignInPage({Key? key, required this.model}) : super(key: key);

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(auth: auth),
      child: Consumer<SignInModel>(
        builder: (_, model, __) => SignInPage(
          model: model,
        ),
      ),
    );
  }

  final SignInModel model;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  SignInModel get model => widget.model;

  Future<void> _submit() async {
    try {
      await model.submit();
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Sign in Failed."),
              content: Text(
                e.toString(),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {},
                  child: Text("OK"),
                ),
              ],
            );
          });
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(SignInModel? model) {
    return [
      _buildEmailTextField(model!),
      SizedBox(height: 8),
      _buildPasswordTextField(model),
      SizedBox(height: 8),
      MaterialButton(
        child: Text(model.primaryTextButton),
        onPressed: model.canSubmit ? _submit : () {},
        color: model.canSubmit ? Colors.blue : Colors.grey,
      ),
      TextButton(
        child: Text(
          model.secondaryTextButton,
        ),
        onPressed: model.isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildEmailTextField(SignInModel model) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "test@test.com",
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(model),
      onChanged: model.updateEmail,
    );
  }

  TextField _buildPasswordTextField(SignInModel model) {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: "Parola",
        hintText: "Password",
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: model.updatePassword,
    );
  }

  void _emailEditingComplete(SignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign In",
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: _buildChildren(model),
        ),
      )),
    );
  }
}
