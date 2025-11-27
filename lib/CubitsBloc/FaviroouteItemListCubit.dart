import 'package:bloc/bloc.dart';
import 'package:goolemapuse/CubitsBloc/DocumentFetchMapperClass.dart';

class FaviroouteItemListCubit extends Cubit<List<DocumentFetchMapperClass>>
{
  FaviroouteItemListCubit():super([]);

  void addItem(DocumentFetchMapperClass item)
  {
    final List<DocumentFetchMapperClass> updatedItems = List.from(state);
    updatedItems.contains(item) ? updatedItems.remove(item) :
    updatedItems.add(item);
    emit(updatedItems);
  }

}