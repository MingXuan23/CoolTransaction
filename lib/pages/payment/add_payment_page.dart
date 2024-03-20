import 'dart:io';
import 'dart:ui';


import 'package:cool_transaction/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cool_transaction/blocs/payment/payment_bloc.dart';
import 'package:cool_transaction/blocs/payment/payment_event.dart';
import 'package:cool_transaction/blocs/payment/payment_state.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:qr_flutter/qr_flutter.dart';
 final GlobalKey _qrkey = GlobalKey();
class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({Key? key}) : super(key: key);

  @override
  State<AddPaymentPage> createState() => AddPaymentState();
}

class AddPaymentState extends State<AddPaymentPage> {
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _coolingPeriodController = TextEditingController();
  bool _isCreateButtonEnabled = false;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  Payment ?payment;


  @override
  void initState(){
    super.initState();
     BlocProvider.of<PaymentBloc>(context).add(
      FetchReceiverEvent(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5465FF),
        title: const Text(
          'Add Payment',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentCreatedState) {
            // Update the UI with the created payment details
            setState(() {
              payment = state.payment;
            });
          }
          if(state is PaymentFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
          }
          if(state is FormattedAmount){
            _amountController.text = state.formattedAmount;
          }

          if(state is FormattedCoolingPeriod){
            _coolingPeriodController.text = state.days;
            if(state.message != ""){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          }

          if(state is FetchReceiverState){
            _receiverNameController.text = state.receiverNmae;

          }
        },
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _receiverNameController,
                    decoration: const InputDecoration(labelText: 'Receiver Name',labelStyle: TextStyle(color: Colors.black),),
                    style: const TextStyle(color: Colors.black),
                    enabled: false,
                  ),
                 TextFormField(
                   controller: _amountController,
                    keyboardType: TextInputType.number,
                    onChanged: (amount) {
                      BlocProvider.of<PaymentBloc>(context).add(
                        AmountChangedEvent(amount),
                      );

                      if(state is FormattedAmount){
                        _amountController.text = state.formattedAmount;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Amount (RM)',
                      suffixIcon: state is FormattedAmount && _amountController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _amountController.clear();
                                 setState(() {});
                              },
                            )
                          : null,
                    ),
                    enabled: state is! PaymentCreatedState,
                    //initialValue: '0.00',
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    onChanged: (value) {
                      _updateCreateButtonState();
                    } ,
                    enabled: state is! PaymentCreatedState,
                  ),
                  TextFormField(
                    controller: _coolingPeriodController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Cooling Period (Days)'),
                    onChanged: (day){
                      BlocProvider.of<PaymentBloc>(context).add(
                        CoolingPeriodChangedEvent(day),
                      );

                      if(state is FormattedCoolingPeriod){
                        _coolingPeriodController.text = state.days;
                      }

                      _updateCreateButtonState();
                    },
                    enabled: state is! PaymentCreatedState,
                     ),
                  SizedBox(height: 10,),
                 
                  Row(
                    children: [
                      const Text('Expired Date: '),
                      SizedBox(width: 10),
                     ElevatedButton(
                        onPressed: state is PaymentCreatedState ? null : () => _selectDate(context),
                        child: Text('${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
                      ),

                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:_isCreateButtonEnabled && state is! PaymentCreatedState? () {
                      // Dispatch event to create payment
                      BlocProvider.of<PaymentBloc>(context).add(
                        CreatePaymentEvent(
                          receiverName: _receiverNameController.text,
                          amount: _amountController.text,
                          description: _descriptionController.text,
                          coolingPeriod: _coolingPeriodController.text,
                          date: _selectedDate,
                        ),
                      );
                    }:null,
                    child: const Text('Create'),
                  ),
                 if (payment != null) ...[
                    SizedBox(
                      //height: 200, // Set a specific height for the container
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            width: double.infinity,
                            //height: 150,
                            color: Color(0xffBFD7FF),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(fontSize: 18, color: Colors.black), // Default text style
                                    children: [
                                      TextSpan(
                                        text: 'Payment ID: ',
                                      ),
                                      TextSpan(
                                        text: payment!.paymentId,
                                        style: TextStyle(fontWeight: FontWeight.bold), // Make the payment ID bold
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                  Center(
                                child: RepaintBoundary(
                                  key: _qrkey,
                                  child: QrImageView(
                                    data: payment!.url,
                                    version: QrVersions.auto,
                                    size: 250.0,
                                    gapless: true,
                                    errorStateBuilder: (ctx, err) {
                                      return const Center(
                                        child: Text(
                                          'Something went wrong!!!',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                  ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _copyPaymentId(context),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF5465FF)), // Change button color
                                      ),
                                      child: Text(
                                        'Copy',
                                        style: TextStyle(color: Colors.white), // Change text color
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed:_captureAndSavePng,
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF5465FF)), // Change button color
                                      ),
                                      child: Text(
                                        'Download QR',
                                        style: TextStyle(color: Colors.white), // Change text color
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // QR Code Widget can be added here
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _updateCreateButtonState() async {
      await Future.delayed(const Duration(milliseconds: 500));
      final description = _descriptionController.text;
      final coolingPeriod = _coolingPeriodController.text;
      setState(() {
        _isCreateButtonEnabled = description.isNotEmpty && coolingPeriod.isNotEmpty;
      });
    }

 void _selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: _selectedDate,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 7)),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(
            primary: const Color(0xFF5465FF), // Set background color
          ),
        ),
        child: child!,
      );
    },
  );
  if (pickedDate != null && pickedDate != _selectedDate) {
    setState(() {
      _selectedDate = pickedDate;
    });
  }
}


  void _copyPaymentId(BuildContext context) {
    Clipboard.setData(ClipboardData(text: payment?.paymentId ?? ''));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Payment ID copied to clipboard'),
    ));
  }



Future<void> _captureAndSavePng() async {
  try {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      // The user denied storage permission
      return;
    }

    // Get the directory for storing the image in the gallery
    final directory = await getExternalStorageDirectory();
    final galleryPath = directory!.path;

    // Prepare the image
    RenderRepaintBoundary boundary =
        _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 3.0);
    final whitePaint = Paint()..color = Colors.white;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
    canvas.drawRect(Rect.fromLTWH(0, 0, image.width.toDouble(),
        image.height.toDouble()), whitePaint);
    canvas.drawImage(image, Offset.zero, Paint());
    final picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Save the image to the gallery
    String fileName = 'qr_code.png';
    int i = 1;
    while (await File('$galleryPath/$fileName').exists()) {
      fileName = 'qr_code_$i.png';
      i++;
    }

    final file = await File('$galleryPath/$fileName').create();
    await file.writeAsBytes(pngBytes);
    final success = await GallerySaver.saveImage(file.path);

    // Show a snackbar to indicate success
    if (!mounted || success != true) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR code saved to gallery')));
  } catch (e) {
    // Show a snackbar to indicate failure
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong!!!')));
  }
}

// Future<void> _downloadQR(BuildContext context, String url) async {
//   try {
//     // Generate the QR code using QrPainter
//     final QrPainter painter = QrPainter(
//       data: url,
//       version: QrVersions.auto,
//       errorCorrectionLevel: QrErrorCorrectLevel.Q,
//     );

//     // Create an empty image with a desired size
//     final double imageSize = 200.0;
//     final ui.PictureRecorder recorder = ui.PictureRecorder();
//     final Canvas canvas = Canvas(recorder);
//     painter.paint(canvas, Size(imageSize, imageSize));

//     // Convert the picture to an image
//     final ui.Image image = await recorder.endRecording().toImage(
//       imageSize.toInt(),
//       imageSize.toInt(),
//     );
//     final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     if (byteData == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to generate QR code image'),
//         ),
//       );
//       return;
//     }

//     // Convert the byte data to Uint8List
//     final Uint8List qrImageData = byteData.buffer.asUint8List();

//     // Get the directory for storing the QR code image
//     final directory = await getTemporaryDirectory();
//     final imagePath = '${directory.path}/qr_code.png';

//     // Write the QR code image to a file
//     final File imageFile = File(imagePath);
//     await imageFile.writeAsBytes(qrImageData);

//     // Save the QR code image to the gallery
//     final success = await GallerySaver.saveImage(imagePath);

//     // Show success or error message
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: success==true ? Text('Image saved to Gallery') : Text('Error saving image'),
//       ),
//     );
//   } catch (e) {
//     // Handle error
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Failed to download QR code: $e'),
//       ),
//     );
//   }
// }



}
