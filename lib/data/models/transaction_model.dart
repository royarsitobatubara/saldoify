class TransactionModel {
  int? id;
  int userId;
  String category;
  int nominal;
  String note;
  String type;
  String date;

  TransactionModel({
    this.id,
    required this.userId,
    required this.category,
    required this.nominal,
    required this.note,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return{
      'userId': userId,
      'category': category,
      'nominal': nominal,
      'note': note,
      'type': type,
      'date': date,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      userId: json['userId'],
      category: json['category'],
      nominal: json['nominal'],
      note: json['note'],
      type: json['type'],
      date: json['date'],
    );
  }
}
