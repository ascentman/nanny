import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny/screens/screens.dart';

import 'menu_button.dart';

class NannyDrawer extends StatelessWidget {
  const NannyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/nanny.png',
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'UA kids: няня',
                textAlign: TextAlign.center,
                style: GoogleFonts.literata(
                    textStyle: const TextStyle(
                  fontSize: 28,
                  color: Colors.indigo,
                )),
              ),
              const SizedBox(
                height: 30,
              ),
              MenuButton(
                title: 'Про сервіс',
                onTap: () {
                  Navigator.pushReplacementNamed(context, StartScreen.id);
                },
              ),
              MenuButton(
                title: 'Про нас',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AboutUsScreen.id);
                },
              ),
              MenuButton(
                title: 'Зв\'язатися з нами',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ContactUsScreen.id);
                },
              ),
              const Spacer(),
              Text(
                'Версія програми: 1.0.1',
                textAlign: TextAlign.center,
                style: GoogleFonts.literata(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
