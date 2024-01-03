// history_controller.dart
import 'dart:convert';
import 'package:flutter_ewallet/models/history_model.dart';
import 'package:http/http.dart' as http;

class HistoryController {
  final String apiUrl = 'https://lombokfuntransport.com/apispp/api/history';

  Future<List<HistoryData>> getHistory() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((item) => HistoryData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load history data');
    }
  }
}
