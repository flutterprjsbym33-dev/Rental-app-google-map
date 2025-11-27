import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:goolemapuse/DocumentUploadBloc/DocumentUploadBloc.dart';
import 'package:goolemapuse/DocumentUploadBloc/DocumentUploadMainStates.dart';
import 'package:goolemapuse/auth/AuthMainServices.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DocumentUploadMainBloc extends Bloc<DocumentUploadBlocMainEvents,DocumentUploadMainStates>
{
  ImagePicker imagePicker = ImagePicker();

  DocumentUploadMainBloc():super(DocumentUploadInitialState())
  {
   // on(_imageUpload);
    on(cancelImageUplaod);
    on(_uploadAllDocumentBloc);

  }


  void _imageUpload(ImagePickAndUploadEvent event, Emitter<DocumentUploadMainStates> emit)async
  {

    try{
      List<String> urls = [];

      final xImages = await imagePicker.pickMultiImage();
      final test = File(xImages.first.path);
      print(test);

      if(xImages.isEmpty)
      {
        emit(DocumentUploadInitialState());
      }
      final file = File(xImages.first.path);
      emit(DocumentImagePickedFileState(image: file));
      for(var i in xImages)
      {
        final path = await File(i.path);
        final id = "${DateTime.now().microsecondsSinceEpoch}";

        await Supabase.instance.client.storage.from('images').upload(id, path);
        final url =Supabase.instance.client.storage.from("images").getPublicUrl(id);
        print(url);
        if(url.isNotEmpty)
        {
          urls.add(url);
        }


      }
      emit(ImageUploadSuccessState(imageUrls: urls));





    }catch(e){
      emit(ImageUploadErrorState(errorMsg: e.toString()));
      print("eroor $e");
    }


      }


      void cancelImageUplaod(DocumentUploadCancelEvent event , Emitter<DocumentUploadMainStates> emit)
      {
        emit(DocumentUploadInitialState());
      }


      void _uploadAllDocumentBloc(DocumentUploadEvent event ,Emitter<DocumentUploadMainStates> emit )async
      {
        try{
          emit(DocumentUploadLoadingState2());
          final phone = formatNumberForWhatsApp(event.contactNo);
          print("dcId:${Supabase.instance.client.auth.currentUser!.id}");
          List<String> images = [];
          for(var i in event.files)
            {
              final id = "${DateTime.now().microsecondsSinceEpoch}";
             await  Supabase.instance.client.storage.from('images').upload(id, i);
              final url =  await Supabase.instance.client.storage.from("images").getPublicUrl(id);
              images.add(url);
              print( "Image>>>>>>>>>>$url");

            }

          await Supabase.instance.client.from('images').insert({
            "id":authServices.value.currentUser!.uid,
            "uplodimg":images,
            "price":event.contactNo,
            "Latitude":event.latitude,
            "Longitude":event.longitude,
            "title":event.title,
            "address":event.fullAddress,
            "discription":event.description,
            "phone":phone,
            "type":event.type,


          });
          emit(DocumentUploadSuccessState2());


        }catch(e){
          emit(DocumentUploadErrorState(errorMsg: e.toString()));
        }
      }

  }

String formatNumberForWhatsApp(String raw)
{
  var digits = raw.replaceAll(RegExp(r'\D'), '');
  if(digits.startsWith('977')) return digits;

  if (digits.startsWith('0')) {
    digits = digits.substring(1);
  }

  if(digits.length==10 && (digits.startsWith('97')) || (digits.startsWith('98')))
  {
    return '977$digits';

  }
  return '977$digits';
}
