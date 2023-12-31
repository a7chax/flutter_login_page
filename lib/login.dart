import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:login_page/homepage.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    void handleClick(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomepageScreen()),
      );
    }


    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return LoginMobile(handleClick: handleClick);
    });
  }
}


class LoginMobile extends StatefulWidget {
  final void Function() handleClick;

  LoginMobile({Key? key, required this.handleClick}) : super(key: key);

  @override
  _LoginMobile createState() => _LoginMobile();
}

class _LoginMobile extends State<LoginMobile> {
  String _emailValue = '';
  String _passwordValue = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or image (optional)
                // ...

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(height: 8),
                      MyTextField(
                        initialValue: _emailValue,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          // Add more validation logic as needed
                          return null; // Return null if validation passes
                        },
                        onValueChanged: (value) {
                          setState(() {
                            _emailValue = value;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(height: 8),
                      MyTextField(
                        obscureText: true,
                        initialValue: _passwordValue,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'Minimum 6 Character';
                          }
                          // Add more validation logic as needed
                          return null; // Return null if validation passes
                        },
                        onValueChanged: (value) {
                          setState(() {
                            _passwordValue = value;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if(_emailValue.isNotEmpty && _passwordValue.isNotEmpty){
                            widget.handleClick();
                          }else {
                            _showToast(context);
                          }
                        },
                        child: const Text('Login'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Email or Password is empty'),
    ),
  );
}

class MyTextField extends StatefulWidget {
  final bool obscureText;
  final String? initialValue;
  final String? Function(String)? validator;
  final void Function(String)? onValueChanged;

  MyTextField({this.initialValue, this.validator, this.onValueChanged, this.obscureText = false});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late TextEditingController _controller;

  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {

    return TextField(
      obscureText: widget.obscureText,
      controller: _controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorText: _errorText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        if (widget.validator != null) {
          setState(() {
            _errorText = widget.validator!(value);
          });
        }

        if (widget.onValueChanged != null) {
          widget.onValueChanged!(value);
        }
      },
    );
  }
}


class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String _textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          initialValue: _textFieldValue,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            // Add more validation logic as needed
            return ""; // Return null if validation passes
          },
          onValueChanged: (value) {
            setState(() {
              _textFieldValue = value;
            });
          },
        ),
        // Other form components and buttons go here
      ],
    );
  }
}


