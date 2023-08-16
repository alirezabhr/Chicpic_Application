import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:chicpic/services/exceptions.dart';

import 'package:chicpic/models/auth/gender_choices.dart';
import 'package:chicpic/models/auth/shirt_fit.dart';
import 'package:chicpic/models/auth/trouser_fit.dart';

class UserAdditional extends Equatable {
  final int user;
  final GenderChoices genderInterested;
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
    GenderChoices genderInterested;
    if (map['genderInterested'] ==
        GenderChoices.women.abbreviation) {
      genderInterested = GenderChoices.women;
    } else if (map['genderInterested'] ==
        GenderChoices.men.abbreviation) {
      genderInterested = GenderChoices.men;
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
