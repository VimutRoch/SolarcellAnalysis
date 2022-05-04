// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:solarcellanalysis/widgets/show_image.dart';
import 'package:solarcellanalysis/utility/my_constant.dart';
import 'package:solarcellanalysis/widgets/show_card.dart';
import 'package:solarcellanalysis/widgets/show_text.dart';
import 'package:solarcellanalysis/models/site_model.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:solarcellanalysis/widgets/show_image.dart';

SizedBox newImage() => SizedBox(width: 120, child: ShowImage());
      SizedBox newImage2() => SizedBox(width: 140, child: ShowImage2());

class ContactUs extends StatefulWidget {
  final List<String> datas;
  const ContactUs({
    Key? key,
    required this.datas,
  }) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
           
         
        
        foregroundColor: Myconstant.dark,
        backgroundColor: Colors.white,
         actions: [
          SizedBox(
            child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ShowImage(path: 'images/logo.png')),
            width: 48,
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowCard2(
                size: constraints.maxWidth * 0.33,
                label: 'Contact Us',
                pathImage: 'images/contact.png'),
            ListTile(
              leading: Icon(Icons.home_repair_service),
              title: ShowText(label: 'แจ้งซ่อม'),
            ),
             ListTile(
              leading: Icon(Icons.history),
              title: ShowText(label: 'ประวัติการซ่อม'),
            ),
             ListTile(
              leading: Icon(Icons.phone),
              title: ShowText(label: 'เบอร์ติดต่อ : 064-151-4491 หรือ 02-005-2991'),
            ),
             ListTile(
              leading: Icon(Icons.home_outlined),
              title: ShowText(label: 'ที่อยู่บริษัท : 88 ถนนนครอินทร์ ตำบลตลาดขวัญ อำเภอเมืองนนทบุรี จังหวัดนนทบุรี 11000'),
            ),
          ],
        ),
      ),
    );
      SizedBox newImage() => SizedBox(width: 120, child: ShowImage());
      SizedBox newImage2() => SizedBox(width: 140, child: ShowImage2());
  }
}