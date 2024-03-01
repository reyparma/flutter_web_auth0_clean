import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth0_clean/app/injection_container.dart';
import 'package:flutter_web_auth0_clean/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_web_auth0_clean/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_web_auth0_clean/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:hive/hive.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  final TextStyle _textStyle = const TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
      if (state is! UserProfileLoaded) {
        return const Center(child: CircularProgressIndicator());
      } else {
        final userProfile = state.user;
        return Scaffold(
          appBar: _appBar('${userProfile!.nickname}',
              '${userProfile.pictureUrl}', context),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      '[ NOTE: Use the "--web-renderer=html" option to show the picture avatar properly. ]'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                  child: Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        TableRow(children: [
                          _paddedWidget(_boldText('Email')),
                          _paddedWidget(Text('${userProfile.email}')),
                        ]),
                        TableRow(children: [
                          _paddedWidget(_boldText('Name')),
                          _paddedWidget(Text('${userProfile.name}')),
                        ]),
                        TableRow(children: [
                          _paddedWidget(_boldText('Picture')),
                          _paddedWidget(Container(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              radius: 16,
                              child: ClipOval(
                                child: Image.network(
                                  '${userProfile.pictureUrl}',
                                ),
                              ),
                            ),
                          )),
                        ]),
                        TableRow(children: [
                          _paddedWidget(_boldText('Nickname')),
                          _paddedWidget(Text('${userProfile.nickname}')),
                        ]),
                        TableRow(children: [
                          _paddedWidget(_boldText('IsEmailVerified')),
                          _paddedWidget(
                              Text('${userProfile.isEmailVerified}'))
                        ]),
                        TableRow(children: [
                          _paddedWidget(_boldText('UpdatedAt')),
                          _paddedWidget(Text('${userProfile.updatedAt}'))
                        ]),
                      ]),
                ),
              ]),
            ),
          ),
        );
      }
    });
  }

  Widget _paddedWidget(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget,
    );
  }

  Widget _boldText(String text) {
    return Text(text, style: _textStyle);
  }

  AppBar _appBar(String nickname, String pictureUrl, BuildContext context) {
    return AppBar(
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Center(
            child: Text('User Profile', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.black87,
        actions: [
          _paddedWidget(
              Text(nickname, style: const TextStyle(color: Colors.white))),
          CircleAvatar(
            radius: 16,
            child: ClipOval(
              child: Image.network(
                pictureUrl,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(LogOut());
              },
              icon: const Icon(Icons.logout, color: Colors.white))
        ]);
  }
}
