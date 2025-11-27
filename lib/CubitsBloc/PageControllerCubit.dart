import 'package:bloc/bloc.dart';

class PageIndicatorCubit extends Cubit<Set<String>> {
  PageIndicatorCubit() : super({});

  void toggleFav(String id)
  {
    final current = Set<String>.from(state);
    if(current.contains(id))
      {
        current.remove(id);
      }
    else{
      current.add(id);
    }
    emit(current);

  }
}
