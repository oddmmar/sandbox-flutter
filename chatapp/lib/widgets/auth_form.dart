import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.submitForm});
  // final Function submitForm;
  // previous this will work but maybe better to be explicit - USE SAME SIGNITURE
  final void Function({
    required String email,
    required String password,
    required String username,
    required bool isLoginMode,
    required BuildContext context,
  }) submitForm;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLoginMode = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    // Focus.of(context).unfocus();
    if (isValid != null) {
      if (isValid) {
        _formKey.currentState?.save();
        widget.submitForm(
            email: _userEmail.trim(),
            password: _userPassword.trim(),
            username: _userName.trim(),
            isLoginMode: _isLoginMode,
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value == null ||
                          !value.contains('@') ||
                          value.isEmpty) {
                        return 'Please enter a valid email.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'email address'),
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                  ),
                  if (!_isLoginMode)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Please enter a username that is at least 4 charecters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'username'),
                      onSaved: (newValue) {
                        _userName = newValue!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.length < 7) {
                        return 'Please enter a password that is at least 7 charecters long';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'password'),
                    onSaved: (newValue) {
                      _userPassword = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLoginMode ? 'Login' : 'Sign Up'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLoginMode = !_isLoginMode;
                      });
                    },
                    child: Text(_isLoginMode
                        ? 'Create an account'
                        : 'Already have an account'),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
