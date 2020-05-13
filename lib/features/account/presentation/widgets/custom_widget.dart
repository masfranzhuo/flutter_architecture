import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_date_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_date_time_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_drop_down_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_time_picker.dart';

class CustomWidget extends StatefulWidget {
  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  DateTime selectedDateTime;
  DateTime selectedDate;
  TimeOfDay selectedTime;
  int selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          initiallyExpanded: true,
          title: Text('CustomDateRangePicker'),
          children: <Widget>[
            CustomDateTimePicker(
              dateTimeValue: selectedDateTime,
              hintText: 'Custom DateRangePicker',
              onSelected: (value) {
                setState(() {
                  selectedDateTime = value;
                });
                print('selectedDateTime: $selectedDateTime');
              },
            ),
            SizedBox(height: 8),
          ],
        ),
        ExpansionTile(
          title: Text('CustomDateTimePicker'),
          children: <Widget>[
            CustomDateTimePicker(
              dateTimeValue: DateTime.now(),
              hintText: 'Custom DateTimePicker',
              iconData: Icons.date_range,
              readOnly: true,
              errorText: 'Error',
              onSelected: (value) {},
            ),
            SizedBox(height: 8),
            CustomDateTimePicker(
              dateTimeValue: selectedDateTime,
              hintText: 'Custom DateTimePicker',
              onSelected: (value) {
                setState(() {
                  selectedDateTime = value;
                });
                print('selectedDateTime: $selectedDateTime');
              },
            ),
            SizedBox(height: 8),
          ],
        ),
        ExpansionTile(
          title: Text('CustomTimePicker'),
          children: <Widget>[
            CustomTimePicker(
              timeValue: TimeOfDay.now(),
              hintText: 'Custom TimePicker',
              iconData: Icons.timer,
              readOnly: true,
              errorText: 'Error',
              onSelected: (value) {},
            ),
            SizedBox(height: 8),
            CustomTimePicker(
              timeValue: selectedTime,
              hintText: 'Custom TimePicker',
              onSelected: (value) {
                setState(() {
                  selectedTime = value;
                });
                print('selectedTime: $selectedTime');
              },
            ),
            SizedBox(height: 8),
          ],
        ),
        ExpansionTile(
          title: Text('CustomDatePicker'),
          children: <Widget>[
            CustomDatePicker(
              dateValue: DateTime.now(),
              hintText: 'Custom DatePicker',
              iconData: Icons.date_range,
              readOnly: true,
              errorText: 'Error',
              onSelected: (value) {},
            ),
            SizedBox(height: 8),
            CustomDatePicker(
              dateValue: selectedDate,
              hintText: 'Custom DatePicker',
              onSelected: (value) {
                setState(() {
                  selectedDate = value;
                });
                print('selectedDate: $selectedDate');
              },
            ),
            SizedBox(height: 8),
          ],
        ),
        ExpansionTile(
          title: Text('CustomDropDownButton'),
          children: <Widget>[
            CustomDropDownButton(
              options: [
                CustomDropdownItem(value: 1, label: 'One'),
                CustomDropdownItem(value: 2, label: 'Two'),
              ],
              hintText: 'Custom DropDownButton',
              value: 1,
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
                print('selectedValue: $selectedValue');
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
              controller: TextEditingController(text: 'Custom TextField'),
              hintText: 'Custom TextField',
              iconData: Icons.home,
              readOnly: true,
              errorText: 'Error',
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
            CustomButton(
              state: ButtonState.idle,
              isFullWidth: true,
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
