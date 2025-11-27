import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goolemapuse/CubitsBloc/DocumentFetchMapperClass.dart';
import 'package:goolemapuse/CubitsBloc/FaviroouteItemListCubit.dart';

class FavirouteItemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return _FavirouteItemScreen();
  }

}

class _FavirouteItemScreen  extends State<FavirouteItemScreen>{

  late List<DocumentFetchMapperClass> items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   items =  context.read<FaviroouteItemListCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<FaviroouteItemListCubit,List<DocumentFetchMapperClass>>(
              builder: (context,state) {
                if(state.isEmpty)
                  {
                    return Align(
                      alignment: Alignment.center,
                      child: Text("No Favourite Selected Yet."),);
                  }
                return Expanded(
                  child: GridView.builder(
                    itemCount: state.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10), itemBuilder: (context,index){
                     return ClipRRect(
                       borderRadius: BorderRadius.circular(15),
                       child: Image.network(state[index].images[0],fit: BoxFit.cover,),
                     ) ;
                  }),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}