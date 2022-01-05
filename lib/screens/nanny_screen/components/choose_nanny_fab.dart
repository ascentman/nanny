import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny/screens/booking_confirm_screen.dart';
import 'package:nanny/viewmodel/nanny_view_model.dart';

class ChooseNannyButton extends StatelessWidget {
  const ChooseNannyButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final INannyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, BookingConfirmScreen.id);
        },
        label: Text(
          'Обрати няню',
          style: GoogleFonts.literata(textStyle: const TextStyle(fontSize: 15)),
        ),
        icon: const Icon(Icons.check_outlined),
      ),
    );
  }
}
