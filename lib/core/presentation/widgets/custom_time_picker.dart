import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';

class CustomTimePicker extends StatefulWidget {
  final void Function(TimeOfDay) onSelected;
  final TimeOfDay timeValue;
  final String hintText;
  final IconData iconData;
  final String errorText;
  final bool readOnly;

  const CustomTimePicker({
    Key key,
    @required this.onSelected,
    @required this.timeValue,
    @required this.hintText,
    this.iconData,
    this.errorText,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  final timeController = TextEditingController();

  Future _selectTime(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicked != null) {
      setState(() {
        timeController.text = timeOfDayToString(timePicked);
      });
      widget.onSelected(timePicked);
    }
  }

  @override
  void initState() {
    if (widget.timeValue != null) {
      timeController.text = timeOfDayToString(widget.timeValue);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.readOnly,
      child: CustomTextField(
        context: context,
        controller: timeController,
        readOnly: true,
        hintText: widget.hintText,
        iconData: widget.iconData,
        errorText: widget.errorText,
        suffixIcon: InkWell(
          onTap: () => _selectTime(context),
          child: Icon(Icons.timer),
        ),
      ),
    );
  }

  String timeOfDayToString(TimeOfDay timeOfDay) {
    String hour = timeOfDay.hour.toString().padLeft(2, '0');
    String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
