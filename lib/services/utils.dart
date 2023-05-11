bool listEquals(List<dynamic> list1, List<dynamic> list2) {
  if (list1.length != list2.length) {
    return false;
  }
  for (int i = 0; i < list1.length; i++) {
    if (list1[i] != list2[i]) {
      return false;
    }
  }
  return true;
}

List<List<T>> removeDuplicates<T>(List<List<T>> list) {
  return list.fold<List<List<T>>>(
    [],
    (List<List<T>> accumulator, List<T> current) {
      if (!accumulator.any((innerList) => listEquals(innerList, current))) {
        accumulator.add(current);
      }
      return accumulator;
    },
  );
}

int strToHex(String code) {
  return int.parse('0xff$code');
}
