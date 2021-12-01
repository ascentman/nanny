import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IEmailService {
  Future<http.Response> sendEmail({
    required String message,
    required String nannyEmail,
  });
}

class EmailService implements IEmailService {
  @override
  Future<http.Response> sendEmail({
    required String message,
    required String nannyEmail,
  }) async {
    const serviceId = 'service_cq922l9';
    const templateId = 'template_lqfcojq';
    const userId = 'user_1abjeBWyqk3gPrXkORiyu';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    return http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'origin': 'http://localhost',
      },
      body: json.encode(
        {
          'user_id': userId,
          'service_id': serviceId,
          'template_id': templateId,
          'template_params': {
            'message': message,
            'nanny_email': nannyEmail,
          },
        },
      ),
    );
  }
}
