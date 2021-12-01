import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HintWidget extends StatelessWidget {
  final String title;
  final String description;
  const HintWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 40,
        ),
        Text(
          title,
          style: GoogleFonts.literata(
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            description,
            style: GoogleFonts.literata(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }
}
