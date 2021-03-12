import 'dart:io';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_log_helper.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/network/models/dictation/dictations_model.dart';
import 'package:YOURDRS_FlutterAPP/network/models/schedule.dart';
import 'package:YOURDRS_FlutterAPP/network/services/dictation/dictation_services.dart';
import 'package:YOURDRS_FlutterAPP/ui/home/view_images.dart';
import 'package:YOURDRS_FlutterAPP/ui/patient_dictation/dictation_type.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/material_buttons.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/mic_button.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/raised_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PatientDetail extends StatefulWidget {
  @override
  // final List<Patient> todos;

  // PatientDetail({Key key, @required this.todos}) : super(key: key);
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  List allDtion = List();
  List allPrevDtion = List();
  List myPrevDtion = List();

  AllDtion() async {
    AllDictationService apiServices1 = AllDictationService();
    Dictations allDictations = await apiServices1.getDictations();
    // print('allDictations--> $allDictations');
    allDtion = allDictations.audioDictations;
  }

  AllPrevDtion() async {
    AllPreviousDictationService apiServices2 = AllPreviousDictationService();
    Dictations allPreviousDictations =
        await apiServices2.getAllPreviousDictations();
    allPrevDtion = allPreviousDictations.audioDictations;
  }

  MyPrevDtion() async {
    MyPreviousDictationService apiServices3 = MyPreviousDictationService();
    Dictations myPreviousDictations =
        await apiServices3.getMyPreviousDictations();
    myPrevDtion = myPreviousDictations.audioDictations;
  }

  // Map arguments = Map();
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   arguments = ModalRoute.of(context).settings.arguments;
  // }

  bool widgetVisible = false;
  bool visible = false;
  Directory directory;
  bool isSwitched = false;
  File newImage, image;
  int gIndex;
  String fileName;
  String filepath;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  FileType fileType;
  bool imageVisible = true;
  var imageName;
  List imageArray = new List();
  ScheduleList list;

  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat(AppStrings.dateFormat);

  //function to open camera
  Future openCamera() async {
    image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    String path = image.path;
    createFileName(path);
    setState(() {
      // imageArray.add(image);
      image;
      widgetVisible = true;
      visible = false;
    });
  }

  //function to open gallery
  Future openGallery() async {
    setState(() => isLoadingPath = true);
    try {
      if (!isMultiPick) {
        filepath = null;
        paths = await FilePicker.getMultiFilePath(
            type: fileType != null ? fileType : FileType.image,
            allowedExtensions: extensions);
        print(paths.toString());
      } else {
        filepath = await FilePicker.getFilePath(
            type: fileType != null ? fileType : FileType.image,
            allowedExtensions: extensions);
        print(filepath);
        paths = null;
      }
    } on PlatformException catch (e) {
      print(AppStrings.filePathNotFound + e.toString());
    }
    try {
      if (!mounted) return;
      setState(() {
        isLoadingPath = false;
        fileName = filepath != null
            ? filepath.split('/').last
            : paths != null
                ? paths.keys.toString()
                : '...';
        visible = true;
        widgetVisible = false;
      });
    } on PlatformException catch (e) {
      print(AppStrings.filePathNotFound + e.toString());
    }
  }

  //custom file name
  Future<String> createFileName(String mockName) async {
    final String formatted = formatter.format(now);
    try {
      imageName = '' + basename(mockName).replaceAll(".", "");
      if (imageName.length > 10) {
        imageName = imageName.substring(0, 10);

        final Directory directory = await getExternalStorageDirectory();
        String path = '${directory.path}/${AppStrings.folderName}';
        final myImgDir = await Directory(path).create(recursive: true);
        newImage = await File(image.path).copy(
            '${myImgDir.path}/${basename(imageName + '${formatted}' + AppStrings.imageFormat)}');
        setState(() {
          newImage;
          print(path);
        });
      }
    } catch (e, s) {
      imageName = "";
      AppLogHelper.printLogs(e, s);
    }

    print("${formatted}" + imageName + ".jpeg");
    return "${formatted}" + imageName + ".jpeg";
  }

  //function for switch button
  void toggleSwitch(bool value) {
    try {
      if (isSwitched == false) {
        setState(() {
          isSwitched = true;
        });
      } else {
        setState(() {
          isSwitched = false;
        });
      }
    } on PlatformException catch (e) {
      throw (e);
    }
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final ScheduleList item = ModalRoute.of(context).settings.arguments;
    print(item);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "",
          style: TextStyle(color: CustomizedColors.textColor, fontSize: 14.0),
        ),
        backgroundColor: CustomizedColors.primaryColor,
        elevation: 0.2,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          CustomizedColors.primaryColor,
          CustomizedColors.primaryColor,
          CustomizedColors.primaryColor,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
              child: Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Hero(
                      transitionOnUserGestures: true,
                      tag: item,
                      child: Transform.scale(
                        scale: 2.0,
                        child: CircleAvatar(
                          radius: 18,
                          child: ClipOval(
                            child: Image.network(
                                "https://image.freepik.com/free-vector/doctor-icon-avatar-white_136162-58.jpg"),
                          ),
                        ),
                      ),
                    ),
                    title: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.patient?.displayName ?? "",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Row(
                              children: [
                                Text(
                                  item.patient?.sex ?? "",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                Text(",",
                                    style: TextStyle(color: Colors.white)),
                                Text(
                                  item.patient?.age.toString() + "year old" ??
                                      "",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                            Text(
                              item.accidentDate ?? "",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.dateOfbirth + ":" + item.patient?.dob ??
                                "",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            AppStrings.caseNo +
                                    ":" +
                                    item.patient?.accountNumber ??
                                "",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            AppStrings.dos + ":" + item.patient?.dob ?? "",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Button for mic
                            MicButton(patientName: item.patient.displayName,caseNumber: item.patient.accountNumber,patientDob: item.patient.dob,dictationTypeId: item.dictationTypeId),
                            //
                            //Button for camera
                            MaterialButtons(
                                onPressed: () {
                                  // CupertinoActionSheet for camera and gallery
                                  cupertinoActionSheet(context);
                                },
                                iconData: Icons.camera_alt)
                          ],
                        ),

                        //view camera image
                        Visibility(
                          visible: widgetVisible,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Wrap(children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: CustomizedColors
                                              .homeSubtitleColor,
                                        ),
                                      ),
                                      height: 100,
                                      child: Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Stack(children: [
                                            image == null
                                                ? Text(
                                                    AppStrings.noImageSelected)
                                                : Image.file(
                                                    image,
                                                    fit: BoxFit.contain,
                                                  ),
                                            Positioned(
                                              right: -10,
                                              top: -5,
                                              child: Visibility(
                                                visible: imageVisible,
                                                child: IconButton(
                                                  icon: new Icon(
                                                    Icons.close,
                                                    color: CustomizedColors
                                                        .signInButtonTextColor,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      image = null;
                                                      imageVisible = false;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]))),
                                ]),
                                SizedBox(
                                  height: 10,
                                ),

                                //storing images into separate folder
                                RaisedBtn(
                                    text: AppStrings.submitImages,
                                    onPressed: () {},
                                    iconData: Icons.image),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //view gallery images
                        Visibility(
                            visible: visible,
                            child: Column(children: [
                              Builder(
                                builder: (BuildContext context) => isLoadingPath
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child:
                                            const CircularProgressIndicator())
                                    : filepath != null ||
                                            (paths != null &&
                                                paths.values != null &&
                                                paths.values.isNotEmpty)
                                        ? new Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: CustomizedColors
                                                    .homeSubtitleColor,
                                              ),
                                            ),
                                            //   padding: const EdgeInsets.only(bottom: 30.0),
                                            height: 100,
                                            child: new ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: paths != null &&
                                                      paths.isNotEmpty
                                                  ? paths.length
                                                  : 1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                final bool isMultiPath =
                                                    paths != null &&
                                                        paths.isNotEmpty;
                                                final filePath1 = isMultiPath
                                                    ? paths.values
                                                        .toList()[index]
                                                        .toString()
                                                    : filepath;
                                                print(filePath1);
                                                return Container(
                                                  color: CustomizedColors
                                                      .homeSubtitleColor,
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  child: Stack(children: [
                                                    filePath1 != null
                                                        ? Image.file(
                                                            File(filePath1),
                                                            fit: BoxFit.contain,
                                                          )
                                                        : Container(),
                                                    Positioned(
                                                      right: -10,
                                                      top: -5,
                                                      child: IconButton(
                                                        icon: new Icon(
                                                          Icons.close,
                                                          color: CustomizedColors
                                                              .signInButtonTextColor,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            // paths.values.toList().removeAt(index);
                                                            imageName =
                                                                basename(paths
                                                                        .values
                                                                        .toList()[
                                                                    index]);
                                                            print(
                                                                'remove filename $fileName');
                                                            paths.remove(
                                                                imageName);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ]),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      new Divider(),
                                            ),
                                          )
                                        : new Container(
                                            child: Text(
                                                AppStrings.noImageSelected),
                                          ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RaisedBtn(
                                  text: AppStrings.submitImages,
                                  onPressed: () async {
                                    //final String formatted = formatter.format(now);
                                    final Directory directory =
                                        await getExternalStorageDirectory();
                                    String path =
                                        '${directory.path}/${AppStrings.folderName}';
                                    final myImgDir = await Directory(path)
                                        .create(recursive: true);
                                    File imaegFile = await File(fileName)
                                        .copy('${myImgDir.path}/${fileName}');
                                    print(path);
                                    Log.e("ImagePath", paths.keys.toList());
                                    setState(() {
                                      widgetVisible = false;
                                      visible = false;
                                    });
                                  },
                                  iconData: Icons.image),
                            ])),
                        SizedBox(
                          height: 15,
                        ),

                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RaisedBtn(
                                  text: AppStrings.superBill,
                                  onPressed: () {},
                                  iconData: Icons.description_outlined),
                              SizedBox(
                                height: 15,
                              ),
                              RaisedBtn(
                                  text: AppStrings.allDictations,
                                  onPressed: () async {
                                    await AllDtion();
                                    await AllPrevDtion();
                                    await MyPrevDtion();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DictationType(),
                                          settings: RouteSettings(arguments: {
                                            'allDictation': allDtion,
                                            'allPreDictation': allPrevDtion,
                                            'myPreDictation': myPrevDtion
                                          })),
                                    );
                                  },
                                  iconData: Icons.mic_rounded),
                              SizedBox(
                                height: 15,
                              ),
                              RaisedBtn(
                                  text: AppStrings.images,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewImages()));
                                  },
                                  iconData: Icons.camera_alt),
                            ]),

                        SizedBox(
                          height: 15,
                        ),
                        Row()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cupertinoActionSheet(BuildContext context) {
    final action = CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.camera),
            ],
          ),
          onPressed: () {
            openCamera();
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.PhotoGallery),
            ],
          ),
          onPressed: () {
            openGallery();
            Navigator.pop(context);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(AppStrings.cancel),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );

    showCupertinoModalPopup(context: context, builder: (context) => action);
  }
}
