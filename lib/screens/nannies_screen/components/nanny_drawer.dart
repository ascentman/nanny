import 'package:flutter/foundation.dart';
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
                height: 160,
              ),
              const SizedBox(
                height: 10,
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
              if (!kIsWeb)
                MenuButton(
                  title: 'Про сервіс',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, StartScreen.id);
                  },
                ),
              MenuButton(
                title: 'Інструкція',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, TutorialScreen.id);
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
                'Версія програми: 1.1.0',
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
