import 'package:cool_transaction/blocs/auth/login/login_bloc.dart';
import 'package:cool_transaction/pages/auth/sign_up_create_account.dart';
import 'package:cool_transaction/pages/home/home_page.dart';
import 'package:cool_transaction/widget/common/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  @override
  void initState() {
    super.initState();
    checkLoggedInUser();
  }

  void checkLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(
        'user'); // Assuming 'userId' is the key used to store the user ID
    if (userId != null) {
      // If user is already logged in, navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is LoginLoading) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return LoadingOverlay();
              },
            );
          } else {
            // Dismiss the dialog if it's shown
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return SafeArea(
              child: Stack(children: [
                Container(
                  color: Colors.blueAccent.shade700,
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 2,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.shade700,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/safetyBox.png',
                              height: 240,
                              width: 220,
                              fit: BoxFit.contain,
                            ),
                        ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Log In',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent.shade700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                            color: Colors.blueAccent.shade700),
                                        textAlign: TextAlign.left,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade100),
                                          ),
                                          hintText: '****@example.com',
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        controller: _emailController,
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        'Password',
                                        style: TextStyle(
                                            color: Colors.blueAccent.shade700),
                                        textAlign: TextAlign.left,
                                      ),
                                      TextField(
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade100),
                                          ),
                                          hintText: 'Password',
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Choose the icon based on the visibility state
                                              _obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () {
                                              // Change the visibility state when the icon is clicked
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          ),
                                        ),
                                        controller: _passwordController,
                                      ),
                                      const SizedBox(height: 10.0),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                              color:
                                                  Colors.blueAccent.shade700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                                'Don\'t you have an account? ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14.0,
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SignUpScreen()),
                                                );
                                              },
                                              child: Text(
                                                'Sign up',
                                                style: TextStyle(
                                                  color: Colors
                                                      .blueAccent.shade700,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (state is! LoginLoading) {
                                            BlocProvider.of<LoginBloc>(context)
                                                .add(
                                              LoginButtonPressed(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                              ),
                                            );
                                          }
                                        },

                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Color(0xFF5465FF),
                                          ),
                                        ),
                                        child: const Text(
                                        'Log In',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
