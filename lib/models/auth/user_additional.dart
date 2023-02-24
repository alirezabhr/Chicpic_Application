import 'package:equatable/equatable.dart';

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
  late final UserAdditionalInterestedGender _genderInterested;
  late final int _weight;
  late final int _height;
  late final DateTime _birthDate;
  late final int _bustSize;
  late final int _waistSize;
  late final int _hipSize;
  late final int _legLength;
  late final int _shoeSize;
  late final List<ShirtFit> _shirtFits;
  late final List<TrouserFit> _trouserFits;

  UserAdditional({
    required String genderInterested,
    required int weight,
    required int height,
    required DateTime birthDate,
    required int bustSize,
    required int waistSize,
    required int hipSize,
    required int legLength,
    required int shoeSize,
    List<ShirtFit>? shitFits,
    List<TrouserFit>? trouserFits,
  }) {
    _genderInterested =
        genderInterested == UserAdditionalInterestedGender.female.abbreviation
            ? UserAdditionalInterestedGender.female
            : UserAdditionalInterestedGender.male;

    _weight = weight;
    _height = height;
    _birthDate = birthDate;
    _bustSize = bustSize;
    _waistSize = waistSize;
    _hipSize = hipSize;
    _legLength = legLength;
    _shoeSize = shoeSize;
    _shirtFits = shitFits ?? [];
    _trouserFits = trouserFits ?? [];
  }

  factory UserAdditional.fromJson(Map<String, dynamic> map) => UserAdditional(
        genderInterested: map['genderInterested'],
        weight: map['weight'],
        height: map['height'],
        birthDate: map['birthDate'],
        bustSize: map['bustSize'],
        waistSize: map['waistSize'],
        hipSize: map['hipSize'],
        legLength: map['legLength'],
        shoeSize: map['shoeSize'],
        shitFits: map['shirtFits'],
        trouserFits: map['trouserFits'],
      );

  void addShirtFit(ShirtFit shirtFit) {
    _shirtFits.add(shirtFit);
  }

  void addTrouserFit(TrouserFit trouserFit) {
    _trouserFits.add(trouserFit);
  }

  @override
  List<Object?> get props => [
        genderInterested,
        weight,
        height,
        birthDate,
        bustSize,
        waistSize,
        hipSize,
        legLength,
        shoeSize,
        shirtFits,
        trouserFits,
      ];

  UserAdditionalInterestedGender get genderInterested => _genderInterested;

  int get weight => _weight;

  int get height => _height;

  DateTime get birthDate => _birthDate;

  int get bustSize => _bustSize;

  int get waistSize => _waistSize;

  int get hipSize => _hipSize;

  int get legLength => _legLength;

  int get shoeSize => _shoeSize;

  List<ShirtFit> get shirtFits => _shirtFits;

  List<TrouserFit> get trouserFits => _trouserFits;
}
