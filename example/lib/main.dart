import 'package:flutter/material.dart';
import 'package:smart_time_field_picker/smart_time_field_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormFiled DropDown Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
        ),
        appBarTheme: const AppBarTheme(color: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DropDownClass(),
    );
  }
}

class DropDownClass extends StatefulWidget {
  const DropDownClass({super.key});

  @override
  State<DropDownClass> createState() => _DropDownClassState();
}

class _DropDownClassState extends State<DropDownClass> {
  final dropdownKey = GlobalKey<SmartTimeFieldState>();
  final countryController = OverlayPortalController();
  String? value = "12:10";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FormFiled DropDown Example",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SmartTimeFieldPicker(
                user12Hr: true,
                key: dropdownKey,
                initialItem: value,
                controller: countryController,
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                onChanged: (String? value) {
                  value = value;
                  // print("object $value");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
