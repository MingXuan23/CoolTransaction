import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cool_transaction/widget/common/large_button.dart';
import 'package:cool_transaction/pages/auth/login_page.dart';
import 'package:cool_transaction/pages/auth/sign_up_bank_information.dart';
import 'package:image_picker/image_picker.dart';

class SignUpSecScreen extends StatefulWidget {
  const SignUpSecScreen({super.key});

  @override
  State<SignUpSecScreen> createState() => _SignUpSecScreenState();
}

class _SignUpSecScreenState extends State<SignUpSecScreen> {
  final _nameController = TextEditingController();
  final _myKadController = TextEditingController();

  File? _selectedImages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                      'Full Name (Same as IC)',
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
                                        hintText: 'John Doe',
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      controller: _nameController,
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                      'MyKad',
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
                                        hintText: 'e.g. 80010101xxxx',
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      controller: _myKadController,
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                      'MyKad/Passport Image',
                                      style: TextStyle(
                                          color: Colors.blueAccent.shade700),
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white), // background
                                        textStyle: MaterialStateProperty.all(
                                            TextStyle(
                                                color: Colors
                                                    .blueAccent.shade700)),
                                      ),
                                      // foreground
                                      onPressed: () {
                                        _pickImageFromGallery();
                                      },
                                      child: Text('upload image'),
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Container(
                                      height: 62,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent.shade700,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          const SizedBox(
                                            height: 34,
                                            width: 34,
                                            child: Icon(
                                              Icons.error,
                                            ),
                                          ),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: const Text(
                                                  'Please provide a clear photo of \nyour MyKad / Passport for verification\n purpose. ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ))
                                        ],
                                      ),
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
                                onTap: const SignUpThirdScreen(),
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

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImages = File(returnedImage!.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().getImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      _selectedImages = File(returnedImage!.path);
    });
  }
}
