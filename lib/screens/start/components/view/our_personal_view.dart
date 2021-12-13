import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OurPersonalView extends StatelessWidget {
  final AnimationController animationController;

  const OurPersonalView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _relaxFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _relaxSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _imageFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 5,
                child: SlideTransition(
                  position: _imageFirstHalfAnimation,
                  child: SlideTransition(
                    position: _imageSecondHalfAnimation,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: Image.asset(
                        'assets/images/nanny2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: SlideTransition(
                  position: _relaxFirstHalfAnimation,
                  child: SlideTransition(
                    position: _relaxSecondHalfAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AutoSizeText(
                        'Кваліфікований персонал',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.literata(
                          textStyle: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 36.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 16, top: 16),
                  child: AutoSizeText(
                    '🔹 Перед початком роботи кожна няня проходить навчання по догляду '
                    'за дітьми та надання першої медичної допомоги❤️.\n 🔹 Усі няні проходять медичні огляди, мають відповідні сертифікати.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.literata(
                      textStyle: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
