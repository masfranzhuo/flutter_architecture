import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //! TODO: custom search bar open page? CustomSearchPage
    return Container(
      child: CustomTextField(
        context: context,
        hintText: 'search',
        prefixIcon: Icon(Icons.search),
        suffixIcon: Icon(Icons.cancel),
      ),
    );
  }
}
