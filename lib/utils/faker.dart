import 'package:debug_input_filler/utils/enums.dart';
import 'package:debug_input_filler/utils/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:faker/faker.dart';

class FakerDataGenrator {
  final Faker faker = Faker();

  InputTypes parseKey(Key? key) {
    if (key is DebugInputFillerKeys) {
      return key.keyType;
    }
    return InputTypes.randomText;
  }

  dynamic generateValueFromKey(Key? key) {
    final type = parseKey(key);
    switch (type) {
      case InputTypes.email:
        return generateEmail();
      case InputTypes.password:
        return generatePassword();
      case InputTypes.randomText:
        return generateRandomText();
      case InputTypes.smallRangeNumber:
        return generateNumber(1, 10);
      case InputTypes.mediumRangeNumber:
        return generateNumber(11, 100);
      case InputTypes.name:
        return generateName();
      case InputTypes.text:
        return generate4words();
      case InputTypes.text1:
        return generate4words();
      case InputTypes.text2:
        return generate4words();
      case InputTypes.text3:
        return generate4words();
      case InputTypes.text4:
        return generate4words();
      case InputTypes.largeRangeNumber:
        return generateNumber(101, 1000);
    }
  }

  String generatePassword() {
    return faker.internet.password();
  }

  String generateNumber(int from, int to) {
    return faker.randomGenerator.integer(to, min: from).toString();
  }

  String generateEmail() {
    return faker.internet.email();
  }

  String generateRandomText() {
    return faker.lorem.sentence();
  }

  String generate4words() {
    return faker.lorem.words(4).join(' ');
  }

  String generateName() {
    return faker.person.name();
  }
}
