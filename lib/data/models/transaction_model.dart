class TransactionModel {
  final int? id;
  final String category;
  final int nominal;
  final String note;
  final String type;
  final String date;

  TransactionModel({
    this.id,
    required this.category,
    required this.nominal,
    required this.note,
    required this.type,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      category: json['category'],
      nominal: json['nominal'],
      note: json['note'],
      type: json['type'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'nominal': nominal,
      'note': note,
      'type': type,
      'date': date,
    };
  }
}
