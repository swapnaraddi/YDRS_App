import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/network/models/dictation/dictations_model.dart';
import 'package:YOURDRS_FlutterAPP/ui/patient_dictation/dictations_list.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/mic_button.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/raised_buttons.dart';
import 'package:flutter/material.dart';

class DictationType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    List<DictationItem> list = args['allDictation'];

    final Map args1 = ModalRoute.of(context).settings.arguments;
    List<DictationItem> list1 = args1['allPreDictation'];

    final Map args2 = ModalRoute.of(context).settings.arguments;
    List<DictationItem> list2 = args2['myPreDictation'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppStrings.textDictation),
          backgroundColor: CustomizedColors.appBarColor,
        ),
        body: Builder(
          builder: (context)=>Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// calling raised button class from the raised button widget folder
                    RaisedBtn1(
                      text: AppStrings.textDictation,
                      count: list.length,
                        onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DictationsList(),settings: RouteSettings(arguments: list)),
                        );
                      }
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// calling raised button class from the raised button widget folder
                    RaisedBtn1(
                      text: AppStrings.textAllDictation,
                      count: list1.length,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DictationsList(),settings: RouteSettings(arguments: list1)),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// calling raised button class from the raised button widget folder
                    RaisedBtn1(
                      text: AppStrings.textMyDictation,
                      count: list2.length,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DictationsList(),settings: RouteSettings(arguments: list2)),
                        );
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 40
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// calling the mic button widget from widget folder
                      MicButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}