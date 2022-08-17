import 'package:flutter/material.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatelessWidget {
  static String id = 'city';
  const CityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<INanniesViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вибір міста'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Виберіть ваше місто:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            RadioListTile<int>(
              title: const Text('Тальне'),
              value: 1,
              groupValue: viewModel.selectedCityOption,
              onChanged: (v) => _chooseCityOption(context, v ?? 1),
            ),
            RadioListTile<int>(
              title: const Text('Львів'),
              value: 2,
              groupValue: viewModel.selectedCityOption,
              onChanged: (v) => _chooseCityOption(context, v ?? 2),
            ),
          ],
        ),
      ),
    );
  }

  void _chooseCityOption(BuildContext context, int cityOption) {
    context.read<INanniesViewModel>().setCity(cityOption, () {
      Navigator.pop(context);
    });
  }
}
