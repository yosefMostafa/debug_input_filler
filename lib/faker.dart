import 'package:debug_input_filler/enums.dart';
import 'package:debug_input_filler/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:faker/faker.dart';

class FakerDataGenrator {
  final Faker faker = Faker();

  InputTypes parseKey(ValueKey<String> key) {
    if (key is DebugInputFillerKeys) {
      return key.keyType;
    }
    return InputTypes.randomText;
  }

  String generateValueFromKey(ValueKey<String> key) {
    final type = parseKey(key);
    switch (type) {
      case InputTypes.email:
        return generateEmail();
      case InputTypes.randomText:
        return generateName();
    }
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
