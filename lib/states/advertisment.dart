import 'package:flutter/material.dart';
import 'package:solarcellanalysis/utility/my_constant.dart';
import 'package:solarcellanalysis/widgets/show_image.dart';

class Advertistment extends StatelessWidget {
  const Advertistment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advertistment'),
        backgroundColor: Colors.white,
        foregroundColor: Myconstant.dark,
        actions: [
          SizedBox(
            child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ShowImage(path: 'images/logo.png')),
            width: 48,
          )
        ],
      ),
      body: const Text('ads'),
    );
  }
}