import 'package:cloud_firestore/cloud_firestore.dart';

class Nanny {
  final String name;
  final String email;
  final String about;
  final String? photoUrl;
  final String town;
  final String workingHours;
  final DateTime startWorkingDate;
  final int payment;
  final num rating;
  final String detailsAbout;
  final List<AdditionalInfoRow> additionalInfo;
  final List<String> certificates;
  final List<Review> reviews;
  final num reviewsCount;
  final List<String> workingDaysEng;
  String? referenceId;

  Nanny({
    required this.name,
    required this.email,
    required this.about,
    this.photoUrl,
    required this.town,
    required this.workingHours,
    required this.startWorkingDate,
    required this.payment,
    required this.rating,
    required this.detailsAbout,
    required this.additionalInfo,
    required this.certificates,
    required this.reviews,
    required this.reviewsCount,
    required this.workingDaysEng,
    this.referenceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'about': about,
      'photoUrl': photoUrl,
      'town': town,
      'workingHours': workingHours,
      'startWorkingDate': startWorkingDate,
      'payment': payment,
      'rating': rating,
      'detailsAbout': detailsAbout,
      'additionalInfo': additionalInfo,
      'certificates': certificates,
      'referenceId': referenceId,
      'reviewsCount': reviewsCount,
      'workingDaysEng': workingDaysEng,
    };
  }

  factory Nanny.fromMap(Map<String, dynamic> map) {
    return Nanny(
      name: map['name'] as String,
      email: map['email'] as String,
      about: map['about'] as String,
      photoUrl: map['photoUrl'] as String,
      town: map['town'] as String,
      workingHours: map['workingHours'] as String,
      startWorkingDate: (map['startWorkingDate'] as Timestamp).toDate(),
      payment: map['payment'] as int,
      rating: map['rating'] as num,
      detailsAbout: map['detailsAbout'] as String,
      additionalInfo: (map['additionalInfo'] as List)
          .map((info) => AdditionalInfoRow.fromMap(info))
          .toList(),
      certificates:
          (map['certificates'] as List).map((url) => url as String).toList(),
      reviews: (map['reviews'] as List).map((e) => Review.fromMap(e)).toList(),
      reviewsCount: map['reviewsCount'] as num,
      workingDaysEng:
          (map['workingDaysEng'] as List).map((day) => day as String).toList(),
    );
  }

  factory Nanny.fromSnapshot(DocumentSnapshot snapshot) {
    Nanny newNanny = Nanny.fromMap(snapshot.data() as Map<String, dynamic>);
    newNanny.referenceId = snapshot.reference.id;
    return newNanny;
  }
}

class AdditionalInfoRow {
  final num icon;
  final String text;

  const AdditionalInfoRow({
    required this.icon,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'text': text,
    };
  }

  factory AdditionalInfoRow.fromMap(Map<String, dynamic> map) {
    return AdditionalInfoRow(
      icon: map['icon'] as num,
      text: map['text'] as String,
    );
  }
}

class Review {
  final String name;
  final num rating;
  final DateTime date;
  final String text;

  const Review({
    required this.name,
    required this.rating,
    required this.date,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rating': rating,
      'date': date,
      'text': text,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      name: map['name'] as String,
      rating: map['rating'] as num,
      date: (map['date'] as Timestamp).toDate(),
      text: map['text'] as String,
    );
  }
}
