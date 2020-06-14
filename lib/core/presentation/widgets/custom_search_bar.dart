import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_search_hint_delegate.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;

  const CustomSearchBar({Key key, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPressed(BuildContext context) {
      showSearch(
        context: context,
        delegate: CustomSearchHintDelegate(hintText: hintText),
      );
    }

    return InkWell(
      onTap: () => onPressed(context),
      child: AbsorbPointer(
        child: CustomTextField(
          context: context,
          hintText: hintText ?? 'search',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.cancel),
          readOnly: true,
        ),
      ),
    );
  }
}
