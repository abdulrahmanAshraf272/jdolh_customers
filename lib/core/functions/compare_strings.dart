bool compareStrings(String text1, String text2) {
  // Split the strings by comma and remove extra spaces
  List<String> list1 = text1.split(',').map((e) => e.trim()).toList();
  List<String> list2 = text2.split(',').map((e) => e.trim()).toList();

  // Sort the lists
  list1.sort();
  list2.sort();

  // Check if the sorted lists are equal
  return list1.toString() == list2.toString();
}

// void main() {
//   String text1 = 'one, two, three';
//   String text2 = 'two, one, three';

//   print(compareStrings(text1, text2)); // Output: true

//   text1 = 'one, two';
//   text2 = 'one, two';

//   print(compareStrings(text1, text2)); // Output: true

//   text1 = 'one, two';
//   text2 = 'one, three';

//   print(compareStrings(text1, text2)); // Output: false
// }