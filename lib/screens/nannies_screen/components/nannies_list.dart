import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nanny/models/nanny.dart';

import '../../nanny_screen/nanny_screen.dart';

class NanniesList extends StatelessWidget {
  final List<Nanny> nannies;

  const NanniesList({
    Key? key,
    required this.nannies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: nannies.length,
      itemBuilder: (context, i) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, NannyScreen.id,
              arguments: nannies[i].referenceId);
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
                  child: nannies[i].photoUrl == null ||
                          nannies[i].photoUrl!.isEmpty
                      ? Image.asset(
                          'assets/images/profile.png',
                          width: 80,
                          height: 80,
                        )
                      : CachedNetworkImage(
                          imageUrl: nannies[i].photoUrl!,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            nannies[i].name,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${nannies[i].payment} грн/год',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.green),
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: nannies[i].rating.toDouble(),
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
      ),
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
    );
  }
}
