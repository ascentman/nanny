import 'dart:ui';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:nanny/viewmodel/nanny_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NannyScreen extends StatefulWidget {
  static String id = 'nanny';

  const NannyScreen({Key? key}) : super(key: key);

  @override
  State<NannyScreen> createState() => _NannyScreenState();
}

class _NannyScreenState extends State<NannyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<INannyViewModel>().addListener(_alertListenerFunc);
  }

  @override
  Widget build(BuildContext context) {
    INannyViewModel viewModel = _setNannyViewModel(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детальна інформація'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.asset(
                      'assets/images/profile.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        viewModel.nanny.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RatingBar.builder(
                        initialRating: viewModel.nanny.rating.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 18,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (_) {},
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            Expanded(
              child: ContainedTabBarView(
                tabBarProperties: const TabBarProperties(
                    indicatorWeight: 4, labelColor: Colors.black),
                tabs: [
                  const Text('Інформація'),
                  const Text('Сертифікати'),
                  Text('Відгуки (${viewModel.nanny.reviews.length})'),
                ],
                views: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    child: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Про мене:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  viewModel.nanny.detailsAbout,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  color: Colors.grey.shade200,
                                  height: 10,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Графік роботи:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  viewModel.nanny.schedule,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  color: Colors.grey.shade200,
                                  height: 10,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Додатково:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    viewModel.nanny.additionalInfo.length,
                                itemBuilder: (context, i) => AdditionalInfoRow(
                                  icon: Icons.child_friendly_rounded,
                                  info: viewModel.nanny.additionalInfo[i].text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ImageSlideshow(
                      initialPage: 0,
                      indicatorColor: Colors.blue,
                      indicatorBackgroundColor: Colors.grey,
                      autoPlayInterval: 5000,
                      isLoop: true,
                      children: [
                        for (String url in viewModel.nanny.certificates)
                          Image.network(url),
                      ],
                    ),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: viewModel.nanny.reviews.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      viewModel.nanny.reviews[i].name,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      DateFormat.yMd('uk').format(
                                          viewModel.nanny.reviews[i].date),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                RatingBar.builder(
                                  initialRating: viewModel
                                      .nanny.reviews[i].rating
                                      .toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 14,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (_) {},
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                viewModel.nanny.reviews[i].text,
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, _) {
                      return const Divider(
                        height: 1,
                      );
                    },
                  ),
                ],
                onChange: (index) => print(index),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String _name = '';
          String _phone = '';
          Alert(
            context: context,
            title: "UA kids: няня",
            content: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Для завершення бронювання няні, введіть ваше ім\'я і мобільний номер. Ми до вас зателефонуємо ❤️',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'Ім\'я',
                  ),
                  onChanged: (v) => _name = v,
                ),
                TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Мобільний номер',
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => _phone = v,
                ),
              ],
            ),
            buttons: [
              DialogButton(
                onPressed: () {
                  viewModel.sendBookingRequest(
                    _name,
                    _phone,
                    () {
                      Navigator.pop(context);
                    },
                  );
                },
                child: const Text(
                  'Підтвердити',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show();
        },
        label: const Text('Вибрати'),
        icon: const Icon(Icons.check_outlined),
      ),
    );
  }

  void _alertListenerFunc() {
    if (context.read<INannyViewModel>().state == NannyState.success) {
      Alert(
        context: context,
        title: 'UA kids: няня',
        type: AlertType.success,
        desc: 'Бронювання успішно відправлено. Очікуйте дзвінка від нас ❤️',
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
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
            'Нам дуже прикро, але щось пішло не так. Звяжіться із службою підтримки: 0632052041',
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ).show();
    }
  }

  INannyViewModel _setNannyViewModel(BuildContext context) {
    final viewModel = context.watch<INannyViewModel>();
    final nannyId = ModalRoute.of(context)?.settings.arguments as String;
    final currentNanny = context.read<INanniesViewModel>().findById(nannyId);
    viewModel.setNanny(currentNanny);
    return viewModel;
  }
}

class AdditionalInfoRow extends StatelessWidget {
  final IconData icon;
  final String info;

  const AdditionalInfoRow({
    Key? key,
    required this.icon,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                info,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
