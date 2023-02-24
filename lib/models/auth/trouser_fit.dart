import 'package:equatable/equatable.dart';

import 'package:chicpic/services/exceptions.dart';

import 'package:chicpic/statics/assets_helper.dart';

enum TrouserFitType {
  skinny('Skinny', 'Skinny', AssetsHelper.trouserFitSkinny),
  slim('Slim', 'Slim', AssetsHelper.trouserFitSlim),
  normal('Normal', 'Normal', AssetsHelper.trouserFitNormal),
  loose('Loose', 'Loose', AssetsHelper.trouserFitLoose),
  tapered('Tapered', 'Tapered', AssetsHelper.trouserFitTapered);

  final String abbreviation;
  final String humanReadable;
  final String image;

  const TrouserFitType(this.abbreviation, this.humanReadable, this.image);
}

class TrouserFit extends Equatable {
  late final TrouserFitType _fitType;

  TrouserFitType get fitType => _fitType;

  TrouserFit({required String fitTypeAbbr}) {
    if (fitTypeAbbr == TrouserFitType.skinny.abbreviation) {
      _fitType = TrouserFitType.skinny;
    } else if (fitTypeAbbr == TrouserFitType.slim.abbreviation) {
      _fitType = TrouserFitType.slim;
    } else if (fitTypeAbbr == TrouserFitType.normal.abbreviation) {
      _fitType = TrouserFitType.normal;
    } else if (fitTypeAbbr == TrouserFitType.loose.abbreviation) {
      _fitType = TrouserFitType.loose;
    } else if (fitTypeAbbr == TrouserFitType.tapered.abbreviation) {
      _fitType = TrouserFitType.tapered;
    } else {
      throw SimpleException('Wrong shirt fit');
    }
  }

  factory TrouserFit.fromMap(Map<String, dynamic> map) =>
      TrouserFit(fitTypeAbbr: map['fitType']);

  @override
  List<Object?> get props => [fitType];
}
