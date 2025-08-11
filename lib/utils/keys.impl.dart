import 'package:debug_input_filler/utils/enums.dart';
import 'package:flutter/cupertino.dart';

abstract class DebugInputFillerKeys extends ValueKey<String> {
  final InputTypes type;
  final int counter;

  const DebugInputFillerKeys({required this.type, required this.counter})
      : super('$type$counter');

  String get keyName => '$type$counter';
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

class SmallRangeNumberKey extends DebugInputFillerKeys {
  static int index = 0;
  SmallRangeNumberKey()
      : super(
            type: InputTypes.smallRangeNumber,
            counter: SmallRangeNumberKey.index) {
    SmallRangeNumberKey.index++;
  }
}

class MediumRangeNumberKey extends DebugInputFillerKeys {
  static int index = 0;
  MediumRangeNumberKey()
      : super(
            type: InputTypes.mediumRangeNumber,
            counter: MediumRangeNumberKey.index) {
    MediumRangeNumberKey.index++;
  }
}

class LargeRangeNumberKey extends DebugInputFillerKeys {
  static int index = 0;
  LargeRangeNumberKey()
      : super(
            type: InputTypes.largeRangeNumber,
            counter: LargeRangeNumberKey.index) {
    LargeRangeNumberKey.index++;
  }
}

class NameKey extends DebugInputFillerKeys {
  static int index = 0;
  NameKey() : super(type: InputTypes.name, counter: NameKey.index) {
    NameKey.index++;
  }
}

class TextKey extends DebugInputFillerKeys {
  static int index = 0;
  TextKey() : super(type: InputTypes.text, counter: TextKey.index) {
    TextKey.index++;
  }
}

class Text1Key extends DebugInputFillerKeys {
  static int index = 0;
  Text1Key() : super(type: InputTypes.text1, counter: Text1Key.index) {
    Text1Key.index++;
  }
}

class Text2Key extends DebugInputFillerKeys {
  static int index = 0;
  Text2Key() : super(type: InputTypes.text2, counter: Text2Key.index) {
    Text2Key.index++;
  }
}

class Text3Key extends DebugInputFillerKeys {
  static int index = 0;
  Text3Key() : super(type: InputTypes.text3, counter: Text3Key.index) {
    Text3Key.index++;
  }
}

class Text4Key extends DebugInputFillerKeys {
  static int index = 0;
  Text4Key() : super(type: InputTypes.text4, counter: Text4Key.index) {
    Text4Key.index++;
  }
}
