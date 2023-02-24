import 'package:chicpic/services/exceptions.dart';
import 'package:equatable/equatable.dart';

enum TrouserFitType {
  skinny('Skinny', 'Skinny'),
  slim('Slim', 'Slim'),
  normal('Normal', 'Normal'),
  loose('Loose', 'Loose'),
  tapered('Tapered', 'Tapered');

  final String abbreviation;
  final String humanReadable;

  const TrouserFitType(this.abbreviation, this.humanReadable);
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
