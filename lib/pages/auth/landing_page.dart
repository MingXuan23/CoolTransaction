import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cool_transaction/widget/common/large_button.dart';
import 'package:cool_transaction/pages/auth/sign_up_create_account.dart';
import 'package:cool_transaction/pages/auth/login_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 6,
                  child:
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.shade700,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/safetyBox.png')
                  )
              ),

              Expanded(
                  flex: 3,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Text(''
                          'Scared of e-commerce scams?',
                        style: GoogleFonts.dmSans(

                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(''
                          'Let\'s "Cool" your payments!',
                        style: GoogleFonts.dmSans(

                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),
                      LargeButton(
                        buttonText: 'Login',
                        onTap: LoginPage(),
                        color: Colors.blueAccent.shade700,
                        textColor: Colors.white,
                      ),

                      LargeButton(
                        buttonText: 'Register',
                        onTap: SignUpScreen(),
                        color: Colors.white,
                        textColor: Colors.blueAccent.shade700,
                      ),
                    ],
                  )
              )
            ]
        )
    );
  }
}