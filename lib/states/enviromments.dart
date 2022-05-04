import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solarcellanalysis/utility/my_constant.dart';
import 'package:solarcellanalysis/models/env_benefits_model.dart';
import 'package:dio/dio.dart';
import 'package:solarcellanalysis/widgets/show_image.dart';
import 'package:solarcellanalysis/widgets/show_progress.dart';
import 'package:solarcellanalysis/widgets/show_text.dart';
import 'package:solarcellanalysis/states/main_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

EnvBenefitsModel? envBenefitsModel;

class Environments extends StatefulWidget {
  const Environments({Key? key}) : super(key: key);

  @override
  State<Environments> createState() => _EnvironmentsState();
}

class _EnvironmentsState extends State<Environments> {
  bool load = true;
  String? urlImage;
  var datas = <String>[];
  EnvBenefitsModel? envBenefitsModel;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    datas = preferences.getStringList('data')!;

// for environment
    String pathEnvBenefits =
        'https://monitoringapi.solaredge.com/site/${datas[0]}/envBenefits?api_key=${datas[1]}';
    await Dio().get(pathEnvBenefits).then((value) {
      Map<String, dynamic> envBenefitsMap = value.data['envBenefits'];

      setState(() {
        load = false;
        envBenefitsModel = EnvBenefitsModel.fromMap(envBenefitsMap);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Environment Factors'),
        actions: [
          SizedBox(
            child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ShowImage(path: 'images/logo.png')),
            width: 48,
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Myconstant.dark,
      ),
      body: load
          ? const ShowProgress()
          : LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    EnvData(
                      constraints: constraints,
                      path: 'images/tree.png',
                      label: 'Equivalent Tree Planted',
                      value: envBenefitsModel!.treesPlanted,
                    ),
                    EnvData(
                        constraints: constraints,
                        path: 'images/co2.png',
                        label: 'Co2 Emission Saved',
                        value: envBenefitsModel!.gasEmissionSaved.co2,
                        units: envBenefitsModel!.gasEmissionSaved.units),
                    EnvData(
                      constraints: constraints,
                      path: 'images/bulb.png',
                      label: 'Equivalent Light Bulbs',
                      value: envBenefitsModel!.lightBulbs,
                    )
                  ],
                ),
              );
            }),
    );
  }

  Card EnvData({
    required BoxConstraints constraints,
    required String path,
    required String label,
    required double value,
    String? units,
  }) {
    String valueString = '';
    if (envBenefitsModel != null) {
      NumberFormat format = NumberFormat('#,###.##', 'en_US');
      valueString = format.format(value);
      if (units != null) {
        valueString = '$valueString $units';
      }
    }

    return Card(
      child: ListTile(
        leading: ShowImage(
          path: path,
        ),
        title: ShowText(label: label),
        subtitle: ShowText(
          label: envBenefitsModel == null ? '' : valueString,
          textStyle: Myconstant().h3Style(),
        ),
      ),
    );
  }
}
