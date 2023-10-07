import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/model/worldStats.dart';
import 'package:covid_tracker/services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: statsServices.fetchWorldStats(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                      controller: _controller,
                    ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered!.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths!.toString())
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width / 3,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(children: [
                              ReusableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString()),
                              ReusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              ReusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString()),
                              ReusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              ReusableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              ReusableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(
                                  title: 'Today Recovered',
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(
                                  0xff1aa260,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text("Track Countries"),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ]),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
