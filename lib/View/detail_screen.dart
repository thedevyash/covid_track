import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered;
  String active, critical, test, todayRecovered;

  DetailScreen(
      {super.key,
      required this.name,
      required this.active,
      required this.critical,
      required this.image,
      required this.test,
      required this.todayRecovered,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered});

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
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      ReusableRow(
                          title: 'Cases', value: widget.totalCases.toString()),
                      ReusableRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString()),
                      ReusableRow(
                          title: 'Critical',
                          value: widget.critical == "null"
                              ? "0"
                              : widget.critical.toString()),
                      ReusableRow(
                          title: 'Active', value: widget.active.toString()),
                      ReusableRow(
                          title: 'Total Recovered',
                          value: widget.totalRecovered.toString()),
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
