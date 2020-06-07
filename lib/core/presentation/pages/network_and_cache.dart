import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_text_field.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkAndCache extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        String errorText;
        if (state is AccountErrorState) {
          errorText = state.message;
        }

        String id = 'id';
        String name = 'name';
        if (state is AccountLoadedState) {
          id = state.account.id;
          name = state.account.name;
        }

        return Column(
          children: <Widget>[
            CustomTextField(
              context: context,
              hintText: '$name-$id',
              errorText: errorText,
            ),
            SizedBox(height: 8),
            CustomButton(
              child: Text('Get User Profile'),
              onPressed: () {
                BlocProvider.of<AccountBloc>(context).add(
                  GetUserProfileEvent(id: id),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
