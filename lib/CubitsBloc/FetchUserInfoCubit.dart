import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goolemapuse/CubitsBloc/FetchUserState.dart';
import 'package:goolemapuse/appConst/AppConstant.dart';
import 'package:goolemapuse/auth/AuthMainServices.dart';
import 'package:intl/intl.dart';

class FetchUserInfoCubit extends Cubit<FetchUserState>
{
  FetchUserInfoCubit():super(FetchUserState(name: "", image: "", joined_date: "", isLoading: false, email: "", isEmpty: true));

  Future<void> fetchUserDetails()async
  {
    emit(FetchUserState(name: "", image: "", joined_date: '', isLoading: true, email: "", isEmpty: false));
    final data =  await FirebaseFirestore.instance.collection("users").doc(authServices.value.currentUser!.uid).get();
    final userData = data.data();
    if(userData!=null)
      {
        print("USERDATA $userData");
        emit(FetchUserState(name: "", image: "", joined_date: '', isLoading: true, email: "", isEmpty: false));

        final name = userData['fullname'];
        AppConstant.userName = name;

        final email = userData['email'];
        final image = userData['photo'];
        AppConstant.imageUrl = image;

        print("IMAGE??????????????? $image");
        final Timestamp joined = userData['created_at'];
        final joinedAt = joined.toDate();
        final actualDate = DateFormat("MMM d, yyyy").format(joinedAt);
        emit(FetchUserState(name: name, image: image, joined_date: actualDate, isLoading: false, email: email, isEmpty: false));

      }


  }

}