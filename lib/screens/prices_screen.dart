import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny/service/remote_config_service.dart';

class PricesScreen extends StatelessWidget {
  final IRemoteConfigService remoteConfigService;
  static String id = 'prices';

  const PricesScreen({
    Key? key,
    required this.remoteConfigService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ціни',
          style: GoogleFonts.literata(),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                    '1) Одна година: ${remoteConfigService.hourPrice} грн.\n'
                    '2) Один день: ${remoteConfigService.dayPrice} грн.\n'
                    '3) Один тиждень: ${remoteConfigService.weekPrice} грн.\n'
                    '4) Один місяць: ${remoteConfigService.monthPrice} грн.\n',
                    style: GoogleFonts.literata(
                        textStyle: const TextStyle(fontSize: 18))),
                Text(
                  '*У ціну включено догляд за однією дитиною. За кожну наступну дитину здійснюється доплата +50%. Додаткові послуги занять з розвитку, музики узгоджуються індивідуально з нянею і оплачуються додатково. Мінімальне замовлення - 3 години. Дякуємо вам за довіру!❤️',
                  style: GoogleFonts.literata(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
