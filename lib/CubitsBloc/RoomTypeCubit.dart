import 'package:bloc/bloc.dart';

class RoomTypeCubit extends Cubit<String>
{
  RoomTypeCubit():super("Singleroom");

  void addType(String type)
  {
    emit(type);

  }

}