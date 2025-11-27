class UserDocumentMapper{
  String name;
  List<String> images;
  String uploadedAt;
  bool isLoading = false;

  UserDocumentMapper({
    required this.name,
    required this.images,
    required this.uploadedAt,
    required this.isLoading,

  });


}