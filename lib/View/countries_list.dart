import 'dart:convert';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../Services/Utilities/app_url.dart';
import 'package:covid_tracker/world_state.dart';

import '../Services/states_services.dart';
class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor
      ),
      body: SafeArea(
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },

                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot)
                    {
                      if(!snapshot.hasData)
                        {
                          return ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context,index){
                                return Shimmer.fromColors(
                                  direction: ShimmerDirection.ltr,
                                  //period: Duration(microseconds: 10114),
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                                  child: Column(
                                    children: [
                                      ListTile(
                                       title: Container(height: 10,width: 89,color: Colors.white,),
                                        subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                        leading: Container(height: 50,width: 50,color: Colors.white,),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      else
                        {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                String name=snapshot.data![index]['country'];

                                if(searchController.text.isEmpty)
                                  {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              name: snapshot.data![index]['country'],
                                              totalCases:snapshot.data![index]['cases'],
                                              totalRecovered: snapshot.data![index]['recovered'],
                                              totalDeath: snapshot.data![index]['deaths'],
                                              active: snapshot.data![index]['active'],
                                              totalReceived:snapshot.data![index]['todayRecovered'],
                                              test: snapshot.data![index]['tests'],
                                              critical: snapshot.data![index]['critical'],

                                            )));
                                          },
                                          child: ListTile(
                                            title: Text(snapshot.data![index]['country']),
                                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                                            leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                else if(name.toLowerCase().contains(searchController.text.toLowerCase()))
                                  {
                                    return Column(
                                      children: [
                                        InkWell(
                                        onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'],
                                        totalCases:snapshot.data![index]['cases'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        totalDeath: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        totalReceived:snapshot.data![index]['todayRecovered'],
                                        test: snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]['critical'],

                                      )));
                                    },
                                          child: ListTile(
                                            title: Text(snapshot.data![index]['country']),
                                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                                            leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                else
                                  {
                                    return Container();
                                  }
                          });
                        }
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}
