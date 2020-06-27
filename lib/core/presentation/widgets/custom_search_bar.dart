import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSubmitted;
  final String hintText;
  final SearchDelegate searchDelegate;

  const CustomSearchBar({
    Key key,
    @required this.onSubmitted,
    this.hintText,
    this.searchDelegate,
  }) : super(key: key);

  bool get isSearchDelegate => searchDelegate != null;

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final searchController = TextEditingController();

  void onPressed(BuildContext context) async {
    if (widget.isSearchDelegate) {
      final query = await showSearch(
        context: context,
        delegate: widget.searchDelegate,
      );
      searchController.text = query;
      widget.onSubmitted(query);
    }
  }

  void clear(BuildContext context) {
    searchController.text = '';
    widget.onSubmitted(searchController.text);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: InkWell(
            onTap: () => onPressed(context),
            child: AbsorbPointer(
              absorbing: widget.isSearchDelegate,
              child: CustomTextField(
                context: context,
                controller: searchController,
                hintText: widget.hintText ?? 'search',
                prefixIcon: Icon(Icons.search),
                readOnly: widget.isSearchDelegate,
                onSubmitted:
                    widget.isSearchDelegate ? null : widget.onSubmitted,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => clear(context),
        )
      ],
    );
  }
}
