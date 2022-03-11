import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solarcellanalysis/utility/my_constant.dart';
import 'package:solarcellanalysis/widgets/show_button.dart';

class ShowSignOut extends StatelessWidget {
  const ShowSignOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowButton(
        label: 'SignOut',
        pressFunc: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.clear().then((value) => Navigator.pushNamedAndRemoveUntil(
              context, Myconstant.routeFindAPIkey, (route) => false));
        });
  }
}
