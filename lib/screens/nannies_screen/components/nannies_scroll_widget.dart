import 'package:flutter/material.dart';
import 'package:nanny/screens/nannies_screen/components/sliver_persistent_header.dart';
import 'package:nanny/screens/screens.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../filter_screen.dart';
import 'nannies_list.dart';

class NanniesScrollWidget extends StatelessWidget {
  const NanniesScrollWidget({
    Key? key,
    required ScrollController scrollController,
    required this.viewModel,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final INanniesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, _) {
        return <Widget>[
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Вибір дати:'),
                              TextButton.icon(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime(2050),
                                  ).then((v) => viewModel.selectPickerDate(v));
                                },
                                icon: const Icon(Icons.calendar_today_rounded),
                                label: Text(viewModel.selectedDateString),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            width: 1,
                            color: Colors.grey,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Вибір часу:'),
                              TextButton.icon(
                                onPressed: () {
                                  showTimeRangePicker(
                                    interval: const Duration(minutes: 30),
                                    context: context,
                                    toText: 'До',
                                    fromText: 'Від',
                                    start: viewModel.selectedStartHour,
                                    end: viewModel.selectedEndHour,
                                    onStartChange: (v) =>
                                        viewModel.selectStartHour(v),
                                    onEndChange: (v) =>
                                        viewModel.selectEndHour(v),
                                  );
                                },
                                icon: const Icon(Icons.timer_rounded),
                                label: Text(viewModel.timeRangeString),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${viewModel.getNanniesCount()} у м.Тальне'),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, FilterScreen.id);
                        },
                        icon: const Icon(Icons.filter_list_sharp),
                        label: const Text('Сортування'),
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
    );
  }
}
