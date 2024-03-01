import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final field1Key = GlobalKey<FormFieldState>();
  final field2Key = GlobalKey<FormFieldState>();

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  //final FocusNode _focusNode = FocusNode();

  bool _passwordVisible = false;
  bool _isCapsLockOn = false;
  String _message = '';

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode1.addListener(() {
      if (!focusNode1.hasFocus) {
        field1Key.currentState?.validate();
      }
    });
    focusNode2.addListener(() {
      if (!focusNode2.hasFocus) {
        field2Key.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    _emailController;
    _passwordController;
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      _isCapsLockOn = HardwareKeyboard.instance.lockModesEnabled
          .contains(KeyboardLockMode.capsLock);

      if (_isCapsLockOn) {
        setState(() {
          _message = 'Caps Lock is ON';
        });
        return KeyEventResult.handled;
      } else {
        setState(() {
          _message = '';
        });
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 80.0),

              //EMAIL
              TextFormField(
                key: field1Key,
                autofocus: true,
                focusNode: focusNode1,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
                  } else if (!value.contains('@')) {
                    return 'The e-mail must contain the @ symbol';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),

              //PASSWORD
              Focus(
                onKeyEvent: _handleKeyEvent,
                onFocusChange: (value){
                _isCapsLockOn = HardwareKeyboard.instance.lockModesEnabled
          .contains(KeyboardLockMode.capsLock);

      if (_isCapsLockOn) {
        setState(() {
          _message = 'Caps Lock is ON';
        });
      } else {
        setState(() {
          _message = '';
        });
      }
              },
                child: TextFormField(
                  key: field2Key,
                  focusNode: focusNode2,
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Password',
                    suffixText: _message,
                    suffixStyle: TextStyle(color: Colors.red),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 10) {
                      return 'The password should be at least 10 characters';
                    } else if (value.length > 20) {
                      return 'Password should not be greater than 20 characters';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              OverflowBar(
                alignment: MainAxisAlignment.start,
                children: [
                  Text(
                      "The password must be between 10 and 20 characters long.")
                ],
              ),
              const SizedBox(height: 12.0),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('SIGN UP'),
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),

              //Social medias
              const Row(children: [
                Expanded(child: Divider()),
                SizedBox(
                  width: 10,
                ),

                Text("Or login with:"),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: Divider())
              ]),
              OverflowBar(
                alignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      isSelected: false,
                      color: Colors.black,
                      icon: Icon(Icons.facebook_sharp),
                      onPressed: () {}),
                  IconButton(
                    icon: Icon(Icons.apple),
                    onPressed: () {},
                  ),
                  IconButton(icon: Icon(Icons.window_sharp), onPressed: () {}),
                ],
              ),
              const Divider(),
              OverflowBar(
                alignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    child: Text("Log in"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
