class ExternalAttachment {
  int id;
  int externalAttachmentId;
  int memberId ;
  int StatusId;
  bool uploadedToServer;
  int statusId;
  String createdDate;
  String displayFileName;
  String fileName; //name of the audio file
  String patientFirstName;
  String patientLastName;
  String patientDOB;
  String dos;
  String externalDocumentType;
  int practiceId;
  String practiceName;
  int locationId;
  String locationName;
  int providerId;
  String providerName;
  int appointmentTypeId;
  String appointmentType;
  bool isEmergencyAddOn;
  int externalDocumentTypeId;
  String description;

  ExternalAttachment({
      this.id,
      this.externalAttachmentId,
      this.memberId,
      this.StatusId,
      this.uploadedToServer,
      this.createdDate,
      this.displayFileName,
      this.fileName,
      this.patientFirstName,
      this.patientLastName,
      this.patientDOB,
      this.dos,
      this.externalDocumentType,
      this.practiceId,
      this.practiceName,
      this.locationId,
      this.locationName,
      this.providerId,
      this.providerName,
      this.appointmentTypeId,
      this.appointmentType,
      this.isEmergencyAddOn,
      this.externalDocumentTypeId,
      this.description});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'externalAttachmentId': externalAttachmentId,
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
      'practiceName':providerName,
      'locationId':locationId,
      'locationName':locationName,
      'providerId':providerId,
      'providerName':providerName,
      'appointmentTypeId':appointmentTypeId,
      'appointmentType':appointmentType,
      'isEmergencyAddOn':isEmergencyAddOn,
      'externalDocumentTypeId':externalDocumentTypeId,
      'description':description,
    };
    return map;
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
    practiceName = map['practiceName'];
    locationId = map['locationId'];
    locationName = map['locationName'];
    providerId = map['providerId'];
    providerName = map['providerName'];
    appointmentTypeId = map['appointmentTypeId'];
    appointmentType = map['appointmentType'];
    isEmergencyAddOn = map['isEmergencyAddOn'];
    externalDocumentTypeId = map['externalDocumentTypeId'];
    description = map['description'];
  }
}