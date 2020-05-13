import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_drop_down_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';

class CustomWidget extends StatefulWidget {
  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  DateTime selectedDate;
  int selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text('CustomDropDownButton'),
          children: <Widget>[
            CustomDropDownButton(
              options: [
                CustomDropdownItem(value: 1, label: 'One'),
                CustomDropdownItem(value: 2, label: 'Two'),
              ],
              hintText: 'Custom DropDownButton',
              onChange: (value) {},
              iconData: Icons.home,
              readOnly: true,
            ),
            SizedBox(height: 8),
            CustomDropDownButton(
              options: [
                CustomDropdownItem(value: 1, label: 'One'),
                CustomDropdownItem(value: 2, label: 'Two'),
              ],
              hintText: 'Custom DropDownButton',
              value: selectedValue,
              onChange: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
            SizedBox(height: 8),
          ],
        ),
        ExpansionTile(
          title: Text('CustomTextField'),
          children: <Widget>[
            CustomTextField(
              context: context,
              hintText: 'Custom TextField',
              iconData: Icons.home,
              readOnly: true,
            ),
            SizedBox(height: 8),
            CustomTextField(
              context: context,
              hintText: 'Custom TextField',
            ),
            SizedBox(height: 8),
          ],
        ),
        ExpansionTile(
          title: Text('CustomButton'),
          children: <Widget>[
            CustomButton(
              state: ButtonState.done,
              onPressed: () {},
              child: Text('Home Page'),
            ),
            SizedBox(height: 8),
            CustomButton(
              state: ButtonState.loading,
              onPressed: () {},
              child: Text('Home Page'),
            ),
            SizedBox(height: 8),
            CustomButton(
              state: ButtonState.idle,
              onPressed: () {},
              child: Text('Home Page'),
            ),
            SizedBox(height: 8),
          ],
        ),
      ],
    );
  }
}
