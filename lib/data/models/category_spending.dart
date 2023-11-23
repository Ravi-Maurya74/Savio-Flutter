import 'dart:convert';

class CategorySpending {
  final String category__name;
  final int total_spending;
  CategorySpending({
    required this.category__name,
    required this.total_spending,
  });

  CategorySpending copyWith({
    String? category__name,
    int? total_spending,
  }) {
    return CategorySpending(
      category__name: category__name ?? this.category__name,
      total_spending: total_spending ?? this.total_spending,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category__name': category__name,
      'total_spending': total_spending,
    };
  }

  factory CategorySpending.fromMap(Map<String, dynamic> map) {
    return CategorySpending(
      category__name: map['category__name'] as String,
      total_spending: map['total_spending'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorySpending.fromJson(String source) =>
      CategorySpending.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategorySpending(category__name: $category__name, total_spending: $total_spending)';

  @override
  bool operator ==(covariant CategorySpending other) {
    if (identical(this, other)) return true;

    return other.category__name == category__name &&
        other.total_spending == total_spending;
  }

  @override
  int get hashCode => category__name.hashCode ^ total_spending.hashCode;
}
