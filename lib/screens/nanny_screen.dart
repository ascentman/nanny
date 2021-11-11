import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class NannyScreen extends StatelessWidget {
  static String id = 'nanny';

  const NannyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Юля'),
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
                    children: const [
                      Text('⭐⭐⭐⭐⭐️'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('42 відгуки'),
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
                tabs: const [
                  Text('Інформація'),
                  Text('Сертифікати'),
                  Text('Відгуки'),
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
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Привіт. Мене звати Юля. Я займаюся з дітьми. Привіт. Мене звати Юля. Я займаюся з дітьми.',
                                  style: TextStyle(fontSize: 14),
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
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Понеділок - Пятниця: 12:00 - 19:00\nСубота: 10:00 - 15:00',
                                  style: TextStyle(fontSize: 14),
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
                              const AdditionalInfoRow(
                                icon: Icons.child_friendly_rounded,
                                info: '2 роки досвіду роботи з дітьми',
                              ),
                              const AdditionalInfoRow(
                                icon: Icons.book_rounded,
                                info:
                                    'Володію англійською на рівні Pre-Intermediate',
                              ),
                              const AdditionalInfoRow(
                                icon: Icons.drive_eta_rounded,
                                info: 'Маю водійські права',
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 200,
                      child: ImageSlideshow(
                        initialPage: 0,
                        indicatorColor: Colors.blue,
                        indicatorBackgroundColor: Colors.grey,
                        onPageChanged: (value) {
                          debugPrint('Page changed: $value');
                        },
                        autoPlayInterval: 5000,
                        isLoop: true,
                        children: [
                          Image.asset(
                            'assets/images/start.png',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/start.png',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Альона',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '12/11/2021',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const Text('⭐️⭐️⭐️⭐️⭐️'),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Юля дуже старанна і уважна няня. В мене не було жодних проблем: одразу з дітьми знайшла спільну мову',
                                  style: TextStyle(
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
                  ),
                ],
                onChange: (index) => print(index),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Вибрати'),
        icon: const Icon(Icons.check_outlined),
      ),
    );
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
