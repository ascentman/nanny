import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CenterNextButton extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onNextClick;
  const CenterNextButton(
      {Key? key, required this.animationController, required this.onNextClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _topMoveAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _searchNannyMoveAnimation = Tween<double>(begin: 0, end: 1.0).animate(
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
      padding:
          EdgeInsets.only(bottom: 16 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: _topMoveAnimation,
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
              position: _topMoveAnimation,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) => Padding(
                  padding: EdgeInsets.only(
                      bottom: 38 - (38 * _searchNannyMoveAnimation.value)),
                  child: Container(
                    height: 56,
                    width: 56 + (200 * _searchNannyMoveAnimation.value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          8 + 32 * (1 - _searchNannyMoveAnimation.value)),
                      color: const Color(0xff132137),
                    ),
                    child: PageTransitionSwitcher(
                      duration: const Duration(milliseconds: 480),
                      reverse: _searchNannyMoveAnimation.value < 0.7,
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return SharedAxisTransition(
                          fillColor: Colors.transparent,
                          child: child,
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.vertical,
                        );
                      },
                      child: _searchNannyMoveAnimation.value > 0.7
                          ? InkWell(
                              onTap: onNextClick,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Знайти няню',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_rounded,
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
    int _selectedIndex = 0;

    if (animationController.value >= 0.7) {
      _selectedIndex = 3;
    } else if (animationController.value >= 0.5) {
      _selectedIndex = 2;
    } else if (animationController.value >= 0.3) {
      _selectedIndex = 1;
    } else if (animationController.value >= 0.1) {
      _selectedIndex = 0;
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
                duration: Duration(milliseconds: 480),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: _selectedIndex == i
                      ? const Color(0xff132137)
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
