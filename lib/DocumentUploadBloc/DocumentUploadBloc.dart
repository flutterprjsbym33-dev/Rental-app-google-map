import 'dart:io';

abstract class DocumentUploadBlocMainEvents{}
class ImagePickAndUploadEvent extends DocumentUploadBlocMainEvents{}
class ImagePickAndUploadCancelEvents extends DocumentUploadBlocMainEvents{}
class DocumentUploadEvent extends DocumentUploadBlocMainEvents{
  String title;
  String district;
  String fullAddress;
  String latitude;
  String longitude;
  String contactNo;
  String type;
  String description;
  List<File> files;

  DocumentUploadEvent({
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
class DocumentUploadCancelEvent extends DocumentUploadBlocMainEvents{}
