import 'package:auto_size_text/auto_size_text.dart';
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
          padding: const EdgeInsets.only(bottom: 30, top: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: SlideTransition(
                  position: _relaxAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AutoSizeText(
                      '?? ??????????\'?? ???? ??????????',
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
              ),
              Flexible(
                flex: 5,
                child: SlideTransition(
                  position: _textAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 16, bottom: 16),
                    child: AutoSizeText(
                      '???? ?? ?????? ?????????????????? ????????????, ????????????, ???????????? ?????? ???????????????????????? ?????????????????????? ?????????? ??????????, ?? ?????????? ???????? ?? ?????? ?????????????????\n'
                      '???? ????, UA kids: ????????, ?? ??????????\'?? ???????????????????????? ?????? ????????????.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.literata(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: SlideTransition(
                  position: _imageAnimation,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width),
                    child: Image.asset(
                      'assets/images/couple.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
