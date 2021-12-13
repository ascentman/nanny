import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final _interconnection =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _interconnection,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/start.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                'UA kids: няня',
                style: GoogleFonts.literata(
                  textStyle: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: AutoSizeText(
                '"Любов до дітей понад усе❤️"',
                textAlign: TextAlign.center,
                style: GoogleFonts.literata(
                  textStyle: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.indigo,
                  ),
                  child: Center(
                    child: Text(
                      'Почати',
                      style: GoogleFonts.literata(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
    );
  }
}
