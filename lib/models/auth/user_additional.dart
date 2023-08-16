import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:chicpic/services/exceptions.dart';

import 'package:chicpic/models/auth/shirt_fit.dart';
import 'package:chicpic/models/auth/trouser_fit.dart';

enum UserAdditionalInterestedGender {
  male('M', "Men's Wear"),
  female('F', "Women's Wear");

  final String abbreviation;
  final String humanReadable;

  const UserAdditionalInterestedGender(this.abbreviation, this.humanReadable);
}

class UserAdditional extends Equatable {
  final int user;
  final UserAdditionalInterestedGender genderInterested;
  final int weight;
  final int height;
  final DateTime birthDate;
  final int shoulderSize;
  final int? chestSize;
  final int? bustSize;
  final int waistSize;
  final int hipsSize;
  final int inseam;
  final double shoeSize;
  final List<ShirtFit> shirtFits;
  final List<TrouserFit> trouserFits;

  const UserAdditional({
    required this.user,
    required this.genderInterested,
    required this.weight,
    required this.height,
    required this.birthDate,
    required this.shoulderSize,
    this.chestSize,
    this.bustSize,
    required this.waistSize,
    required this.hipsSize,
    required this.inseam,
    required this.shoeSize,
    required this.shirtFits,
    required this.trouserFits,
  });

  factory UserAdditional.fromJson(Map<String, dynamic> map) {
    UserAdditionalInterestedGender genderInterested;
    if (map['genderInterested'] ==
        UserAdditionalInterestedGender.female.abbreviation) {
      genderInterested = UserAdditionalInterestedGender.female;
    } else if (map['genderInterested'] ==
        UserAdditionalInterestedGender.male.abbreviation) {
      genderInterested = UserAdditionalInterestedGender.male;
    } else {
      throw SimpleException('Wrong gender interested value.');
    }

    return UserAdditional(
      user: map['user'],
      genderInterested: genderInterested,
      weight: map['weight'],
      height: map['height'],
      birthDate: DateTime.parse(map['birthDate']),
      shoulderSize: map['shoulderSize'],
      chestSize: map['chestSize'],
      bustSize: map['bustSize'],
      waistSize: map['waistSize'],
      hipsSize: map['hipsSize'],
      inseam: map['inseam'],
      shoeSize: map['shoeSize'],
      shirtFits:
          map['shirtFits'].map<ShirtFit>((e) => ShirtFit.fromMap(e)).toList(),
      trouserFits: map['trouserFits']
          .map<TrouserFit>((e) => TrouserFit.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'genderInterested': genderInterested.abbreviation,
      'weight': weight,
      'height': height,
      'birthDate': DateFormat('yyyy-MM-dd').format(birthDate),
      'shoulderSize': shoulderSize,
      'chestSize': chestSize,
      'bustSize': bustSize,
      'waistSize': waistSize,
      'hipsSize': hipsSize,
      'inseam': inseam,
      'shoeSize': shoeSize,
      'shirtFits': shirtFits.map((e) => e.toMap()).toList(),
      'trouserFits': trouserFits.map((e) => e.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        user,
        genderInterested,
        weight,
        height,
        birthDate,
        shoulderSize,
        chestSize,
        bustSize,
        waistSize,
        hipsSize,
        inseam,
        shoeSize,
        shirtFits,
        trouserFits,
      ];
}
