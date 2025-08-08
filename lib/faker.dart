import 'package:debug_input_filler/enums.dart';
import 'package:debug_input_filler/keys.dart';
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
    }
  }

  String generatePassword() {
    return faker.internet.password();
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
