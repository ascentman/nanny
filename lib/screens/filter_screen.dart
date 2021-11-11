import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  static String id = 'filter';
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _filterOption = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фільтр'),
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
              title: const Text('за зростанням ціни'),
              value: 1,
              groupValue: _filterOption,
              onChanged: (value) {
                print(value);
              },
            ),
            RadioListTile<int>(
              title: const Text('за спаданням ціни'),
              value: 2,
              groupValue: _filterOption,
              onChanged: (value) {
                print(value);
              },
            ),
            RadioListTile<int>(
              title: const Text('по рейтингу'),
              value: 3,
              groupValue: _filterOption,
              onChanged: (value) {
                print(value);
              },
            ),
            RadioListTile<int>(
              title: const Text('по кількості відгуків'),
              value: 2,
              groupValue: _filterOption,
              onChanged: (value) {
                print(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
