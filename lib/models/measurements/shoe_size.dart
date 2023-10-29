import 'package:chicpic/models/auth/gender_choices.dart';


enum ShoeSizeStandard {
  us('US / Canada', 'US'),
  eu('Euro', 'EU');

  final String name;
  final String abbreviation;

  const ShoeSizeStandard(this.name, this.abbreviation);
}

class ShoeSize {
  static const double shoeSizeDefaultValue = 7.0;

  ShoeSizeStandard standard;
  GenderChoices gender;
  double value;

  ShoeSize({
    required this.gender,
    this.value = shoeSizeDefaultValue,
    this.standard = ShoeSizeStandard.us,
  });

  void convertToEu() {
    if (standard == ShoeSizeStandard.us) {
      if (gender == GenderChoices.men) {
        value >= 7.0 ? value += 33 : value += 32.5;
      } else {
        value += 30.5;
      }
    }
    standard = ShoeSizeStandard.eu;
  }

  void convertToUs() {
    if (standard == ShoeSizeStandard.eu) {
      if (gender == GenderChoices.men) {
        value >= 40.0 ? value -= 33 : value -= 32.5;
      } else {
        value -= 30.5;
      }
    }
    standard = ShoeSizeStandard.us;
  }

  void convert(ShoeSizeStandard convertedStandard) {
    if (convertedStandard == ShoeSizeStandard.us) {
      convertToUs();
    } else if (convertedStandard == ShoeSizeStandard.eu) {
      convertToEu();
    }
  }
}

List<ShoeSize> getShoeSizes(GenderChoices gender, ShoeSizeStandard standard) {
  late final List<double> sizes;

  if (gender == GenderChoices.men) {
    sizes = [6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14];
  } else {
    sizes = [5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13];
  }
  return sizes.map((e) => ShoeSize(gender: gender, value: e, standard: ShoeSizeStandard.us)..convert(standard)).toList();
}