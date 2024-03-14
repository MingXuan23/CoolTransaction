import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //color: Colors.black.withOpacity(0.5), // Adjust the overlay color and opacity as needed
        child: CircularProgressIndicator(), // Circular progress indicator
      ),
    );
  }
}