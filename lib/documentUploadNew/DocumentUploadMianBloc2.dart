import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:goolemapuse/documentUploadNew/DocumentUploadMainEvents.dart';
import 'package:goolemapuse/documentUploadNew/DocumentUploadMainState.dart';
import 'package:image_picker/image_picker.dart';

import '../DocumentUploadBloc/DocumentUploadMainBloc.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/AuthMainServices.dart';


class DocumentUploadMainBloc2 extends Bloc<DocumentUploadMainEvents2,DocumentUploadMainState2>
{
  DocumentUploadMainBloc2():super(DocumentUploadInitialState()){
    on(selectImages);
    on(_uploadDocs);
    on(cancelImageUpload);
    on(deleteDocs);
  }


  void selectImages(UploadImageEvent event,Emitter<DocumentUploadMainState2> emit)async
  {

    final imagePicker =  ImagePicker();
    final xFiles = await imagePicker.pickMultiImage();
    if(xFiles.isEmpty)
    {
      emit(ImagePickedErrorState(errMsg: 'Error While Selecting Images'));
    }
    List<File> files = [];
    for(var i in xFiles)
      {
        final File  file = File(i.path);
        files.add(file);

      }
    emit(ImagePickedSuccessState(images: files));


  }


  void _uploadDocs(UploadDocumentEvent2 event,Emitter<DocumentUploadMainState2> emit)async
  {


    try{
      emit(DocumentUploadLoadingState3());

     final existDocs = await Supabase.instance.client.from('images').select().eq("id", authServices.value.currentUser!.uid);
     if(existDocs.isNotEmpty)
       {
         emit(DocumentUploadErrorState3(errMsg:"Document Already Exist"));

         return;

       }
      final phone = formatNumberForWhatsApp(event.contactNo);

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
      emit(DocumentUploadSuccessState3());
      emit(DocumentUploadSuccessState3());


    }catch(e){
      emit(DocumentUploadErrorState3(errMsg: e.toString()));
    }
  }
  
  
  void cancelImageUpload(CancelPhotoUpload event,Emitter<DocumentUploadMainState2> emit)async
  {
    emit(ImagePickedInitialState());
  }
  
  void deleteDocs(deleateDocs event,Emitter<DocumentUploadMainState2> emit)async
  {
    emit(DeleateDocsLoadingStae());
    await Supabase.instance.client.from('images').delete().eq("id", authServices.value.currentUser!.uid);
    emit(DeleateDocsSuccessStae());
    
  }

  }


