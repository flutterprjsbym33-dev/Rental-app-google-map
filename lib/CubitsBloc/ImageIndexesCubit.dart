import 'package:bloc/bloc.dart';

class ImageIndexesCubit extends Cubit<int>
{
  ImageIndexesCubit():super(0);
  void addIndex(int index)
  {
    emit(index);
  }
}