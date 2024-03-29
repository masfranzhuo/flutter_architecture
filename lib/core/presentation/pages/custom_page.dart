import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/pages/custom_widget.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_search_delegate.dart';

class CustomPage extends StatelessWidget {
  static const routeName = PageType.custom;

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Custom Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final query = await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    hintText: 'Search',
                    useSuggestion: true,
                  ),
                );
                print(query);
              },
            ),
          ],
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              CustomWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
