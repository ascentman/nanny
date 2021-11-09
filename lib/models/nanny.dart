import 'package:cloud_firestore/cloud_firestore.dart';

class Nanny {
  final String name;
  final String about;
  // final String photoUrl;
  // final String town;
  // final String workingDays;
  // final String workingHours;
  // final String experience;
  // final String payment;
  // final String rating;
  String? referenceId;

  Nanny({
    required this.name,
    required this.about,
    // required this.photoUrl,
    // required this.town,
    // required this.workingDays,
    // required this.workingHours,
    // required this.experience,
    // required this.payment,
    // required this.rating,
    this.referenceId,
  });

  @override
  String toString() {
    return 'Nanny{' +
        ' name: $name,' +
        ' about: $about,' +
        // ' photoUrl: $photoUrl,' +
        // ' town: $town,' +
        // ' workingDays: $workingDays,' +
        // ' workingHours: $workingHours,' +
        // ' experience: $experience,' +
        // ' payment: $payment,' +
        // ' rating: $rating,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'about': about,
      // 'photoUrl': photoUrl,
      // 'town': town,
      // 'workingDays': workingDays,
      // 'workingHours': workingHours,
      // 'experience': experience,
      // 'payment': payment,
      // 'rating': rating,
    };
  }

  factory Nanny.fromMap(Map<String, dynamic> map) {
    return Nanny(
      name: map['name'] as String,
      about: map['about'] as String,
      // photoUrl: map['photoUrl'] as String,
      // town: map['town'] as String,
      // workingDays: map['workingDays'] as String,
      // workingHours: map['workingHours'] as String,
      // experience: map['experience'] as String,
      // payment: map['payment'] as String,
      // rating: map['rating'] as String,
    );
  }

  factory Nanny.fromSnapshot(DocumentSnapshot snapshot) {
    final newNanny = Nanny.fromMap(snapshot.data() as Map<String, dynamic>);
    newNanny.referenceId = snapshot.reference.id;
    return newNanny;
  }
}
