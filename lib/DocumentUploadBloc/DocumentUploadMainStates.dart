import 'dart:io';

abstract class DocumentUploadMainStates{}
class DocumentUploadInitialState extends DocumentUploadMainStates{}
class DocumentImagePickedFileState extends DocumentUploadMainStates{
  File image;
  DocumentImagePickedFileState({required this.image});

}


class ImageUploadSuccessState extends DocumentUploadMainStates{
  List<String> imageUrls;
  ImageUploadSuccessState({required this.imageUrls});
}
class ImageUploadErrorState extends DocumentUploadMainStates{
  String errorMsg;
  ImageUploadErrorState({
    required this.errorMsg
});
}
class DocumentUploadLoadingState2 extends DocumentUploadMainStates{}

class DocumentUploadSuccessState2 extends DocumentUploadMainStates{}
class DocumentUploadErrorState extends DocumentUploadMainStates{
  String errorMsg;
  DocumentUploadErrorState({required this.errorMsg});
}