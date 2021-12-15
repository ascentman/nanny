import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanny/screens/nannies_screen/components/components.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:provider/provider.dart';

class NanniesScreen extends StatefulWidget {
  static String id = 'nannies';

  const NanniesScreen({Key? key}) : super(key: key);

  @override
  State<NanniesScreen> createState() => _NanniesScreenState();
}

class _NanniesScreenState extends State<NanniesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<INanniesViewModel>();
    return Scaffold(
      drawer: const NannyDrawer(),
      appBar: AppBar(
        title: const Text('Пошук няні'),
      ),
      body: Stack(
        children: [
          SafeArea(
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
