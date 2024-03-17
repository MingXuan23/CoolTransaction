import 'package:cool_transaction/pages/payment/make_payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cool_transaction/blocs/scan_payment/scan_payment_bloc.dart';
import 'package:cool_transaction/blocs/scan_payment/scan_payment_event.dart';
import 'package:cool_transaction/blocs/scan_payment/scan_payment_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPaymentPage extends StatefulWidget {
  @override
  _ScanPaymentPageState createState() => _ScanPaymentPageState();
}

class _ScanPaymentPageState extends State<ScanPaymentPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment'),
      ),
       body: BlocListener<ScanPaymentBloc, ScanPaymentState>(
        listener: (context, state) {
          if(state is ScanPaymentFailure){
             
                showErrorDialog(state.error);
          }

          if(state is MakeNavigateWithPayment){
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MakePaymentPage(payment :state.payment)),
              );
          }

          if(state is MakeNavigateWithoutPayment){
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MakePaymentPage.empty()),
              );
          }
        },
        child: BlocBuilder<ScanPaymentBloc, ScanPaymentState>(
          builder: (context, state) {
            
            return  Column(
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
                            bottom: 20.0,
                            left: 0,
                            right: 0,
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ScanPaymentBloc>(context).add(
                                    MakePaymentPressed()
                                  );
                              },
                              child: const Text('Enter Payment Id'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
          })
      )
    );
  }

  void _onQRViewCreated(QRViewController controller) {
   this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if(scanData.code == null)
      {
        Navigator.pop(context);
        return;
      }
        BlocProvider.of<ScanPaymentBloc>(context).add(
          ScanQRCode(scanData.code??"")
        );

    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void showErrorDialog(String error){
     showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Set rounded corners for the body
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
}
