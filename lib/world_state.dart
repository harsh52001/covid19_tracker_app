import 'package:covid_tracker/Model/WorldStateModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{
  late final AnimationController controller= AnimationController(duration:Duration(seconds: 3),vsync: this)..repeat();
  void dispose()
  {
    super.dispose();
    controller.dispose();
  }
  final colorList=[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01,),
                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecords(),
                    builder: (context,AsyncSnapshot<WorldStateModel> snapshot)
                  {
                    if(!snapshot.hasData)
                      {
                        return Expanded(
                            flex:1,
                            child:SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50,
                              controller: controller,
                            )
                        );
                      }
                    else
                      {
                        return Column(
                          children: [
                            PieChart(dataMap:
                             {
                              "Total": double.parse(snapshot.data!.cases!.toString()),
                              "Recovered":  double.parse(snapshot.data!.cases!.toString()),
                              "Deaths" : double.parse(snapshot.data!.cases!.toString()),

                            },
                              chartValuesOptions: const ChartValuesOptions(
                               showChartValuesInPercentage: true,
                                //showChartValueBackground: true,
                              ),
                              chartRadius: MediaQuery.of(context).size.width / 2.8,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left,
                                  legendShape: BoxShape.circle

                              ),
                              animationDuration: const Duration(microseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,

                            ),
                            Padding(
                              padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .05),
                              child: Card(
                                child: Column(
                                  children: [
                                    ResuableRow(title: 'Total', value: snapshot.data!.cases.toString(),),
                                    ResuableRow(title: 'Deaths', value: snapshot.data!.deaths.toString(),),
                                    ResuableRow(title: 'Recovered', value: snapshot.data!.recovered.toString(),),
                                    ResuableRow(title: 'Active', value: snapshot.data!.active.toString(),),
                                    ResuableRow(title: 'Critical', value: snapshot.data!.critical.toString(),),
                                    ResuableRow(title: 'Total Deaths', value: snapshot.data!.todayDeaths.toString(),),
                                    ResuableRow(title: 'Total Recovered', value: snapshot.data!.todayRecovered.toString(),),



                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
                              },

                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff1aa260)
                                ),
                                child: Center(

                                  child: Text('Track Countries'),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ResuableRow extends StatelessWidget {
  String title,value;
  ResuableRow({Key? key ,required this.title,required this.value}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(title),
              Text(value)

            ],
          ),
          SizedBox(height: 5,),
          Divider(
            thickness: 1.4,
          )
        ],
      ),
    );
  }
}


