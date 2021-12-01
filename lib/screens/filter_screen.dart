import 'package:flutter/material.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  static String id = 'filter';
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<INanniesViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сортування'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Виберіть критерій сортування:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            RadioListTile<int>(
              title: const Text('по рейтингу'),
              value: 1,
              groupValue: viewModel.activeFilterOption,
              onChanged: (v) => _chooseFilterOption(context, v ?? 1),
            ),
            RadioListTile<int>(
              title: const Text('по кількості відгуків'),
              value: 2,
              groupValue: viewModel.activeFilterOption,
              onChanged: (v) => _chooseFilterOption(context, v ?? 2),
            ),
            RadioListTile<int>(
              title: const Text('за зростанням ціни'),
              value: 3,
              groupValue: viewModel.activeFilterOption,
              onChanged: (v) => _chooseFilterOption(context, v ?? 3),
            ),
            RadioListTile<int>(
              title: const Text('за спаданням ціни'),
              value: 4,
              groupValue: viewModel.activeFilterOption,
              onChanged: (v) => _chooseFilterOption(context, v ?? 4),
            ),
          ],
        ),
      ),
    );
  }

  void _chooseFilterOption(BuildContext context, int option) {
    context.read<INanniesViewModel>().setFilter(option, () {
      Navigator.pop(context);
    });
  }
}
