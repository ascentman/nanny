import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CenterNextButton extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onNextClick;

  const CenterNextButton(
      {Key? key, required this.animationController, required this.onNextClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topMoveAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final searchNannyMoveAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: topMoveAnimation,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => AnimatedOpacity(
                opacity: animationController.value >= 0.2 &&
                        animationController.value <= 0.6
                    ? 1
                    : 0,
                duration: const Duration(milliseconds: 480),
                child: _pageView(),
              ),
            ),
          ),
          Center(
            child: SlideTransition(
              position: topMoveAnimation,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 56,
                    width: 56 + (200 * searchNannyMoveAnimation.value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          8 + 32 * (1 - searchNannyMoveAnimation.value)),
                      color: Colors.indigo,
                    ),
                    child: PageTransitionSwitcher(
                      duration: const Duration(milliseconds: 480),
                      reverse: searchNannyMoveAnimation.value < 0.7,
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return SharedAxisTransition(
                          fillColor: Colors.transparent,
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.vertical,
                          child: child,
                        );
                      },
                      child: searchNannyMoveAnimation.value > 0.7
                          ? InkWell(
                              onTap: onNextClick,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Знайти няню',
                                      style: GoogleFonts.literata(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_rounded,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: onNextClick,
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.arrow_forward_ios_rounded,
                                    color: Colors.white),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageView() {
    int selectedIndex = 0;

    if (animationController.value >= 0.7) {
      selectedIndex = 3;
    } else if (animationController.value >= 0.5) {
      selectedIndex = 2;
    } else if (animationController.value >= 0.3) {
      selectedIndex = 1;
    } else if (animationController.value >= 0.1) {
      selectedIndex = 0;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.all(4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 480),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: selectedIndex == i
                      ? Colors.indigo
                      : const Color(0xffE3E4E4),
                ),
                width: 10,
                height: 10,
              ),
            )
        ],
      ),
    );
  }
}
