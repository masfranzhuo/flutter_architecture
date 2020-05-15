import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/wrap_error_text.w.dart';

class CustomDropdownItem<T> {
  final T value;
  final String label;

  const CustomDropdownItem({@required this.value, @required this.label});
}

class CustomDropDownButton<T> extends StatelessWidget {
  final List<CustomDropdownItem<T>> options;
  final void Function(T) onChange;
  final T value;
  final String hintText;
  final IconData iconData;
  final String errorText;
  final bool readOnly;

  const CustomDropDownButton({
    Key key,
    @required this.options,
    @required this.onChange,
    @required this.value,
    @required this.hintText,
    this.iconData,
    this.errorText,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget dropDownButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color.fromRGBO(0, 0, 0, 0.5),
      ),
      child: AbsorbPointer(
        absorbing: readOnly,
        child: DropdownButton<T>(
          icon: Icon(Icons.arrow_drop_down),
          isExpanded: true,
          underline: SizedBox(),
          hint: Text(hintText),
          style: Theme.of(context).textTheme.bodyText1,
          value: value,
          items: options != null
              ? options
                  .map((option) => DropdownMenuItem<T>(
                      child: Text(option.label), value: option.value))
                  .toList()
              : null,
          onChanged: (value) => onChange(value),
        ),
      ),
    );

    return WrapErrorText(
      iconData: iconData,
      errorText: errorText,
      child: dropDownButton,
    );
  }
}
