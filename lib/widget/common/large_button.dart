import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeButton extends StatelessWidget {
  const LargeButton(
      {super.key, this.buttonText, this.onTap, this.color, this.textColor});
  final String? buttonText;
  final Widget? onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => onTap!),
        );
      },
      child:
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: textColor!,
            width: 1,
          ),
        ),
        child: Text(
          buttonText!,
          style: GoogleFonts.dmSans(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
