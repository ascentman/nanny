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
}

class NannyDrawer extends StatelessWidget {
  const NannyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/nanny.png',
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'UA kids: няня',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: GestureDetector(
                  child: Container(
                    color: Colors.pink,
                    child: const Center(
                      child: Text(
                        'Про сервіс',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    height: 50,
                  ),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: GestureDetector(
                  child: Container(
                    color: Colors.pink,
                    child: const Center(
                      child: Text(
                        'Про нас',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    height: 50,
                  ),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: GestureDetector(
                  child: Container(
                    color: Colors.pink,
                    child: const Center(
                      child: Text(
                        'Зв\'язатися з нами',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    height: 50,
                  ),
                  onTap: () {},
                ),
              ),
              const Spacer(),
              const Text(
                'Версія програми: 1.0.0',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
