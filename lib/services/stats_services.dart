import 'dart:convert';

import 'package:covid_tracker/View/world_stats.dart';
import 'package:covid_tracker/model/worldStats.dart';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatsModel> fetchWorldStats() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchcountriesList() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesListApi));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception('Error');
    }
  }
}
