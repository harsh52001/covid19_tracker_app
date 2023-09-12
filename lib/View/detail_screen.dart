import 'package:covid_tracker/world_state.dart';
import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {
  String image,name;
  int totalCases,totalDeath,totalReceived,active,critical,totalRecovered,test;

   DetailScreen({Key? key,
     required this.name,
     required this.image,
     required this.totalDeath,
     required this.totalCases,
     required this.critical,
     required this.totalReceived,
     required this.active,
     required this.totalRecovered,
     required this.test,
   }):super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child:Column(
                    children: [
                      ResuableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ResuableRow(title: 'Critical', value: widget.critical.toString()),
                      ResuableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ResuableRow(title: 'Deaths', value: widget.totalDeath.toString()),
                      ResuableRow(title: 'Active', value: widget.active.toString()),
                      ResuableRow(title: 'Test', value: widget.test.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
