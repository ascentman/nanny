import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComfortableView extends StatelessWidget {
  final AnimationController animationController;

  const ComfortableView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _textAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _imageAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _relaxAnimation =
        Tween<Offset>(begin: const Offset(0, -2), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 70, top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _relaxAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'З любов\'ю до дітей',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.literata(
                      textStyle: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _textAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 16, bottom: 16),
                  child: Text(
                    '🔹 У вас термінові справи, робота, бізнес або запланований романтичний вечір удвох, а дітей нема з ким залишити?\n'
                    '🔹 Ми, UA kids: няня, з любов\'ю потурбуємося про них❤️.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.literata(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _imageAnimation,
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: 250, maxHeight: 250),
                  child: Image.asset(
                    'assets/images/couple.jpg',
                    fit: BoxFit.cover,
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
