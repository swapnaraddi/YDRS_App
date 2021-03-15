import 'dart:io';

import 'package:YOURDRS_FlutterAPP/blocs/dictation_screen/audio_dictation_bloc.dart';
import 'package:YOURDRS_FlutterAPP/blocs/dictation_screen/audio_dictation_state.dart';
import 'package:YOURDRS_FlutterAPP/blocs/dictation_screen/audio_dictation_event.dart';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_constants.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/data/repo/local/db/db_helper.dart';
import 'package:YOURDRS_FlutterAPP/network/models/dictation/patient_dictation.dart';
import 'package:YOURDRS_FlutterAPP/network/models/schedule.dart';
import 'package:YOURDRS_FlutterAPP/ui/patient_dictation/random_waves.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AudioDictation extends StatefulWidget {

  final String patientFName,patientLName,patientDob, dictationTypeId, caseNum;

  const AudioDictation({Key key, this.patientFName, this.patientLName, this.patientDob, this.dictationTypeId, this.caseNum}) : super(key: key);

  @override
  _AudioDictationState createState() => _AudioDictationState();
}

class _AudioDictationState extends State<AudioDictation> {
  LocalFileSystem localFileSystem;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool viewVisible = true;

  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat(AppConstants.dateFormat);


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.localFileSystem = localFileSystem ?? LocalFileSystem();
    if (mounted) {
      /// bloc provider for init event
      BlocProvider.of<AudioDictationBloc>(context).add(InitRecord());
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: _body(),
        ),
      ),
    );
  }

  _body() {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<AudioDictationBloc, AudioDictationState>(
      listener: (context, state) {
        _currentStatus = state.currentStatus;
        _current = state.current;
        viewVisible = state.viewVisible;
        if (state.errorMsg != null && state.errorMsg.isNotEmpty) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMsg ?? 'Something went wrong')));
        }
      },
      child: BlocBuilder<AudioDictationBloc, AudioDictationState>(
        builder: (context, state) {
          return Center(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 30,
                    vertical: MediaQuery.of(context).size.height / 150
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${_printDuration(_current?.duration)}"),
                            FlatButton(
                                onPressed: () async {
                                  /// bloc provider for save record event
                                  BlocProvider.of<AudioDictationBloc>(context)
                                      .add(StopRecord());

                                  //call insert method
                                  _insertRecordsToDataBase();

                                  Fluttertoast.showToast(
                                      msg: "Recording Saved",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: CustomizedColors.toastColor,
                                      textColor: CustomizedColors.textColor,
                                      fontSize: 16.0
                                  );
                                },
                                child: Text(
                                  AppStrings.saveForLater,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomizedColors.saveLaterColor,
                                      fontSize: 18),
                                )
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: CustomizedColors.waveBGColor,
                              child: Visibility(
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: viewVisible,

                                  /// calling random wave class
                                  child: RandomWaves()
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width / 30,
                                  vertical: MediaQuery.of(context).size.height / 150
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  switch (_currentStatus) {
                                    case RecordingStatus.Initialized:
                                      {
                                        /// bloc provider for start record event
                                        BlocProvider.of<AudioDictationBloc>(
                                                context)
                                            .add(StartRecord());
                                        Fluttertoast.showToast(
                                            msg: "Recording Started",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: CustomizedColors.toastColor,
                                            textColor: CustomizedColors.textColor,
                                            fontSize: 16.0
                                        );
                                        break;
                                      }
                                    case RecordingStatus.Recording:
                                      {
                                        /// bloc provider for pause record event
                                        BlocProvider.of<AudioDictationBloc>(
                                                context)
                                            .add(PauseRecord());
                                        Fluttertoast.showToast(
                                            msg: "Recording Paused",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: CustomizedColors.toastColor,
                                            textColor: CustomizedColors.textColor,
                                            fontSize: 16.0
                                        );
                                        break;
                                      }
                                    case RecordingStatus.Paused:
                                      {
                                        /// bloc provider for resume record event
                                        BlocProvider.of<AudioDictationBloc>(
                                                context)
                                            .add(ResumeRecord());
                                        Fluttertoast.showToast(
                                            msg: "Recording Resumed",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: CustomizedColors.toastColor,
                                            textColor: CustomizedColors.textColor,
                                            fontSize: 16.0
                                        );
                                        break;
                                      }
                                    case RecordingStatus.Stopped:
                                      {
                                        /// bloc provider for init event
                                        BlocProvider.of<AudioDictationBloc>(
                                                context)
                                            .add(InitRecord());
                                        break;
                                      }
                                    default:
                                      break;
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: CustomizedColors.waveColor,
                                  child: _buildText(_currentStatus),
                                  radius: 25,
                                ),
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(0),
                                onPressed: () {
                                  /// Upload audio popup screen
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ListView(
                                          children: [
                                            Container(
                                              height: height * 0.38,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: MediaQuery.of(context).size.width / 30,
                                                  vertical: MediaQuery.of(context).size.height / 150
                                              ),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.cloud_upload,
                                                    size: 75,
                                                    color: CustomizedColors
                                                        .waveColor,
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.01,
                                                  ),
                                                  Text(
                                                    AppStrings.dict,
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.025,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            AppStrings.cancel,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: CustomizedColors
                                                                    .alertCancelColor),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: RaisedButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            AppStrings.upload,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: CustomizedColors
                                                                    .textColor),
                                                          ),
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.cloud_upload,
                                  size: 60,
                                  color: CustomizedColors.waveColor,
                                )
                            ),
                            CircleAvatar(
                              backgroundColor:
                                  CustomizedColors.circleAvatarBgColor,
                              child: GestureDetector(
                                child: Icon(
                                  Icons.delete,
                                  color: CustomizedColors.deleteIconColor,
                                  size: 45,
                                ),
                                onTap: () {
                                  /// bloc provider for delete record event
                                  BlocProvider.of<AudioDictationBloc>(context)
                                      .add(DeleteRecord());
                                  Fluttertoast.showToast(
                                      msg: "Recording Deleted",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: CustomizedColors.toastColor,
                                      textColor: CustomizedColors.textColor,
                                      fontSize: 16.0
                                  );
                                  print("Reset called");
                                },
                              ),
                              radius: 30,
                            ),
                          ],
                        ),
                      ]
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// setting timer format
  String _printDuration(Duration duration) {
    if (duration != null) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return '';
  }

  ///play pause button icons
  Widget _buildText(RecordingStatus status) {
    var icon;
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          icon = Icons.not_started;
          break;
        }
      case RecordingStatus.Recording:
        {
          icon = Icons.pause;
          break;
        }
      case RecordingStatus.Paused:
        {
          icon = Icons.play_arrow;
          break;
        }
      case RecordingStatus.Stopped:
        {
          icon = Icons.stop_outlined;
          break;
        }
      default:
        break;
    }
    return Icon(
      icon,
      color: CustomizedColors.textColor,
      size: 30,
    );
  }

   //Insert Dictation Data
  _insertRecordsToDataBase() async {
    try{
      final String formatted = formatter.format(now);
      print('_insertRecordsToDataBase caseNo ${widget.caseNum} formatted $formatted}');
      var audioFile = await File(_current.path).readAsBytes();
      DatabaseHelper.db.insertAudioRecords(PatientDictation(
        audioFile: audioFile,
        fileName:
            '${widget.dictationTypeId}_${widget.patientFName ?? "NA"}_${widget.caseNum ?? "NA"}_${formatted ?? 'NA'}.mp4',
        patientFirstName: widget.patientFName ?? 'NA',
        patientLastName: widget.patientLName ?? 'NA',
        dictationTypeId: widget.dictationTypeId ?? 'NA',
        patientDOB: widget.patientDob ?? 'NA',
        createdDate: '${DateTime.now()}' ?? 'NA',
      ));
    } catch (e){
      print('_insertRecordsToDataBase ${e.toString()}');
    }

  }
}
