import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny/screens/nannies_screen/components/components.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'constants.dart';

class NanniesScreen extends StatefulWidget {
  static String id = 'nannies';

  const NanniesScreen({Key? key}) : super(key: key);

  @override
  State<NanniesScreen> createState() => _NanniesScreenState();
}

class _NanniesScreenState extends State<NanniesScreen> {
  final ScrollController _scrollController = ScrollController();
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  @override
  void initState() {
    super.initState();
    showTutorialIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<INanniesViewModel>();
    return Scaffold(
      drawer: const NannyDrawer(),
      appBar: AppBar(
        title: const Text('Пошук няні'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NanniesScrollWidget(
                scrollController: _scrollController,
                viewModel: viewModel,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initTargets() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: 'Date',
        keyTarget: keyButton1,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const HintWidget(
                title: 'Крок 1',
                description: step1,
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Time',
        keyTarget: keyButton2,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const HintWidget(
                title: 'Крок 2',
                description: step2,
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Sort',
        keyTarget: keyButton3,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const HintWidget(
                title: 'Крок 3',
                description: step3,
              );
            },
          ),
        ],
      ),
    );
  }

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.indigo,
      textSkip: 'Пропустити',
      textStyleSkip: GoogleFonts.literata(
          textStyle: const TextStyle(fontSize: 14, color: Colors.white)),
      paddingFocus: 1,
      opacityShadow: 0.7,
      onFinish: _hideHints,
      onSkip: _hideHints,
    )..show();
  }

  void _hideHints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showHints', false);
  }

  Future<void> showTutorialIfNeeded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('showHints') ?? true) {
      Future.delayed(Duration.zero, showTutorial);
    }
  }
}
