import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialScreen extends StatelessWidget {
  static String id = 'tutorial';

  const TutorialScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Інструкція',
          style: GoogleFonts.literata(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Три прості кроки, як замовити няню:',
                    textStyle: const TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Agne',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    colors: [
                      const Color.fromARGB(255, 210, 170, 66),
                      Colors.indigo,
                    ],
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
            Image.asset(
              'assets/images/tutorial3.png',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Agne',
                  fontWeight: FontWeight.w500,
                  color: Colors.indigo,
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  pause: const Duration(seconds: 2),
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '1) Обрати потрібну дату і час',
                      speed: const Duration(milliseconds: 50),
                    ),
                    TypewriterAnimatedText(
                      '2) Обрати няню із доступних нянь в цей час',
                      speed: const Duration(milliseconds: 50),
                    ),
                    TypewriterAnimatedText(
                      '3) Перевірити деталі бронювання, вказати відповідні дані та очікувати дзвінка від нас ❤️',
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
