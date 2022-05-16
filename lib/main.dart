import 'package:flutter/material.dart';
import 'package:flutter_app212/mapPage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;
import 'Dataget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyApps(),
    );
  }
}

class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<dataget>>(
          future: getData(),
          builder: (context,snapshot){
            final doc = snapshot.data;
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                return Text("wait");
              default :
                if (snapshot.hasError){
                  return Text(snapshot.error.toString());
                }else{
                  return buildMap(doc);
                }
            }
          },
        ),
      )
    );
  }

  Future<List<dataget>> getData() async{
    Uri uri =Uri.http("younus.scanfsolutions.com","/testApi.json",{'q':'{https://}'});
    Response res = await get(uri);
    final body = convert.json.decode(res.body);

    return   body.map<dataget>(dataget.fromJson).toList();

  }


  Widget buildMap(List<dataget> a) => StaggeredGridView.countBuilder(
    crossAxisCount: 4,
    itemCount: a.length,
    itemBuilder: (BuildContext context, int index) {
      final value = a[index];
       return GestureDetector(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>MapPages( lat: value.Latitude,long:value.Longitude,name: value.name,)));
         },
         child: Container(
           decoration: BoxDecoration(
             image: DecorationImage(
               image: NetworkImage(value.thumbnailUrl),
               fit: BoxFit.cover,
             )
           ),
             child: new Center(
               child: new Text(value.name,),
             )),
       );
    },
    staggeredTileBuilder: (int index) =>
    new StaggeredTile.count(2, index.isEven ? 2 : 1),
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
  );
}

