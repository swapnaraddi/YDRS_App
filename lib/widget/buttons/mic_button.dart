import 'package:YOURDRS_FlutterAPP/blocs/dictation_screen/audio_dictation_bloc.dart';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/ui/patient_dictation/audio_dictation.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/dropdowns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MicButton extends StatefulWidget {
  final String patientName;
  final String caseNumber;
  final String patientDob;
  final int dictationTypeId;

  const MicButton({Key key, this.patientName, this.caseNumber, this.patientDob, this.dictationTypeId}) : super(key: key);

  @override
  _MicButtonState createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  var _currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FlatButton(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 100
      ),
      onPressed: () {
        Alert(
          context: context,
          title:"Select Dictation Type.",
          content:  Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 10
              ),
              color: CustomizedColors.alertColor,
              height: height * 0.09,
              width: width * 0.65,
              child: FormField<String>(
                builder: (FormFieldState<String> state) {

                  /// calling the drop down button widget from widget folder
                  return DropDownDictationType(
                    value: _currentSelectedValue,
                    hint: "Dictation Type",
                    onChanged: (String newValue) {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: height * 0.50,
                            child: BlocProvider<AudioDictationBloc>(
                              create: (context) => AudioDictationBloc(),
                              /// calling the audio dictation class from ui folder
                              child: AudioDictation(patientFName: widget.patientName,patientLName: widget.patientName, patientDob: widget.patientDob),
                            ),
                          );
                          },
                      );
                      setState(() {
                        _currentSelectedValue = newValue;
                        state.didChange(newValue);
                      });
                      },
                    items: AppStrings.dictationTypeList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                  },
              )
          ),
          buttons: [
            DialogButton(
              color: CustomizedColors.alertCancelColor,
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: CustomizedColors.textColor,
                    fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: CustomizedColors.circleAvatarColor,
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.mic,
          color: CustomizedColors.micIconColor,
          size: 40,
        ),
      ),
    );
  }
}
