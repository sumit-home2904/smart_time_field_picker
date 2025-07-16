import 'package:flutter/material.dart';
import 'package:text_field_time_picker/text_field_time_picker.dart';

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
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
        ),
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

  final dropdownKey = GlobalKey<TextFieldTimePickerState>();
  final countryController = OverlayPortalController();

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
                child: TextFieldTimePicker(
                  user12Hr: true,
                  key: dropdownKey,
                  controller: countryController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  timePickerDecoration: TimePickerDecoration(),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  onChanged: (String? value) {},
                  listItemBuilder: (context, item, isSelected) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      margin: EdgeInsets.fromLTRB(5, 2, 5, 1),
                      decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.transparent,
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: Text(
                        item,
                        style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    );
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
