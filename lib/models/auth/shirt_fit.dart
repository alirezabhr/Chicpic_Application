import 'package:chicpic/services/exceptions.dart';
import 'package:equatable/equatable.dart';

enum ShirtFitType {
  slim('Slim', 'Slim'),
  regular('Regular', 'Regular');

  final String abbreviation;
  final String humanReadable;

  const ShirtFitType(this.abbreviation, this.humanReadable);
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

  @override
  List<Object?> get props => [fitType];
}
