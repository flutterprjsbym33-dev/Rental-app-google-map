import 'package:goolemapuse/CubitsBloc/DocumentFetchMapperClass.dart';

class DocumentFetchedState
{
  bool isLoading = true;
  List<DocumentFetchMapperClass> lists;
  List<DocumentFetchMapperClass> singleRoom;
  List<DocumentFetchMapperClass> houses;
  List<DocumentFetchMapperClass> flat;
  List<DocumentFetchMapperClass> apartment;
  List<DocumentFetchMapperClass> emptyLand;


  String? err;


  DocumentFetchedState({
    required this.lists ,
    required this.isLoading,
     required this.apartment,
    required this.flat,
    required this.houses,
    required this.singleRoom,
    required this.emptyLand,
    this.err



});
}