enum LengthUnit {
  cm('cm', 'cm'),
  feetInches('Feet & Inches', 'in.');

  final String name;
  final String abbreviation;

  const LengthUnit(this.name, this.abbreviation);
}

class Length {
  LengthUnit unit;
  int cmValue;
  int inchesValue;
  int feetValue;

  Length({
    this.unit = LengthUnit.cm,
    this.cmValue = 0,
    this.inchesValue = 0,
    this.feetValue = 0,
  });

  void convertToFeetInches() {
    if (unit == LengthUnit.cm) {
      int inches = (cmValue / 2.54).round();
      feetValue = (inches / 12).floor();
      inchesValue = inches % 12;
    }
    unit = LengthUnit.feetInches;
  }

  void convertToCm() {
    if (unit == LengthUnit.feetInches) {
      int inches = feetValue * 12 + inchesValue;
      cmValue = (inches * 2.54).round();
    }
    unit = LengthUnit.cm;
  }

  void convert(LengthUnit convertedUnit) {
    if (convertedUnit == LengthUnit.cm) {
      convertToCm();
    } else if (convertedUnit == LengthUnit.feetInches) {
      convertToFeetInches();
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
