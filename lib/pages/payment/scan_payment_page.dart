import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cool_transaction/pages/payment/make_payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cool_transaction/blocs/scan_payment/scan_payment_bloc.dart';
import 'package:cool_transaction/blocs/scan_payment/scan_payment_event.dart';
import 'package:cool_transaction/blocs/scan_payment/scan_payment_state.dart';
import 'package:flutter_qr_scan/flutter_qr_scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPaymentPage extends StatefulWidget {
  @override
  _ScanPaymentPageState createState() => _ScanPaymentPageState();
}

class _ScanPaymentPageState extends State<ScanPaymentPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

 bool waiting = false;
 
@override
  void dispose() {
    super.dispose();
    //BlocProvider.of<ScanPaymentBloc>(context).close(); // Dispose of ScanPaymentBloc
    controller?.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    bool redirect = true;
   
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF5465FF),
          title: const Text(
            'Make Payment',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: BlocConsumer<ScanPaymentBloc, ScanPaymentState>(
           listenWhen: (context, state) {
            return true;
          },
            listener: (context, state) async {
          if (state is ScanPaymentFailure) {
            showErrorDialog(state.error);
          }

          if (state is MakeNavigateWithPayment) {
            if(redirect)
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MakePaymentPage(payment: state.payment)),
            );
              setState(() {  
              redirect = false;
            });
          }

          if (state is MakeNavigateWithoutPayment) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MakePaymentPage.empty()),
            );
          }
        }, builder: (context, state) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    // Your own button widget
                    Positioned(
                      bottom: 80.0,
                      left: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: _scanQRFromGallery,
                        child: const Text('Scan From Gallery'),
                      ),
                    ),
                    Positioned(
                      bottom: 20.0,
                      left: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          if(state is! MakeNavigateWithoutPayment){
                             BlocProvider.of<ScanPaymentBloc>(context)
                              .add(MakePaymentPressed());
                          }
                         
                        },
                        child: const Text('Enter Payment Id'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }

  void _onQRViewCreated(QRViewController controller) {
     
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if(waiting){
        return;
      }
      if (scanData.code == null) {
        Navigator.pop(context);
        return;
      }
      setState(() {
        waiting = true;
      });
      BlocProvider.of<ScanPaymentBloc>(context)
          .add(ScanQRCode(scanData.code ?? ""));        
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        waiting = false;
      });
    });
  }

  void showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Set rounded corners for the body
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          title: Container(
            color: Colors.blue, // Set blue background color for the title
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Error',
              style: TextStyle(
                color: Colors.white, // Set white text color
              ),
            ),
          ),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); //close the dialog
                Navigator.pop(context); // close the page
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _scanQRFromGallery() async {
    try {
      var image = await ImagePicker().getImage(source: ImageSource.gallery);
      if (image == null) return;

      File file = File(image.path);
      final rest = await FlutterQrReader.imgScan(file);

      BlocProvider.of<ScanPaymentBloc>(context).add(ScanQRCode(rest ?? ""));
      
    } catch (e) {
      print('Error scanning QR code from gallery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to scan QR code from gallery: $e'),
        ),
      );
    }
  }
}


//yisheng - merge welcome and login
//stephen - view transaction details
//mingxuan - add info in home and service charge
//fei - align the design