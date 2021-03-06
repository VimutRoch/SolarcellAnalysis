import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solarcellanalysis/models/site_model.dart';
import 'package:solarcellanalysis/states/check_pin_code.dart';
import 'package:solarcellanalysis/utility/my_dialog.dart';
import 'package:solarcellanalysis/widgets/show_button.dart';
import 'package:solarcellanalysis/widgets/show_form.dart';
import 'package:solarcellanalysis/widgets/show_image.dart';

class AddSiteId extends StatefulWidget {
  const AddSiteId({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSiteId> createState() => _AddSiteIdState();
}

class _AddSiteIdState extends State<AddSiteId> {
  String? siteId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newLogo(),
              ShowForm(
                hint: 'Site ID :',
                textInputType: TextInputType.number,
                changeFunc: (String string) => siteId = string.trim(),
              ),
              ShowButton(
                  label: 'Send Site ID',
                  pressFunc: () {
                    print('siteId ==>>> $siteId');
                    if (siteId?.isEmpty ?? true) {
                      MyDialog(context: context).normalDialog(
                          title: 'No Site ID', message: 'Please Fill Site ID');
                    } else {
                      processCheckSiteID();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox newLogo() => SizedBox(width: 150, child: ShowImage());

  Future<void> processCheckSiteID() async {
    await FirebaseFirestore.instance
        .collection('Site')
        .doc(siteId)
        .get()
        .then((value) {
      print('value ==> ${value.data()}');

      if (value.data() == null) {
        MyDialog(context: context).normalDialog(
            title: 'Site ID False ?', message: 'No $siteId in my Database');
      } else {
        SiteModel siteModel = SiteModel.fromMap(value.data()!);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CheckPinCode(
                siteModel: siteModel, siteId: siteId!,
              ),
            ),
            (route) => false);
      }
    });
  }
}
