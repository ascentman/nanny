import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny/screens/nannies_screen/nannies_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  static String id = 'contact_us';
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Зв\'язатися з нами',
            style: GoogleFonts.literata(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Якщо у вас виникли будь-які запитання по роботі сервісу чи '
                    'ви хочете стати нянею або бажаєте, щоб ми '
                    'запустилися у вашому населеному пункті, напишіть нам на '
                    'пошту, в соцмережах або на мобільний номер і ми з радістю '
                    'поспілкуємося з вами ❤️.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.literata(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SendEmailForm(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Наші контакти:',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.literata(
                          textStyle: const TextStyle(fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _openLink('https://www.instagram.com/ua_kids_talne/');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              FontAwesomeIcons.instagram,
                              size: 28,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ua_kids_talne',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _openLink('https://www.facebook.com/uakidstalne');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              FontAwesomeIcons.facebook,
                              size: 28,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'uakidstalne',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _makePhoneCall();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              FontAwesomeIcons.mobileAlt,
                              size: 24,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '+380632052041',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '0632052041',
    );
    await launch(launchUri.toString());
  }

  Future<void> _openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }
}

class SendEmailForm extends StatefulWidget {
  const SendEmailForm({Key? key}) : super(key: key);

  @override
  State<SendEmailForm> createState() => _SendEmailFormState();
}

class _SendEmailFormState extends State<SendEmailForm> {
  final FocusNode _fnTopic = FocusNode();
  final FocusNode _fnInfo = FocusNode();
  final _topicController = TextEditingController();
  final _infoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _topicController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Тема',
            ),
            textInputAction: TextInputAction.next,
            focusNode: _fnTopic,
            onSubmitted: (_) {
              _fnTopic.unfocus();
              FocusScope.of(context).requestFocus(_fnInfo);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _infoController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Повідомлення',
            ),
            focusNode: _fnInfo,
            onSubmitted: (_) {
              _fnInfo.unfocus();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
            ),
            onPressed: () async {
              final Email email = Email(
                body: _infoController.text,
                subject: _topicController.text,
                recipients: ['ascentman91@gmail.com'],
                cc: [],
                bcc: [],
                attachmentPaths: [],
                isHTML: false,
              );
              try {
                await FlutterEmailSender.send(email);
              } catch (e) {
                debugPrint(e.toString());
              }
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(NanniesScreen.id, (route) => false);
            },
            child: const Text(
              'Відправити',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    _infoController.dispose();
    super.dispose();
  }
}
