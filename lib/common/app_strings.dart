import 'package:YOURDRS_FlutterAPP/common/app_constants.dart';

class AppStrings {
  static const welcome = 'Welcome';
  static const signIn = "Signin";
  static const tryAgain = "tryAgain";
  static const notNow = "notNow";
  static const dictationJson = "assets/json/appointment.json";

  //added by team3
  static const submitImages = "Submit Images";
  static const dateFormat = "MMddyyyy";
  static const folderName = "YourDrsImages";
  static const noImageSelected = "No image Selected";
  static const filePathNotFound = "File path not found";
  static const imageFormat = ".jpeg";
  static const superBill = " Super Bill";
  static const allDictations = "All Dictations";
  static const images = " Images";
  static const camera = "Camera";
  static const PhotoGallery = "Photo Gallery";
  static const cancel = "Cancel";
  static const dateOfbirth = "DOB";
  static const caseNo = "Case No";
  static const PT = "PT";
  static const dos = "DOS";
  static const dbTableExternalDictation = 'External_Table';


  //Database table
  static const databaseName =  'ydrslocaldb';
  static const dbTableDictation = "dictationlocal";
  static const dbTableExternalAttachment = 'externalattachmentlocal';
  static const dbTablePhotoList = 'photolistlocal';

  //Patient dictation and Manual dictation columns
  static const colId = 'id';
  // static const col_AudioFile = 'col_audioFile';
  static const col_dictationId = 'dictationid';
  static const col_AudioFileName = 'fileName';
  static const col_PatientFname = 'patientfirstname';
  static const col_PatientLname = 'patientlastname';
  static const col_CreatedDate = 'createddate';
  static const col_Patient_DOB = 'patientdob';
  static const col_DictationTypeId = 'dictationtypeid';
  static const col_EpisodeId = 'episodeid';
  static const col_AppointmentId = 'appointmentid';
  static const col_AttachmentName = 'attachmentname';
  static const col_attachmentSizeBytes = 'attachmentsizebytes';
  static const col_attachmentType = 'attachmenttype';
  static const col_MemberId = 'memberid';
  static const col_StatusId = 'statusid';
  static const col_UploadedToServer = 'uploadedtoserver';
  static const col_DisplayFileName = 'displayfilename';
  static const col_PhysicalFileName = 'physicalfilename';
  static const col_DOS = 'dos';
  static const col_PracticeId = 'practiceid';
  static const col_PracticeName = 'practicename';
  static const col_LocationId = 'locationid';
  static const col_LocationName = 'locationname';
  static const col_ProviderId = 'providerid';
  static const col_ProviderName = 'providername';
  static const col_AppointmentTypeId = 'appointmenttypeid';
  static const col_PhotoNameList = 'photoNameList';
  static const col_isEmergencyAddOn = 'isemergencyaddon';
  static const col_ExternalDocumentTypeId = 'externaldocumenttypeid';
  static const col_Description = 'description';
  static const col_AppointmentProvider = 'appointmentprovider';
  static const col_isSelected = 'isselected';

  //External attachment columns
  static const col_External_Id = 'id';
  static const col_ExternalAttachmentId = 'externalattachmentid';
  static const col_ExternalPatientFname = 'patientfirstname';
  static const col_ExternalPatientLname = 'patientlastname';
  static const col_ExternalCreatedDate = 'createddate';
  static const col_ExternalPatient_DOB = 'patientdob';
  static const col_ExternalAppointmentType = 'appointmenttype';
  static const col_ExternalMemberId = 'memberid';
  static const col_ExternalStatusId = 'statusid';
  static const col_ExternalUploadedToServer = 'uploadedtoserver';
  static const col_ExternalDisplayFileName = 'displayfilename';
  static const col_ExternalDOS = 'dos';
  static const col_ExternalFileName = 'filename';
  static const col_ExternalPracticeId = 'practiceid';
  static const col_ExternalPracticeName = 'practicename';
  static const col_ExternalLocationId = 'locationid';
  static const col_ExternalLocationName = 'locationname';
  static const col_ExternalProviderId = 'providerid';
  static const col_ExternalProviderName = 'providername ';
  static const col_ExternalAppointmentTypeId = 'appointmenttypeid';
  static const col_ExternalDocumentType = 'externaldocumenttype';
  static const col_ExternalisEmergencyAddOn = 'isemergencyaddon';
  static const col_Ex_ExternalDocumentTypeId = 'externaldocumenttypeid';
  static const col_ExternalDes= 'description';


  //photo list table columns
  static const col_PhotoList_Id = 'id';
  static const col_PhotoListDictationId = 'dictationlocalid';
  static const col_PhotoListExternalAttachmentId= 'externalattachmentlocalid';
  static const col_PhotoListAttachmentName = 'attachmentname';
  static const col_PhotoListAttachmentSizeBytes = 'attachmentsizebytes';
  static const col_PhotoListAttachmentAttachmentType = 'attachmenttype';
  static const col_PhotoListAttachmentFileName = 'fileName';
  static const col_PhotoListAttachmentPhysicalFileName = 'physicalfilename';
  static const col_PhotoListAttachmentCreatedDate = 'createddate';


  //Queries
  static const deleteOlderFiles = "DELETE FROM Audio_Table WHERE date(createdDate) < date('now')";
  static const selectQuery = "SELECT * FROM Audio_Table";

  static const deleteFiles = "DELETE Audio_Table.id, Audio_Table.createddate,"
      "date(Audio_Table.createddate) dt, date('now') FROM 'Audio_Table' where date(Audio_Table.createddate) < date('now')";



  //Table for Patient Dictation and Manual Dictation
  static const tableDictation = 'CREATE TABLE dictationlocal('
      'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
      'dictationid INT,'
  // 'col_audioFile BLOB,'
      'fileName TEXT DEFAULT NULL,'
      'patientfirstname TEXT DEFAULT NULL,'
      'patientlastname TEXT DEFAULT NULL,'
      'patientdob TEXT DEFAULT NULL,'
      'dictationtypeid INT DEFAULT NULL,'
      'createddate DATETIME DEFAULT CURRENT_TIMESTAMP,'
      'episodeid INT DEFAULT NULL,'
      'appointmentid INT DEFAULT NULL,'
      'attachmentname TEXT DEFAULT NULL,'
      'attachmentsizebytes INT DEFAULT NULL,'
      'attachmenttype TEXT DEFAULT NULL,'
      'memberid INT DEFAULT NULL,'
      'statusid INT DEFAULT NULL,'
      'uploadedtoserver NUMERIC DEFAULT 0,'
      'displayfilename TEXT DEFAULT NULL,'
      'physicalfilename TEXT DEFAULT NULL,'
      'dos DATETIME DEFAULT NULL,'
      'practiceid INT DEFAULT NULL,'
      'practicename TEXT DEFAULT NULL,'
      'locationid INT DEFAULT NULL,'
      'locationname TEXT DEFAULT NULL,'
      'providerid INT DEFAULT NULL,'
      'providername TEXT DEFAULT NULL,'
      'appointmenttypeid INT DEFAULT NULL,'
      'photoNameList DEFAULT NULL,'
      'isemergencyaddon NUMERIC DEFAULT 0,'
      'externaldocumenttypeid INT DEFAULT NULL,'
      'description TEXT DEFAULT NULL,'
      'appointmentprovider TEXT DEFAULT NULL,'
      'isselected NUMERIC DEFAULT 0'
      ')';

  //Table for External Dictation
  static const tableExternalAttachment = 'CREATE TABLE externalattachmentlocal ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
      'externalattachmentid INT DEFAULT NULL,'
      'filename TEXT DEFAULT NULL,'
      'patientfirstname TEXT DEFAULT NULL,'
      'patientlastname TEXT DEFAULT NULL,'
      'patientdob DATETIME DEFAULT NULL,'
      'memberid INT DEFAULT NULL,'
      'statusid INT DEFAULT NULL,'
      'uploadedtoserver NUMERIC DEFAULT 0,'
      'createddate DATETIME DEFAULT CURRENT_TIMESTAMP,'
      'displayfilename TEXT DEFAULT NULL,'
      'dos DATETIME DEFAULT NULL,'
      'practiceid INT DEFAULT NULL,'
      'practicename TEXT DEFAULT NULL,'
      'locationid INT DEFAULT NULL,'
      'locationname TEXT DEFAULT NULL,'
      'providerid INT DEFAULT NULL,'
      'providername TEXT DEFAULT NULL,'
      'appointmenttypeid INT DEFAULT NULL,'
      'appointmenttype TEXT DEFAULT NULL,'
      'col_photoNameList,'
      'externaldocumenttype TEXT DEFAULT NULL,'
      'isemergencyaddon NUMERIC DEFAULT 0,'
      'externaldocumenttypeid INTEGER DEFAULT NULL,'
      'description TEXT DEFAULT NULL'
      ')';


  static const tblPhotoList = 'CREATE TABLE photolistlocal ('
      'id INTEGER PRIMARY KEY,'
      'dictationlocalid INTEGER DEFAULT NULL,'
      'externalattachmentlocalid INTEGER DEFAULT NULL,'
      'attachmentname TEXT DEFAULT NULL,'
      'attachmentsizebytes INTEGER DEFAULT NULL,'
      'attachmenttype TEXT DEFAULT NULL,'
      'fileName TEXT DEFAULT NULL,'
      'physicalfilename TEXT DEFAULT NULL,'
      'createddate DATETIME DEFAULT NULL'
      ')';

  //Dictation type list
  static const dictationTypeList = [
    "MR",
    "NBR",
    "OPR",
  ];

  // Team 4 strings
  static const saveForLater= "Save for Later";
  static const dict= "Upload this dictation for transcription?";
  static const upload = "Upload";
  static const startFile = "Start file";
  static const dictType = "Select dictation type";
  static const photoLib = "Photo Library";
  static const dictationType= "Dictation type";
  static const patientNameAppBar = "Kevin Peterson";

  //Dictations
  static const textDictation = "Dictations";
  static const textMyDictation = "My Previous Dictations";
  static const textAllDictation = "All Previous Dictations";
  static const textUploaded = "Uploaded";

}

class ApiUrlConstants {
  // for getting Locations//
  static const getLocation =
      AppConstants.dioBaseUrl + "api/Schedule/GetMemberLocations";
  // for getting Provider
  static const getProviders =
      AppConstants.dioBaseUrl + "api/Schedule/GetAssociatedProvider";
  //for getting Schedules
  static const getSchedules =
      AppConstants.dioBaseUrl + "api/Schedule/GetSchedules";

  // to get all dictations
  static const dictations = AppConstants.dioBaseUrl + "api/Dictation/GetAllDictations";
  // to get all previous dictations
  static const allPreviousDictations = AppConstants.dioBaseUrl + "api/Dictation/GetPreviousDictations";
  // to get my previous dictations
  static const myPreviousDictations = AppConstants.dioBaseUrl + "api/Dictation/GetMyPreviousDictations";
}
