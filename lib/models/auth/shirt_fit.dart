import 'package:equatable/equatable.dart';

import 'package:chicpic/services/exceptions.dart';

import 'package:chicpic/statics/assets_helper.dart';

enum ShirtFitType {
  slim('Slim', 'Slim', AssetsHelper.shirtFitSlim),
  regular('Regular', 'Regular', AssetsHelper.shirtFitRegular);

  final String abbreviation;
  final String humanReadable;
  final String image;

  const ShirtFitType(this.abbreviation, this.humanReadable, this.image);
}

class ShirtFit extends Equatable {
  late final ShirtFitType _fitType;

  ShirtFitType get fitType => _fitType;

  ShirtFit({required String fitTypeAbbr}) {
    if (fitTypeAbbr == ShirtFitType.regular.abbreviation) {
      _fitType = ShirtFitType.regular;
    } else if (fitTypeAbbr == ShirtFitType.slim.abbreviation) {
      _fitType = ShirtFitType.slim;
    } else {
      throw SimpleException('Wrong shirt fit');
    }
  }

  factory ShirtFit.fromMap(Map<String, dynamic> map) =>
      ShirtFit(fitTypeAbbr: map['fitType']);

  Map<String, dynamic> toMap() => {'fitType': _fitType.abbreviation};

  @override
  List<Object?> get props => [fitType];
}
