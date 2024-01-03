class TagihanModel {
  final int status;
  final bool error;
  final String message;
  final int data;

  TagihanModel({
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory TagihanModel.fromJson(Map<String, dynamic> json) {
    return TagihanModel(
      status: json['status'],
      error: json['error'],
      message: json['message'],
      data: json['data'],
    );
  }
}
