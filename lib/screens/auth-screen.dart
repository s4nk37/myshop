import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF6ef195).withOpacity(0.5),
                  const Color(0xff00e3fd).withOpacity(0.7),
                ],
                radius: 0.9,
                stops: const [0, 1],
              ),
            ),
          ),
          Positioned(
            top: deviceSize.height * 0.11,
            child: SingleChildScrollView(
              child: SizedBox(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Lottie.asset(
                        'assets/lottie/login.json',
                        frameRate: FrameRate(30),
                        repeat: true,
                        reverse: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 80.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightGreen.withOpacity(0.5),
                        ),
                        child: const Text(
                          'My Shop',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 5.0,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: deviceSize.width > 600 ? 4 : 3,
                      child: const AuthCard(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  var _showPassword = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  // Animation<Size>? _heightAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _transitionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _transitionAnimation = Tween<Offset>(
      begin: const Offset(-2, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    // _heightAnimation!.addListener(
    //   () => setState(() {}),
    // );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // _controller!.dispose();
  // }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('An error occurred'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Okay")),
            ],
          );
        });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .signIn(_authData['email']!, _authData['password']!);
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email']!, _authData['password']!);
      }
    } on HttpException catch (error) {
      // print(error);
      var errorMessage = "Authentication Failed";
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = "This email is already in use";
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'This email is not registered';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Incorrect Password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = "Could not authenticate you. Please try again!";
      _showErrorDialog(errorMessage);
      rethrow;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  void _showPasswordToggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3.0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: AnimatedContainer(
        height: _authMode == AuthMode.Signup ? 360 : 290,
        curve: Curves.easeIn,
        // height: _heightAnimation!.value.height,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 360 : 290),
        // constraints: BoxConstraints(minHeight: _heightAnimation!.value.height),
        width: deviceSize.width * 0.80,
        // padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
        padding:
            const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 15),
        duration: const Duration(milliseconds: 300),

        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value.toString();
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: _showPasswordToggle,
                      icon: Icon(_showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  obscureText: !_showPassword,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value.toString();
                  },
                  onFieldSubmitted: (_) {
                    _submit();
                  },
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                  ),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _transitionAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration: const InputDecoration(
                            labelText: 'Confirm Password'),
                        obscureText: false,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      foregroundColor: Colors.green,
                      elevation: 0.0,
                    ),
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  ),
                TextButton(
                  onPressed: _switchAuthMode,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    // foregroundColor: Colors.lightGreen,
                  ),
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                    style: const TextStyle(color: Colors.lightGreen),
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
