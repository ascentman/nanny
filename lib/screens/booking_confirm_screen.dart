import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny/screens/contact_us.dart';
import 'package:nanny/viewmodel/nanny_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookingConfirmScreen extends StatefulWidget {
  static String id = 'booking';

  const BookingConfirmScreen({Key? key}) : super(key: key);

  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  final TextEditingController _nameC = TextEditingController();
  final TextEditingController _phoneC = TextEditingController();

  @override
  void initState() {
    super.initState();
    // context.read<INannyViewModel>().addListener(_alertListenerFunc);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<INannyViewModel>();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _alertListener(() => viewModel.resetNannyState());
    });
    return WillPopScope(
      onWillPop: viewModel.isLoading ? () async => false : null,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ваше замовлення'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/images/ticket.png'),
                          Text(
                            '${viewModel.nanny.name}\n${viewModel.bookedDateTimeRange}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptMono(
                              textStyle: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Для підтвердження замовлення вкажіть своє ім\'я і мобільний телефон. Ми до вас зателефонуємо ❤️.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.literata(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ),
                      ),
                      TextField(
                        style: GoogleFonts.literata(),
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.account_circle),
                          labelText: 'Ім\'я',
                        ),
                        controller: _nameC,
                      ),
                      TextField(
                        style: GoogleFonts.literata(),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: 'Мобільний номер',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        controller: _phoneC,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_nameC.text.isNotEmpty &&
                              _phoneC.text.isNotEmpty) {
                            viewModel.sendBookingRequest(
                              _nameC.text,
                              _phoneC.text,
                              () {},
                            );
                          }
                        },
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.indigo,
                          ),
                          child: Center(
                            child: Text(
                              'Надіслати',
                              style: GoogleFonts.literata(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (viewModel.isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameC.dispose();
    _phoneC.dispose();
    super.dispose();
  }

  void _alertListener(VoidCallback onCloseAlert) {
    if (context.read<INannyViewModel>().state == NannyState.success) {
      Alert(
        context: context,
        title: 'UA kids: няня',
        type: AlertType.success,
        desc: 'Бронювання успішно відправлено. Очікуйте дзвінка від нас ❤️',
        buttons: [
          DialogButton(
            onPressed: () {
              onCloseAlert();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ).show();
    } else if (context.read<INannyViewModel>().state == NannyState.error) {
      Alert(
        context: context,
        title: 'UA kids: няня',
        type: AlertType.error,
        desc:
            'Нам дуже прикро, але щось пішло не так. Зв\'яжіться із службою підтримки.',
        buttons: [
          DialogButton(
            onPressed: () {
              onCloseAlert();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  ContactUsScreen.id, (route) => false);
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ).show();
    }
  }
}
