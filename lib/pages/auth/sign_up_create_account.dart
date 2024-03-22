import 'package:cool_transaction/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cool_transaction/widget/common/large_button.dart';
import 'package:cool_transaction/pages/auth/sign_up_personal_information.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            color: Colors.blueAccent.shade700,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade700,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 24,
                              width: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '1',
                              ),
                            ),
                            const SizedBox(
                              height: 1.0,
                            ),
                            const Text(
                              'Create',
                            ),
                            const Text('Account'),
                          ],
                        ),
                      ),
                      Container(
                        height: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '2',
                              ),
                            ),
                            const SizedBox(
                              height: 1.0,
                            ),
                            const Text(
                              'Personal',
                            ),
                            const Text('Information'),
                          ],
                        ),
                      ),
                      Container(
                        height: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '3',
                              ),
                            ),
                            const SizedBox(
                              height: 1.0,
                            ),
                            const Text(
                              'Bank',
                            ),
                            const Text('Information'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              flex: 8,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CloseButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                      'Username',
                                      style: TextStyle(
                                        color: Colors.blueAccent.shade700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade100),
                                        ),
                                        hintText: 'JohnDoe123',
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      controller: _usernameController,
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
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
                                    const SizedBox(
                                      height: 14.0,
                                    ),
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
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                      'Confirm Password',
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
                                      controller: _confirmPasswordController,
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: LargeButton(
                                buttonText: 'Next',
                                onTap: const SignUpSecScreen(),
                                color: Colors.blueAccent.shade700,
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
