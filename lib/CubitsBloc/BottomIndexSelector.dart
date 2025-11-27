import 'package:flutter_bloc/flutter_bloc.dart';

class BottomIndexSelector extends Cubit<int>
{
  BottomIndexSelector():super(0);

  void indexSelector(int index)
  {
    emit(index);
  }

}