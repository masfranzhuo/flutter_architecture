import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';

class CustomDatePicker extends StatefulWidget {
  final void Function(DateTime) onSelected;
  final DateTime dateValue;
  final String hintText;
  final DateTime minDate;
  final DateTime maxDate;
  final IconData iconData;
  final String errorText;
  final bool readOnly;

  const CustomDatePicker({
    Key key,
    @required this.onSelected,
    @required this.dateValue,
    @required this.hintText,
    this.minDate,
    this.maxDate,
    this.iconData,
    this.errorText,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final dateController = TextEditingController();

  Future _selectDate(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: widget.dateValue ?? DateTime.now(),
      firstDate: widget.minDate ??
          DateTime.now().subtract(
            Duration(days: 365 * 100),
          ),
      lastDate: widget.minDate ??
          DateTime.now().add(
            Duration(days: 365 * 10),
          ),
    );
    if (datePicked != null && datePicked != widget.dateValue) {
      setState(() {
        dateController.text =
            datePicked.toIso8601String().toString().split('T')[0];
      });
      widget.onSelected(datePicked);
    }
  }

  @override
  void initState() {
    if (widget.dateValue != null) {
      dateController.text =
          widget.dateValue.toIso8601String().toString().split('T')[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.readOnly,
      child: CustomTextField(
        context: context,
        controller: dateController,
        readOnly: true,
        hintText: widget.hintText,
        iconData: widget.iconData,
        errorText: widget.errorText,
        suffixIcon: GestureDetector(
          onTap: () => _selectDate(context),
          child: Icon(Icons.date_range),
        ),
      ),
    );
  }
}
