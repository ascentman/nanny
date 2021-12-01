import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny/viewmodel/nanny_view_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChooseNannyButton extends StatelessWidget {
  const ChooseNannyButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final INannyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: FloatingActionButton.extended(
        onPressed: () {
          String _name = '';
          String _phone = '';
          Alert(
            context: context,
            title: 'UA kids: няня',
            content: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Image.asset('assets/images/ticket.png'),
                    ),
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
                    'Для підтвердження бронювання вкажіть своє ім\'я і моб.номер. Ми до вас зателефонуємо ❤️.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.literata(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14),
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
                  onChanged: (v) => _name = v,
                ),
                TextField(
                  style: GoogleFonts.literata(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Мобільний номер',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  onChanged: (v) => _phone = v,
                ),
              ],
            ),
            buttons: [
              DialogButton(
                onPressed: () {
                  if (_name.isNotEmpty && _phone.isNotEmpty) {
                    viewModel.sendBookingRequest(
                      _name,
                      _phone,
                      () {
                        Navigator.pop(context);
                      },
                    );
                  }
                },
                child: const Text(
                  'Підтвердити',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show();
        },
        label: Text(
          'Вибрати',
          style: GoogleFonts.literata(textStyle: const TextStyle(fontSize: 15)),
        ),
        icon: const Icon(Icons.check_outlined),
      ),
    );
  }
}
