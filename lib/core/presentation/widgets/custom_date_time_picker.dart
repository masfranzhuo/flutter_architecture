import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_date_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_time_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/utils/input_error_text.w.dart';

class CustomDateTimePicker extends StatefulWidget {
  final String hintText;
  final void Function(DateTime) onSelected;
  final DateTime dateTimeValue;
  final DateTime minDate;
  final DateTime maxDate;
  final IconData iconData;
  final String errorText;
  final bool readOnly;

  const CustomDateTimePicker({
    Key key,
    @required this.hintText,
    @required this.onSelected,
    this.dateTimeValue,
    this.minDate,
    this.maxDate,
    this.iconData,
    this.errorText,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _CustomDateTimePickerState createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  DateTime date;
  TimeOfDay time = TimeOfDay(hour: 0, minute: 0);

  void _selectDateTime(BuildContext context) {
    if (date != null) {
      DateTime dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      widget.onSelected(dateTime);
    }
  }

  @override
  void initState() {
    if (widget.dateTimeValue != null) {
      date = widget.dateTimeValue;
      time = TimeOfDay(hour: date.hour, minute: date.minute);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget iconData = SizedBox();
    if (widget.iconData != null) {
      iconData = Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          widget.iconData,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    BoxDecoration errorBoxDecoration = widget.errorText != null
        ? BoxDecoration(
            border: Border.all(color: Theme.of(context).errorColor),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            iconData,
            Flexible(
              flex: 2,
              child: Container(
                decoration: errorBoxDecoration,
                child: CustomDatePicker(
                  hintText: widget.hintText,
                  dateValue: date,
                  readOnly: widget.readOnly,
                  minDate: widget.minDate,
                  maxDate: widget.maxDate,
                  onSelected: (value) {
                    setState(() {
                      date = value;
                    });
                    _selectDateTime(context);
                  },
                ),
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              flex: 1,
              child: Container(
                decoration: errorBoxDecoration,
                child: CustomTimePicker(
                  hintText: '',
                  timeValue: time,
                  readOnly: widget.readOnly,
                  onSelected: (value) {
                    setState(() {
                      time = value;
                    });
                    _selectDateTime(context);
                  },
                ),
              ),
            ),
          ],
        ),
        InputErrorText(
          errorText: widget.errorText,
          isIconAvailable: widget.iconData != null,
        ),
      ],
    );
  }
}
