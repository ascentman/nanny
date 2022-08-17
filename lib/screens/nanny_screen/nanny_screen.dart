import 'package:cached_network_image/cached_network_image.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:nanny/viewmodel/nanny_view_model.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class NannyScreen extends StatelessWidget {
  static String id = 'nanny';

  const NannyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    INannyViewModel viewModel = _setNannyViewModel(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Детальна інформація',
          style: GoogleFonts.literata(),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: viewModel.nanny.photoUrl == null ||
                          viewModel.nanny.photoUrl!.isEmpty
                      ? Image.asset(
                          'assets/images/profile.png',
                          width: 80,
                          height: 80,
                        )
                      : CachedNetworkImage(
                          imageUrl: viewModel.nanny.photoUrl!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      color: Colors.white,
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 40,
                            color: Colors.red,
                          ),
                          fadeOutDuration: const Duration(milliseconds: 100),
                          width: 80,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      viewModel.nanny.name,
                      style: GoogleFonts.literata(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: viewModel.nanny.rating.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 16,
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
                Text(
                  'Інформація',
                  style: GoogleFonts.literata(
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                ),
                Text(
                  'Відгуки (${viewModel.nanny.reviews.length})',
                  style: GoogleFonts.literata(
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Сертифікати (${viewModel.nanny.certificates.length})',
                  style: GoogleFonts.literata(
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              views: [
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Про мене:',
                              style: GoogleFonts.literata(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              viewModel.nanny.detailsAbout,
                              style: GoogleFonts.literata(
                                textStyle: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              color: Colors.grey.shade200,
                              height: 10,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Графік роботи:',
                              style: GoogleFonts.literata(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              viewModel.nanny.workingHours,
                              style: GoogleFonts.literata(
                                textStyle: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Container(
                              color: Colors.grey.shade200,
                              height: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
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
                                    style: GoogleFonts.literata(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    DateFormat.yMd('uk').format(
                                        viewModel.nanny.reviews[i].date),
                                    style: GoogleFonts.literata(
                                      textStyle: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: viewModel.nanny.reviews[i].rating
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
                              style: GoogleFonts.literata(
                                textStyle: const TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageSlideshow(
                    initialPage: 0,
                    indicatorColor: Colors.indigo,
                    indicatorBackgroundColor: Colors.white,
                    children: [
                      for (String url in viewModel.nanny.certificates)
                        CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          fadeOutDuration: const Duration(milliseconds: 100),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                    ],
                  ),
                ),
              ],
              onChange: (_) => () {},
            ),
          ),
        ],
      ),
      floatingActionButton: ChooseNannyButton(viewModel: viewModel),
    );
  }

  INannyViewModel _setNannyViewModel(BuildContext context) {
    final viewModel = context.watch<INannyViewModel>();
    final nannyId = ModalRoute.of(context)?.settings.arguments as String;
    final currentNanny = context.read<INanniesViewModel>().findById(nannyId);
    viewModel.setNanny(currentNanny);
    return viewModel;
  }
}
