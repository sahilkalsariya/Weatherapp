import 'package:flutter/material.dart';
import 'package:json_app/%20models/post_model.dart';
import 'package:json_app/helper/api_helper.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<Weather?> getData;
  TextStyle textStyle = TextStyle(fontSize: 22, color: Colors.purple);
  final TextEditingController searchController = TextEditingController();
  String searchedCity = " SURAT ";

  @override
  void initState() {
    super.initState();
    getData = APIHelper.apihelper.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
        elevation: 5,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search By City Name ..",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        searchedCity = searchController.text;

                        setState(() {
                          getData =
                              APIHelper.apihelper.fetchData(city: searchedCity);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: FutureBuilder(
              future: getData,
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Text("Error : ${snapshot.error}");
                }else if (snapshot.hasData){
                  Weather? data = snapshot.data as Weather?;

                  return (data!=null) ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("City : ${searchedCity}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black)),
                        SizedBox(height: 8),
                        Text("Main : ${data.main}",style: textStyle,),
                        Text("Description : ${data.description}",style: textStyle,),
                        Text("Temp : ${data.temp}",style: textStyle,),
                        Text("Wind Speed : ${data.speed}",style: textStyle,),
                        Text("Humidity : ${data.humidity}",style: textStyle,),
                        Text("Country : ${data.country}",style: textStyle,),
                      ],
                    ),
                  ) : Text("No Data founds........");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
