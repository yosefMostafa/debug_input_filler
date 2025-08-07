import 'package:debug_input_filler/enums.dart';
import 'package:flutter/cupertino.dart';

abstract class DebugInputFillerKeys extends ValueKey<String> {
  late final InputTypes type;
  late final int counter;

  DebugInputFillerKeys({required this.type, required this.counter})
      : super('${type.name}$counter');

  String get keyName => '${type.name}$counter';
  get keyType => type;

  @override
  String toString() => keyName;
}

class EmailKey extends DebugInputFillerKeys {
  static int index = 0;
  EmailKey() : super(type: InputTypes.email, counter: EmailKey.index) {
    EmailKey.index++;
  }
}

class PassKey extends DebugInputFillerKeys {
  static int index = 0;
  PassKey() : super(type: InputTypes.password, counter: PassKey.index) {
    PassKey.index++;
  }
}

class RandomTextKey extends DebugInputFillerKeys {
  static int index = 0;
  RandomTextKey()
      : super(type: InputTypes.randomText, counter: RandomTextKey.index) {
    RandomTextKey.index++;
  }
}

class RandomChoiceKey extends DebugInputFillerKeys {
  static int index = 0;
  RandomChoiceKey()
      : super(type: InputTypes.randomText, counter: RandomChoiceKey.index) {
    RandomChoiceKey.index++;
  }
}
