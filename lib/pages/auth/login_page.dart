import 'package:cool_transaction/blocs/auth/login/login_bloc.dart';
import 'package:cool_transaction/pages/home/home_page.dart';
import 'package:cool_transaction/widget/common/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cool_transaction/widget/common/large_button.dart';

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
          }
          if (state is LoginSuccess ) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return SafeArea(
                child: Stack(
                      children: [
                        Container(
                          color : Colors.blueAccent.shade700,
                        ),
                        Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Log in',
                                  style: TextStyle(fontSize: 32.0, color: Colors.white),
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 3,
                              child:
                              Container(
                                decoration : const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),

                                ),
                                  child : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Align(
                                                  alignment: Alignment.centerRight,
                                                  child: CloseButton(),
                                                ),
                                                const SizedBox(height: 20.0),
                                                Text(
                                                  'Email',
                                                  style: TextStyle(
                                                      color: Colors.blueAccent.shade700
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.grey.shade100),
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
                                                      color: Colors.blueAccent.shade700
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                TextField(
                                                  obscureText: _obscureText,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.grey.shade100),
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
                                                    style: TextStyle(color: Colors.blueAccent.shade700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ),
                                       Expanded(
                                         flex: 2,
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.stretch,
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 const Text(
                                                 'Don\'t you have an account? ',
                                                     style : TextStyle(
                                                       color: Colors.grey,
                                                       fontSize : 14.0,
                                                     )
                                                 ),
                                                 Text(
                                                   'Sign up',
                                                     style: TextStyle(
                                                       color: Colors.blueAccent.shade700,
                                                       fontSize: 14.0,
                                                     ),
                                                 ),
                                               ]
                                             ),
                                             const SizedBox(
                                               height: 4.0,
                                             ),
                                             LargeButton(
                                               buttonText: 'Log in',
                                               onTap: const HomePage(),
                                               color: Colors.blueAccent.shade700,
                                               textColor: Colors.white,
                                            ),
                                           ],
                                         ),
                                       ),
                                       /* Expanded(
                                          flex: 8,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 20.0),
                                              SizedBox(
                                                  width: 400.0,
                                                  height: 55.0,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (state is! LoginLoading) {
                                                        BlocProvider.of<LoginBloc>(context).add(
                                                          LoginButtonPressed(
                                                            email: _emailController.text,
                                                            password: _passwordController.text,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Text(
                                                      'Log In',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                        Colors.blue,
                                                      ),
                                                    ),
                                                  )),
                                              SizedBox(height: 10.0),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Don\'t have an account?',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Sign up',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),*/

                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ]
              ),
            );
          },
        ),
      ),
    );
  }
}
