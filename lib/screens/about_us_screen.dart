import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  static String id = 'about_us';
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Про нас',
          style: GoogleFonts.literata(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Вітаємо вас!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.literata(
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(1, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/images/we.png',
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Ми, Володимир та Юлія, - молоде подружжя і засновники стартапу: "UA kids:няня". '
                  'Ідея створення програми з\'явилася у нас у 2020 році, '
                  'коли у м.Тальне Черкаської області ми відкрили Центр '
                  'розвитку для дітей "UA kids".\n\nДякуємо за довіру до нас, '
                  'а ми зі своєї сторони намагатимемося перевершити усі ваші '
                  'очікування щодо хорошого сервісу❤️.\n\nЗ повагою, Володимир та Юлія!',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.literata(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
