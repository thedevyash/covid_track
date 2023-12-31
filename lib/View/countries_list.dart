import 'package:covid_tracker/View/detail_screen.dart';
import 'package:covid_tracker/services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Search With Country'),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.fetchcountriesList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                name: snapshot.data![index]
                                                    ['country'],
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                totalCases: snapshot
                                                    .data![index]['cases'],
                                                todayRecovered: snapshot
                                                    .data![index]
                                                        ['todayRecovered']
                                                    .toString(),
                                                totalDeaths: snapshot
                                                    .data![index]['deaths'],
                                                active: snapshot.data![index]
                                                        ['active']
                                                    .toString(),
                                                test: snapshot.data![index]
                                                        ['tests']
                                                    .toString(),
                                                totalRecovered: snapshot
                                                    .data![index]['recovered'],
                                                critical: snapshot.data![index]
                                                        ['critcial']
                                                    .toString(),
                                              )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                name: snapshot.data![index]
                                                    ['country'],
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                totalCases: snapshot
                                                    .data![index]['cases'],
                                                todayRecovered: snapshot
                                                    .data![index]
                                                        ['todayRecovered']
                                                    .toString(),
                                                totalDeaths: snapshot
                                                    .data![index]['deaths'],
                                                active: snapshot.data![index]
                                                        ['active']
                                                    .toString(),
                                                test: snapshot.data![index]
                                                        ['tests']
                                                    .toString(),
                                                totalRecovered: snapshot
                                                    .data![index]['recovered'],
                                                critical: snapshot.data![index]
                                                        ['critcial']
                                                    .toString(),
                                              )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
