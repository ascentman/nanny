import 'package:http/http.dart' as http;
import 'package:nanny/service/email_service.dart';

abstract class INannyRepo {
  Future<int> sendEmail({
    required String nannyEmail,
    required String nannyName,
    required String city,
    required String date,
    required String time,
    required String name,
    required String phone,
  });
}

class NannyRepo implements INannyRepo {
  final IEmailService _emailService;

  NannyRepo({required IEmailService emailService})
      : _emailService = emailService;

  @override
  Future<int> sendEmail({
    required String nannyEmail,
    required String nannyName,
    required String city,
    required String date,
    required String time,
    required String name,
    required String phone,
  }) async {
    http.Response response = await _emailService.sendEmail(
      message:
          'Замовлення у м.$city для $nannyName на: $date, $time.\nВід: $name, $phone',
      nannyEmail: nannyEmail,
    );
    return response.statusCode;
  }
}
