// history_model.dart
class HistoryModel {
  final int status;
  final bool error;
  final String message;
  final List<HistoryData> data;

  HistoryModel({
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      status: json['status'],
      error: json['error'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((item) => HistoryData.fromJson(item))
          .toList(),
    );
  }
}

class HistoryData {
  final String payDate;
  final String pay;
  final String month;

  HistoryData({
    required this.payDate,
    required this.pay,
    required this.month,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      payDate: json['pay_date'],
      pay: json['pay'],
      month: json['month'],
    );
  }
}
