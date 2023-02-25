import 'package:equatable/equatable.dart';

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
  final int bustSize;
  final int waistSize;
  final int hipSize;
  final int legLength;
  final double shoeSize;
  final List<ShirtFit> shirtFits;
  final List<TrouserFit> trouserFits;

  const UserAdditional({
    required this.user,
    required this.genderInterested,
    required this.weight,
    required this.height,
    required this.birthDate,
    required this.bustSize,
    required this.waistSize,
    required this.hipSize,
    required this.legLength,
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
      birthDate: map['birthDate'],
      bustSize: map['bustSize'],
      waistSize: map['waistSize'],
      hipSize: map['hipSize'],
      legLength: map['legLength'],
      shoeSize: map['shoeSize'],
      shirtFits: map['shirtFits'],
      trouserFits: map['trouserFits'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'genderInterested': genderInterested.abbreviation,
      'weight': weight,
      'height': height,
      'birthDate': birthDate,
      'bustSize': bustSize,
      'waistSize': waistSize,
      'hipSize': hipSize,
      'legLength': legLength,
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
        bustSize,
        waistSize,
        hipSize,
        legLength,
        shoeSize,
        shirtFits,
        trouserFits,
      ];
}
