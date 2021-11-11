import 'package:flutter/material.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/repository/nannies_repo.dart';
import 'package:nanny/screens/filter_screen.dart';
import 'package:nanny/screens/nanny_screen.dart';
import 'package:nanny/service/locator_service.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:provider/provider.dart';
import 'package:time_range_picker/time_range_picker.dart';

class NanniesScreen extends StatefulWidget {
  static String id = 'nannies';

  const NanniesScreen({Key? key}) : super(key: key);

  @override
  State<NanniesScreen> createState() => _NanniesScreenState();
}

class _NanniesScreenState extends State<NanniesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<INanniesViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пошук няні'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, _) {
                  return <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text('Вибір дати:'),
                                        TextButton.icon(
                                          onPressed: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2021),
                                              lastDate: DateTime(2050),
                                            );
                                          },
                                          icon: const Icon(
                                              Icons.calendar_today_rounded),
                                          label: const Text('11 Листопада'),
                                        ),
                                      ],
                                    ),
                                    const VerticalDivider(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text('Вибір часу:'),
                                        TextButton.icon(
                                          onPressed: () {
                                            showTimeRangePicker(
                                              interval:
                                                  const Duration(minutes: 30),
                                              context: context,
                                            );
                                          },
                                          icon: const Icon(Icons.timer_rounded),
                                          label: const Text('13:00 - 17:00'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }, childCount: 1),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: SliverPersistentHeaderWidget(
                        widget: Container(
                          height: 40,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Доступно ${viewModel.nannies.length} няні у м.Тальне'),
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, FilterScreen.id);
                                  },
                                  icon: const Icon(Icons.filter_list_sharp),
                                  label: const Text('Фільтр'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: viewModel.nannies.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : NanniesList(nannies: viewModel.nannies),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.addNanny(
            Nanny(
              name: 'Юля',
              about:
                  'директор Центру розвитку, педагог, вчитель англійської мови',
              photoUrl: '',
              town: 'Тальне',
              workingDays: 'Понеділок - Пятниця',
              workingHours: '13:00 - 18:00',
              startWorkingDate: DateTime.now(),
              payment: 150,
              rating: 5.0,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NanniesList extends StatelessWidget {
  final INanniesRepo _repo = sl.get();
  final List<Nanny> nannies;

  NanniesList({
    Key? key,
    required this.nannies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: nannies.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, NannyScreen.id);
          },
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.asset(
                      'assets/images/profile.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                nannies[i].name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const Text(
                                '⭐️⭐️⭐️⭐️⭐️',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              '${nannies[i].payment} грн/год',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.green),
                            ),
                          ),
                          Text(
                            nannies[i].about,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
    );
  }
}

class SliverPersistentHeaderWidget extends SliverPersistentHeaderDelegate {
  final Widget widget;

  SliverPersistentHeaderWidget({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
