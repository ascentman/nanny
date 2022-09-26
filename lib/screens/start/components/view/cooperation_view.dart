import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CooperationVew extends StatelessWidget {
  final AnimationController animationController;

  const CooperationVew({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final moodFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.4,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final moodSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final imageFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final imageSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    return SlideTransition(
      position: firstHalfAnimation,
      child: SlideTransition(
        position: secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60, top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: AutoSizeText(
                    'Індивідуальний підхід',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.literata(
                      textStyle: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: SlideTransition(
                  position: moodFirstHalfAnimation,
                  child: SlideTransition(
                    position: moodSecondHalfAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 0),
                      child: AutoSizeText(
                        '🔹 Замовити няню можна погодинно (мін.3 год), на день, тиждень або місяць.\n'
                        '🔹 Перебування з дитиною може відбуватися вдома або в '
                        'центрі розвитку для дітей "UA kids у м.Тальне"❤️.',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.literata(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: SlideTransition(
                  position: imageFirstHalfAnimation,
                  child: SlideTransition(
                    position: imageSecondHalfAnimation,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: Image.asset(
                        'assets/images/nanny1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const Flexible(
                child: SizedBox(
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
