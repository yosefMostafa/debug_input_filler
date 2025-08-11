# Debug_input_filler
[![pub package](https://img.shields.io/pub/v/Debug_input_filler.svg)](https://pub.dev/packages/Debug_input_filler)
[![likes](https://img.shields.io/pub/likes/Debug_input_filler)](https://pub.dev/packages/Debug_input_filler/score)
[![popularity](https://img.shields.io/pub/popularity/Debug_input_filler)](https://pub.dev/packages/Debug_input_filler/score)
[![points](https://img.shields.io/pub/points/Debug_input_filler)](https://pub.dev/packages/Debug_input_filler/score)

 
dependencies:
  Debug_input_filler: ^1.0.0
```
Then run 
```cmd
flutter pub get
```
Dependencies
This package uses the faker package to generate realistic test data.
Usage
```
final List<DebugProfile> profiles = const [
  DebugProfile(
    name: 'Profile 1',
    values: {
      InputTypes.email: "email@example.com",
      InputTypes.password: "password",
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
```
Then in your pages :
```
class DebugInputFillerTestPage extends StatefulWidget {
  const DebugInputFillerTestPage({super.key, required this.title});

  final String title;

  @override
  State<DebugInputFillerTestPage> createState() =>
      _DebugInputFillerTestPageState();
}
```
```
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
```
⚙️ How It Works
> Traverses the widget tree using the provided context

> Finds matching widget types (e.g., DropdownButton, Radio) based on keys

> Calls their change functionality  with the desired or randomized value