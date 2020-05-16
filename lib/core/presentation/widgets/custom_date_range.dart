import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_date_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/wrap_error_text.w.dart';

class CustomDateRangePicker extends StatefulWidget {
  final String startDateHintText;
  final String endDateHintText;
  final void Function(DateTime) onStartDateSelected;
  final void Function(DateTime) onEndDateSelected;
  final DateTime startDateValue;
  final DateTime endDateValue;
  final DateTime minDate;
  final DateTime maxDate;
  final IconData iconData;
  final String errorText;
  final bool readOnly;

  const CustomDateRangePicker({
    Key key,
    @required this.startDateHintText,
    @required this.endDateHintText,
    @required this.onStartDateSelected,
    @required this.onEndDateSelected,
    this.startDateValue,
    this.endDateValue,
    this.minDate,
    this.maxDate,
    this.iconData,
    this.errorText,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _CustomDateRangeState createState() => _CustomDateRangeState();
}

class _CustomDateRangeState extends State<CustomDateRangePicker> {
  DateTime startDate;
  DateTime endDate;

  void _selectStartDate(BuildContext context) {
    if (startDate != null) {
      widget.onStartDateSelected(startDate);
    }
  }

  void _selectEndDate(BuildContext context) {
    if (endDate != null) {
      widget.onEndDateSelected(endDate);
    }
  }

  @override
  void initState() {
    if (widget.startDateValue != null) {
      startDate = widget.startDateValue;
    }
    if (widget.endDateValue != null) {
      endDate = widget.endDateValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget dateRangePicker = Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            child: CustomDatePicker(
              hintText: widget.startDateHintText,
              dateValue: startDate,
              readOnly: widget.readOnly,
              minDate: widget.minDate,
              maxDate: endDate ?? widget.maxDate,
              onSelected: (value) {
                setState(() {
                  startDate = value;
                });
                _selectStartDate(context);
              },
            ),
          ),
        ),
        SizedBox(width: 8),
        Flexible(
          flex: 1,
          child: Container(
            child: CustomDatePicker(
              hintText: widget.endDateHintText,
              dateValue: endDate,
              readOnly: startDate == null ?? widget.readOnly,
              minDate: startDate ?? widget.minDate,
              maxDate: widget.maxDate,
              onSelected: (value) {
                setState(() {
                  endDate = value;
                });
                _selectEndDate(context);
              },
            ),
          ),
        ),
      ],
    );

    return WrapErrorText(
      iconData: widget.iconData,
      errorText: widget.errorText,
      child: dateRangePicker,
    );
  }
}
