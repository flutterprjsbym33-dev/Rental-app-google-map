import 'dart:io';

abstract class DocumentUploadMainState2{}
class DocumentUploadInitialState extends DocumentUploadMainState2{}
class ImagePickedInitialState extends DocumentUploadMainState2{}
class ImagePickedLoadingState extends DocumentUploadMainState2{}
class ImagePickedSuccessState extends DocumentUploadMainState2{
  List<File> images;
  ImagePickedSuccessState({required this.images});

}
class ImagePickedErrorState extends DocumentUploadMainState2{
  String errMsg;
  ImagePickedErrorState({required this.errMsg});
}
class DocumentUploadLoadingState extends DocumentUploadMainState2{}
class DocumentUploadSuccessState extends DocumentUploadMainState2{}
class DocumentUploadErrorState extends DocumentUploadMainState2{
  String errMsg;
  DocumentUploadErrorState({required this.errMsg});
}

class DocumentUploadSuccessState3 extends DocumentUploadMainState2{}

class DocumentUploadLoadingState3 extends DocumentUploadMainState2{}

class DocumentUploadErrorState3 extends DocumentUploadMainState2{
  String errMsg;
  DocumentUploadErrorState3({required this.errMsg});

}

class DeleateDocsLoadingStae extends DocumentUploadMainState2{}
class DeleateDocsSuccessStae extends DocumentUploadMainState2{}
class DeleateDocserrorStae extends DocumentUploadMainState2{}

