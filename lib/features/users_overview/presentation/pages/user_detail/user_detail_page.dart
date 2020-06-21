import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';

class UserDetailPage extends StatelessWidget {
  static const routeName = PageType.userDetail;

  final Account user;

  const UserDetailPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('User Detail')),
        body: LayoutBuilder(builder: _buildBody),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: ListView(
        children: <Widget>[
          _userProfielImage(context, url: user.photoUrl),
          _userData(user: user),
        ],
      ),
    );
  }

  Widget _userProfielImage(context, {@required String url}) {
    double width = MediaQuery.of(context).size.width / 4;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: width),
      child: ClipOval(
        child:
            url != null ? Image.network(url) : Icon(Icons.person, size: width),
      ),
    );
  }

  Widget _userData({@required Account user}) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Name'),
          subtitle: Text(user.name),
        ),
        ListTile(
          title: Text('Email'),
          subtitle: Text(user.email),
        ),
        ListTile(
          title: Text('Phone Number'),
          subtitle: Text(user?.phoneNumber ?? '-'),
        ),
        ListTile(
          title: Text('Account Status'),
          subtitle: Text(AccountStatus.accountStatusLabel[user.accountStatus]),
        ),
      ],
    );
  }
}
