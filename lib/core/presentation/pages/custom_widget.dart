import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/pages/custom_page.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_date_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_date_range.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_date_time_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_drop_down_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_image_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_search_bar.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_time_picker.dart';
import 'package:flutter_architecture/features/storage/presentation/pages/image_picker_page/image_picker_page.dart';

class CustomWidget extends StatefulWidget {
  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  DateTime selectedDate, selectedDateTime, selectedStartDate, selectedEndDate;
  TimeOfDay selectedTime;
  int selectedValue;
  String imageUrl;
  File file;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          initiallyExpanded: true,
          title: Text('CustomSearchBar'),
          children: <Widget>[
            CustomSearchBar(),
            SizedBox(height: 8),
          ],
        ),
        ExpansionTile(
          title: Text('CustomImagePicker'),
          children: <Widget>[
            CustomImagePicker(
              imageUrl:
                  'https://via.placeholder.com/512x512.png?text=Image picker preview',
              errorText: 'Error',
              readOnly: true,
              onPicked: (value) {},
            ),
            SizedBox(height: 8),
            CustomImagePicker(
              isCropAvailable: true,
              onPicked: (value) {
                setState(() {
                  file = value;
                });
                print('onPicked => file.path: ${file.path}');
              },
            ),
            SizedBox(height: 8),
            file != null ? Image.file(file) : SizedBox(),
            SizedBox(height: 8),
            CustomButton(
              onPressed: () async {
                File imageFile = await Navigator.of(context).push(
                  CustomPageRoute.slide(
                    page: ImagePickerPage(),
                    pageType: PageType.imagePicker,
                  ),
                );
                setState(() {
                  file = imageFile;
                });
                print('Page => file.path: ${file.path}');
              },
              child: Text('Image Picker Page'),
            ),
            SizedBox(height: 8),
          ],
        ),
        ExpansionTile(
          title: Text('CustomDateRangePicker'),
          children: <Widget>[
            CustomDateRangePicker(
              startDateValue: DateTime.now(),
              endDateValue: DateTime.now(),
              startDateHintText: 'Custom startDateRangePicker',
              endDateHintText: 'Custom endDateRangePicker',
              iconData: Icons.date_range,
              readOnly: true,
              errorText: 'Error',
              onStartDateSelected: (value) {},
              onEndDateSelected: (value) {},
            ),
            SizedBox(height: 8),
            CustomDateRangePicker(
              startDateValue: selectedDateTime,
              endDateValue: selectedEndDate,
              startDateHintText: 'Custom startDateRangePicker',
              endDateHintText: 'Custom endDateRangePicker',
              onStartDateSelected: (value) {
                setState(() {
                  selectedStartDate = value;
                });
                print('selectedStartDate: $selectedStartDate');
              },
              onEndDateSelected: (value) {
                setState(() {
                  selectedEndDate = value;
                });
                print('selectedEndDate: $selectedEndDate');
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
              errorText: 'Error',
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
          title: Text('CustomSnackBar'),
          children: <Widget>[
            CustomButton(
              child: Text('Default SnackBar'),
              onPressed: () {
                CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'Default',
                );
              },
            ),
            SizedBox(height: 8),
            CustomButton(
              child: Text('Success SnackBar'),
              onPressed: () {
                CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'Success',
                  mode: SnackBarMode.success,
                );
              },
            ),
            SizedBox(height: 8),
            CustomButton(
              child: Text('Error SnackBar'),
              onPressed: () {
                CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'Error',
                  mode: SnackBarMode.error,
                );
              },
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
              onPressed: () {
                Navigator.of(context).pushReplacement(CustomPageRoute.slide(
                  page: CustomPage(),
                  pageType: PageType.custom,
                ));
              },
              child: Text('Home Page'),
            ),
            SizedBox(height: 8),
            CustomButton(
              state: ButtonState.idle,
              isFullWidth: true,
              onPressed: () {
                Navigator.of(context).pushReplacement(CustomPageRoute.fade(
                  page: CustomPage(),
                  pageType: PageType.custom,
                ));
              },
              child: Text('Home Page'),
            ),
            SizedBox(height: 8),
          ],
        ),
      ],
    );
  }
}
