import 'dart:io';

abstract class DocumentUploadMainEvents2{}
class UploadImageEvent extends DocumentUploadMainEvents2{}
class DocumentUpload2Event extends DocumentUploadMainEvents2{

}


class UploadDocumentEvent2 extends DocumentUploadMainEvents2{

  String title;
  String district;
  String fullAddress;
  String latitude;
  String longitude;
  String contactNo;
  String type;
  String description;
  List<File> files;

  UploadDocumentEvent2({
    required this.title,
    required this.district,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.description,
    required this.contactNo,
    required this.files,
});

}

class CancelPhotoUpload extends DocumentUploadMainEvents2{}
class deleateDocs extends DocumentUploadMainEvents2{

}