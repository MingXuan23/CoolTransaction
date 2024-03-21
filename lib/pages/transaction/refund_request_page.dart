import 'package:flutter/material.dart';

class RefundRequestPage extends StatefulWidget {
  const RefundRequestPage({Key? key}) : super(key: key);

  @override
  State<RefundRequestPage> createState() => _RefundRequestPageState();
}

class _RefundRequestPageState extends State<RefundRequestPage> {
  var selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5465FF),
        title: Text(
          'Refund Request',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                "Select Reason",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
              RadioListTile<int>(
                title: Text('Wrong Item'),
                value: 1,
                groupValue: selectedOption,
                activeColor: Color(0xFF5465FF),
                onChanged: (value) {
                  setState(() {
                    selectedOption = value!;
                    print("Button value: $value");
                  });
                },
              ),
              RadioListTile<int>(
                title: Text('Damaged Item'),
                value: 2,
                groupValue: selectedOption,
                activeColor: Color(0xFF5465FF),
                onChanged: (value) {
                  setState(() {
                    selectedOption = value!;
                    print("Button value: $value");
                  });
                },
              ),
              RadioListTile<int>(
                title: Text('Others'),
                value: 3,
                groupValue: selectedOption,
                activeColor: Color(0xFF5465FF),
                onChanged: (value) {
                  setState(() {
                    selectedOption = value!;
                    print("Button value: $value");
                  });
                },
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
                    'Submit for Refund',
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
      ),
    );
  }
}
