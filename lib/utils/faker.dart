import 'package:debug_input_filler/utils/enums.dart';
import 'package:debug_input_filler/utils/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:faker/faker.dart';

class FakerDataGenrator {
  final Faker faker = Faker();

  String parseKey(Key? key) {
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
      case InputTypes.smallNumber:
        return generateSmallNumber();
    }
  }

  String generatePassword() {
    return faker.internet.password();
  }

  String generateSmallNumber() {
    return faker.randomGenerator.integer(100).toString();
  }

  String generateEmail() {
    return faker.internet.email();
  }

  String generateRandomText() {
    return faker.lorem.sentence();
  }

  String generateName() {
    return faker.person.name();
  }
}
