import 'package:debug_input_filler/debug_input_filler.dart';
import 'package:debug_input_filler/utils/enums.dart';
import 'package:debug_input_filler/widgets/highlight_wrapper.dart';
import 'package:debug_input_filler/utils/keys.dart';
import 'package:debug_input_filler/profiling/profiling.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<DebugProfile> profiles = const [
  DebugProfile(
    name: 'Profile 1',
    values: {
      InputTypes.email: "email@example.com",
      InputTypes.password: "password",
      // InputTypes.randomText: "<random text>",
    },
  ),
  DebugProfile(
    name: 'Profile 2',
    values: {
      InputTypes.email: "yosef@gmail.com",
      InputTypes.password: "123456",
      InputTypes.randomText: "Lorem ipsum dolor sit amet",
      InputTypes.text: "Sample text",
      InputTypes.text2: "Another sample text",
    },
  ),
  DebugProfileAuto(),
];
void main() {
  runApp(
    DebugInitialValues(
      builder: (context) {
        return const MyApp();
      },
      initializeValues: () {},
      detctionAlgorithm: DebugInputFillerTypes.auto,
    )..configProfiles(profiles: profiles, profileIndex: 0),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debug input Filler Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DebugInputFillerTestPage(title: 'Debug input Filler Demo'),
    );
  }
}

class DebugInputFillerTestPage extends StatefulWidget {
  const DebugInputFillerTestPage({super.key, required this.title});

  final String title;

  @override
  State<DebugInputFillerTestPage> createState() =>
      _DebugInputFillerTestPageState();
}

class _DebugInputFillerTestPageState extends State<DebugInputFillerTestPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _randomTextController = TextEditingController();
  final TextEditingController _dropdownController = TextEditingController();
  final TextEditingController _capentinoField = TextEditingController();
  bool _checkboxValue = false;
  bool _checkbosList = false;
  String dropDownButtonValue = 'Option 1';
  String radioChoice = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: HighlightWrapper(
        highlight: true,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(key: EmailKey(), controller: _emailController),
                TextFormField(
                  controller: _passwordController,
                  key: PassKey(),
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                TextField(key: EmailKey(), controller: _randomTextController),
                HighlightWrapper(
                  highlight: true,
                  child: CupertinoTextField(
                    key: RandomTextKey(),
                    controller: _capentinoField,
                    placeholder: 'Enter random text',
                  ),
                ),
                DropdownMenu(
                  key: RandomChoiceKey(),
                  onSelected: (value) {
                    debugPrint('Selected value: ${value.toString()}');
                  },
                  controller: _dropdownController,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry<String>(
                      value: 'Option 1',
                      label: 'Option 1',
                    ),
                    DropdownMenuEntry<String>(
                      value: 'Option 2',
                      label: 'Option 2',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      key: RandomChoiceKey(),
                      value: dropDownButtonValue,
                      items: [
                        DropdownMenuItem(
                          value: 'Option 1',
                          child: Text('Option 1'),
                        ),
                        DropdownMenuItem(
                          value: 'Option 2',
                          child: Text('Option 2'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropDownButtonValue = value.toString();
                        });
                      },
                    ),
                  ],
                ),
                Radio(
                  key: RandomChoiceKey(),
                  value: 'Option 1',
                  groupValue: radioChoice,
                  onChanged: (value) {
                    setState(() {
                      radioChoice = value.toString();
                    });
                  },
                ),
                Radio(
                  key: RandomChoiceKey(),
                  value: 'Option 2',
                  groupValue: radioChoice,
                  onChanged: (value) {
                    setState(() {
                      radioChoice = value.toString();
                    });
                  },
                ),
                CheckboxListTile(
                  key: RandomChoiceKey(),
                  title: const Text('Random Choice'),
                  value: _checkbosList,
                  onChanged: (value) {
                    setState(() {
                      _checkbosList = value ?? false;
                    });
                  },
                ),
                Checkbox(
                  key: RandomChoiceKey(),
                  value: _checkboxValue,
                  onChanged: (value) {
                    setState(() {
                      _checkboxValue = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
