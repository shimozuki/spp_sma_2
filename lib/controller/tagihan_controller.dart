import 'dart:convert';
import 'package:flutter_ewallet/models/tagihan_model.dart';
import 'package:http/http.dart' as http;

class TagihanController {
  final String apiUrl = 'https://lombokfuntransport.com/apispp/api/tagihan';

  Future<TagihanModel> getTagihan() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return TagihanModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
