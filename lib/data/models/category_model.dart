class CategoryModel {
  final int? id;
  final String category;
  final String type;

  const CategoryModel({
    this.id,
    required this.category,
    required this.type
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'type': type
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    return CategoryModel(
      id: data['id'],
      category: data['category'],
      type: data['type']
    );
  }

  CategoryModel copyWith({
    int? id,
    String? category,
    String? type
  }) {
    return CategoryModel(
      id: id ?? this.id,
      category: category ?? this.category,
      type: type ?? this.type
    );
  }

  @override
  String toString() => 'CategoryModel(id: $id, category: $category, type: $type)';
}
