import 'package:flutter/material.dart';
import 'package:cool_transaction/widget/common/large_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cool_transaction/pages/auth/login_page.dart';

const List<String> list = <String>['RHB Bank', 'Bank Islam', 'Maybank', 'CIMB Bank'];

class SignUpThirdScreen extends StatefulWidget {
  const SignUpThirdScreen({super.key});

  @override
  State<SignUpThirdScreen> createState() => _SignUpThirdScreenState();
}

class _SignUpThirdScreenState extends State<SignUpThirdScreen> {
  final TextEditingController _accountNumberController = TextEditingController();
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        SafeArea(
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
                        padding:
                        const EdgeInsetsDirectional.symmetric(
                            horizontal: 50, vertical: 20,
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
                              child : Column(
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
                                    child : const Text(
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
                              child : Column(
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
                                    child : const Text(
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
                              child : Column(
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
                                    child : const Text(
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
                      child:
                      Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: SingleChildScrollView(
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerRight,
                                          child: CloseButton(),
                                        ),
                                        const SizedBox(height: 14.0,),
                                        Text(
                                          'Bank',
                                          style: TextStyle(
                                            color: Colors.blueAccent.shade700,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        DropdownButton<String>(
                                          value: dropdownValue,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;
                                            });
                                          },
                                          items: list
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(height: 14.0,),
                                        Text(
                                          'Account Number',
                                          style: TextStyle(
                                            color: Colors.blueAccent.shade700,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.shade100),
                                            ),
                                            hintText: 'e.g. 111122223333',
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          controller: _accountNumberController,
                                        ),

                                      ],
                                    ),
                                  )

                                ),
                                Expanded(
                                  flex : 1,
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: LargeButton(
                                      buttonText: 'Register',
                                      onTap: LoginPage(),
                                      color: Colors.blueAccent.shade700,
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )

                      ),
                    ),
                  ],
                ),
              ],
            )
        ),

    );
  }
}