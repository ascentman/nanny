import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nanny/models/nanny.dart';

import '../../nanny_screen.dart';

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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                nannies[i].name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              RatingBar.builder(
                                initialRating: nannies[i].rating.toDouble(),
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
      ),
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
    );
  }
}
