import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final String hintText;
  final bool useSuggestion;

  CustomSearchDelegate({
    this.hintText,
    this.useSuggestion = false,
  }) : super(
          searchFieldLabel: hintText ?? 'search',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  void showResults(BuildContext context) {
    useSuggestion ? super.showResults(context) : close(context, query);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListView(
      children: <Widget>[
        query != ''
            ? ListTile(
                title: Text(query),
                onTap: () {
                  close(context, query);
                },
              )
            : SizedBox(),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return ListView();
  }
}
