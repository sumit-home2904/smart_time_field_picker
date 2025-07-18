# 📦 smart_time_field_picker
A customizable Flutter plugin that provides a powerful SmartTimeField-based 
time picker with support for:

----

## Features
- ✅ 12-hour & 24-hour formats
- 🔍 Searchable dropdown with keyboard support
- 💻 Full keyboard interaction (arrow, enter, escape)
- 🧠 Smart auto-formatting
- 🎯 Easily embedded in forms
- 🎨 Fully themable via InputDecoration & dropdown builder
- 🚀 Installation

---

## Installation
1.Add this to your pubspec.yaml:

```yaml
dependencies:
 smart_time_field_picker: ^<latest-version>
```

2.Import the package and use it in your Flutter App.
🛠️ Usage
```dart
import 'package:smart_time_field_picker/smart_time_field_picker.dart';
```

## Example usage
### **1.Basic SearchFieldDropdown**

**⌨️ Keyboard Interaction**
- Arrow Up/Down: Navigate time list 
- Enter: Select highlighted time 
- Escape: Close the dropdown 
- Typing: Supports HHmm format (e.g., 1345 → 1:45 PM)

A GlobalKey`<SmartTimeFieldState>` is used to uniquely identify and manage the state of a SmartTimeField
widget, allowing you to interact with its internal state (e.g., selecting an item or retrieving the selected value)
from outside the widget.

```dart
final GlobalKey<SmartTimeFieldState<String>> timePickerKey = GlobalKey<SmartTimeFieldState<String>>();
```

**Purpose:**
The GlobalKey`<SmartTimeFieldState>` allows you to access the state of the SmartTimeField widget,
which is useful when you need to control the dropdown’s behavior programmatically. By associating a key
with the SmartTimeField, you can call methods on its state, trigger a rebuild, or update its selected
value from a parent widget or another part of your app.



```dart
class SmartTimeClass extends StatelessWidget {
  SmartTimeClass({super.key});

  final countryController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return SmartTimeField(
      user12Hr: true,
      readOnly: true,
      key: dropdownKey,
      initialItem: value,
      controller: countryController,
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      onChanged: (String? va) {
        value = va;
      },
    );
  }
}
```

### **2.🔧 Customization**
- TimePickerDecoration supports:
- Dropdown item builder (optional)
- You can customize how each time slot is displayed with dropdownItemBuilder.

```dart
TimePickerDecoration(
  hintText: "Pick a time",
  labelText: "Shift Start",
  prefixIcon: Icon(Icons.access_time),
  border: OutlineInputBorder(),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1),
  ),
  contentPadding: EdgeInsets.all(12),
)
```
