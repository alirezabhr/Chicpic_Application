enum LengthUnit {
  cm('cm', 'cm'),
  inches('Inches', 'in.');

  final String name;
  final String abbreviation;

  const LengthUnit(this.name, this.abbreviation);
}

class Length {
  LengthUnit unit;
  int value;

  Length({
    this.value = 0,
    this.unit = LengthUnit.cm,
  });

  void convertToInches() {
    if (unit == LengthUnit.cm) {
      value = (value * 2.54).round();
    }
    unit = LengthUnit.inches;
  }

  void convertToCm() {
    if (unit == LengthUnit.inches) {
      value = (value / 2.54).round();
    }
    unit = LengthUnit.cm;
  }

  void convert(LengthUnit convertedUnit) {
    if (convertedUnit == LengthUnit.cm) {
      convertToCm();
    } else if (convertedUnit == LengthUnit.inches) {
      convertToInches();
    }
  }
}

enum MassUnit {
  kg('Kg', 'Kg'),
  pound('Pound', 'lbs');

  final String name;
  final String abbreviation;

  const MassUnit(this.name, this.abbreviation);
}

class Mass {
  MassUnit unit;
  int value;

  Mass({
    this.value = 0,
    this.unit = MassUnit.kg,
  });

  void convertToPound() {
    if (unit == MassUnit.kg) {
      value = (value * 2.2).round();
    }
    unit = MassUnit.pound;
  }

  void convertToKg() {
    if (unit == MassUnit.pound) {
      value = (value / 2.2).round();
    }
    unit = MassUnit.kg;
  }

  void convert(MassUnit convertedUnit) {
    if (convertedUnit == MassUnit.kg) {
      convertToKg();
    } else if (convertedUnit == MassUnit.pound) {
      convertToPound();
    }
  }
}
