import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportScamPage extends StatefulWidget {
  const ReportScamPage({super.key});

  @override
  State<ReportScamPage> createState() => _ReportScamPageState();
}

class _ReportScamPageState extends State<ReportScamPage> {
  List<PickedFile> images = [];

  Future<void> pickImages(ImageSource source, {int maxImages = 5}) async {
    final pickedImage = await ImagePicker().getImage(source: source);

    if (pickedImage != null) {
      if (images.length < maxImages) {
        setState(() {
          images.add(pickedImage);
        });
      } else {
        print('You have reached the maximum amount of images');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5465FF),
        title: Text(
          'Report Scam',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 3,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Transaction No:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ABC121312',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Amount:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'RM100.00',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Photo:",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.start,
            ),
            ElevatedButton(
                onPressed: () => pickImages(ImageSource.gallery),
                child: Text('Pick Images'),
              ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: images.map((image) {
                return Image.file(
                  File(image.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.start,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write your description here...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFF5465FF)),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 55.0,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Generate Scam Report',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF5465FF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
