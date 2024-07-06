import 'dart:math';

String generateCode() {
  // Create a Random object for generating random numbers
  final random = Random();

  // Initialize an empty string to store the code
  String code = "";

  // Loop 5 times to generate each digit
  for (int i = 0; i < 5; i++) {
    // Generate a random digit between 0 (inclusive) and 9 (inclusive)
    int digit = random.nextInt(10);

    // Convert the digit to a String and append it to the code
    code += digit.toString();
  }

  return code;
}
