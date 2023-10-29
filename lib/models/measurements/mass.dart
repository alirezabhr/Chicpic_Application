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