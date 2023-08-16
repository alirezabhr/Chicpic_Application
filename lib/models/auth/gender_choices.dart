enum GenderChoices {
  men("M", "Men"),
  women("W", "Women");

  final String abbreviation;
  final String humanReadable;

  const GenderChoices(this.abbreviation, this.humanReadable);
}