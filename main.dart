import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'My Login Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _continueText = 'Continue without logging in';
  bool _clickAgain = true;
  bool _passwordVisible = false;
  bool _isObscure = true;
  bool _checkboxvalue = true;
  final FocusNode _focusNode = FocusNode();
  bool _isCapsLockOn = false;
  String _message = '';

  @override
  void dispose() {
    _focusNode.dispose();
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
        title: const Text('Sign in'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),

            //Email field
            TextField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'E-mail',  
              ),
            ),
            const SizedBox(height: 12.0),
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
              //Password field
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'Password',
                    suffixText: _message,
                    suffixStyle: TextStyle(
                      color: Colors.red,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
                obscureText: _isObscure,
              ),
            ),
            const SizedBox(height: 12.0),
            OverflowBar(
              alignment: MainAxisAlignment.start,
              children: [
                CheckboxListTile(
                    title: const Text("Remember username?"),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _checkboxvalue,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkboxvalue = value!;
                      });
                    })
              ],
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Forgot Password?"),
                ),
                TextButton(
                  onPressed: () {
                    if (_usernameController.text != '' &&
                        _passwordController.text != '') {
                      setState(() {
                        if (_clickAgain) {
                          _continueText =
                              'Click again to continue without logging in';
                        } else {
                          _usernameController.clear();
                          _passwordController.clear();
                          _continueText = 'Continue without logging in';
                        }
                        _clickAgain = !_clickAgain;
                      });
                    }
                  },
                  child: Text(_continueText),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                  child: const Text('LOGIN'),
                ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
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
                Text("Need an account?"),
                TextButton(
                  child: Text("Sign Up"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
