import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_app/model/data_model.dart';

class DataServices {
  Future<List<DataModel>> getInfo() async {
    const String uri =
        'https://raw.githubusercontent.com/subarnapoudel/travel_app/master/data.json';
    var res = await http.get(Uri.parse(uri));
    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map((e) => DataModel.fromJson(e)).toList();
      } else {
        return <DataModel>[];
      }
    } catch (e) {
      print(e);
      return <DataModel>[];
    }
  }
}
