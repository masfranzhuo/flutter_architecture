import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/loading_indicator.dart';

class CustomSafeArea extends SafeArea {
  CustomSafeArea({
    Key key,
    Widget child,
    bool isLoading = false,
  }) : super(
          key: key,
          child: WillPopScope(
            onWillPop: () async => isLoading ? false : true,
            child: Stack(
              children: <Widget>[
                child,
                isLoading ? LoadingIndicator(isFullScreen: true) : SizedBox(),
              ],
            ),
          ),
        );
}
