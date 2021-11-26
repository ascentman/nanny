import 'package:http/http.dart' as http;
import 'package:nanny/service/email_service.dart';

abstract class INannyRepo {
  Future<int> sendEmail(String name, String phone);
}

class NannyRepo implements INannyRepo {
  final IEmailService _emailService;

  NannyRepo({required IEmailService emailService})
      : _emailService = emailService;

  @override
  Future<int> sendEmail(String name, String phone) async {
    http.Response response =
        await _emailService.sendEmail(message: '$name, $phone');
    return response.statusCode;
  }
}
