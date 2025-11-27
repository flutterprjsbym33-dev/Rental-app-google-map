import 'package:bloc/bloc.dart';

class CategorySelector extends Cubit<int>
{
  CategorySelector():super(0);

  void addIndex(int index)
  {
    emit(index);
  }

}