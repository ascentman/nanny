import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:nanny/screens/nannies_screen/nannies_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/components.dart';

class StartScreen extends StatefulWidget {
  static String id = 'start';
  const StartScreen({Key? key}) : super(key: key);

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body: !kIsWeb
          ? Stack(
              children: [
                SplashView(
                  animationController: _animationController!,
                ),
                _HorizontalSlider(
                  onSwipeToLeft: _onBackClick,
                  onSwipeToRight: _onNextClick,
                  child: ComfortableView(
                    animationController: _animationController!,
                  ),
                ),
                _HorizontalSlider(
                  onSwipeToLeft: _onBackClick,
                  onSwipeToRight: _onNextClick,
                  child: OurPersonalView(
                    animationController: _animationController!,
                  ),
                ),
                _HorizontalSlider(
                  onSwipeToLeft: _onBackClick,
                  onSwipeToRight: _onNextClick,
                  child: CooperationVew(
                    animationController: _animationController!,
                  ),
                ),
                _HorizontalSlider(
                  onSwipeToLeft: _onBackClick,
                  onSwipeToRight: null,
                  child: WelcomeView(
                    animationController: _animationController!,
                  ),
                ),
                TopBackSkipView(
                  onBackClick: _onBackClick,
                  onSkipClick: _onSkipClick,
                  animationController: _animationController!,
                ),
                CenterNextButton(
                  animationController: _animationController!,
                  onNextClick: _onNextClick,
                ),
              ],
            )
          : const NanniesScreen(),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: const Duration(milliseconds: 200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _showNannies();
    }
  }

  void _showNannies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showNannies', true);
    Navigator.pushReplacementNamed(context, NanniesScreen.id);
  }
}

class _HorizontalSlider extends StatelessWidget {
  final Widget child;
  final VoidCallback onSwipeToLeft;
  final VoidCallback? onSwipeToRight;
  const _HorizontalSlider({
    Key? key,
    required this.onSwipeToLeft,
    required this.onSwipeToRight,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! > 0) {
          onSwipeToLeft();
        } else if (details.primaryVelocity! < 0) {
          onSwipeToRight?.call();
        }
      },
      child: child,
    );
  }
}
