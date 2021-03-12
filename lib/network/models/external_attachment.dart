class ExternalAttachment {
  int id;
  //int externalAttachmentId;
  int memberId ;
  int StatusId;
  bool uploadedToServer;
  int statusId;
  String createdDate;
  String displayFileName;
  String photoNameList;
  String fileName; //name of the audio file
  String patientFirstName;
  String patientLastName;
  String patientDOB;
  String dos;
 // String externalDocumentTypeName;
  int practiceId;
  int locationId;
  int providerId;
  int appointmentTypeId;
  bool isEmergencyAddOn;
  int externalDocumentTypeId;
  String description;

  ExternalAttachment({
    this.id,
   // this.externalAttachmentId,
    this.memberId,
    this.StatusId,
    this.uploadedToServer,
    this.createdDate,
    this.displayFileName,
    this.photoNameList,
    this.fileName,
    this.patientFirstName,
    this.patientLastName,
    this.patientDOB,
    this.dos,
   //this.externalDocumentTypeName,
    this.practiceId,
    this.locationId,
    this.providerId,
    this.appointmentTypeId,
    this.isEmergencyAddOn,
    this.externalDocumentTypeId,
    this.description});

  Map<String, String> toMap() {
    var map = <String, dynamic>{
      'id': id,
    //  'externalAttachmentId': externalAttachmentId,
      'memberId':memberId,
      'statusId':statusId,
      'uploadedToServer':uploadedToServer,
      'createdDate':createdDate,
      'displayFileName':displayFileName,
      'fileName':fileName,
      'patientFirstName':patientFirstName,
      'patientLastName':patientLastName,
      'patientDOB':patientDOB,
      'DOS':dos,
      'practiceId':practiceId,
      'locationId':locationId,
      'providerId':providerId,
      'appointmentTypeId':appointmentTypeId,
      'photoNameList':photoNameList,
      'isEmergencyAddOn':isEmergencyAddOn,
      'externalDocumentTypeId':externalDocumentTypeId,
      'description':description,
    };
    return map;
  }

  ExternalAttachment.map(dynamic obj) {
    this.id=obj['id'];
   // this.externalAttachmentId=obj['externalAttachmentId'];
    this.memberId=obj['memberId'];
    this.StatusId=obj['statusId'];
    this.uploadedToServer=obj['uploadedToServer'];
    this.createdDate=obj['createdDate'];
    this.displayFileName=obj['displayFileName'];
    this.photoNameList=obj['photoNameList'];
    this.fileName=obj['fileName'];
    this.patientFirstName=obj['patientFirstName'];
    this.patientLastName=obj['patientLastName'];
    this.patientDOB=obj['patientDOB'];
    this.dos=obj['DOS'];
  //  this.externalDocumentTypeName=obj['id'];
    this.practiceId=obj['practiceId'];
    this.locationId=obj['locationId'];
    this.providerId=obj['providerId'];
    this.appointmentTypeId=obj['appointmentTypeId'];
    this.isEmergencyAddOn=obj['isEmergencyAddOn'];
    this.externalDocumentTypeId=obj['externalDocumentTypeId'];
    this.description=obj['description'];
  }


  ExternalAttachment.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    memberId = map['memberId'];
    statusId = map['statusId'];
    uploadedToServer = map['uploadedToServer'];
    createdDate = map['createdDate'];
    displayFileName = map['displayFileName'];
    fileName = map['fileName'];
    patientFirstName = map['patientFirstName'];
    patientLastName = map['patientLastName'];
    patientDOB = map['patientDOB'];
    dos = map['DOS'];
    practiceId = map['practiceId'];
    locationId = map['locationId'];
    providerId = map['providerId'];
    appointmentTypeId = map['appointmentTypeId'];
    photoNameList = map['photoNameList'];
    isEmergencyAddOn = map['isEmergencyAddOn'];
    externalDocumentTypeId = map['externalDocumentTypeId'];
    description = map['description'];
  }
}