import 'dart:convert';

class Transaction {
  final int id;
  final String date;
  final String amount;
  final String title;
  final Category category;
  final String detail;
  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.title,
    required this.category,
    required this.detail,
  });

  Transaction copyWith({
    int? id,
    String? date,
    String? amount,
    String? title,
    Category? category,
    String? detail,
  }) {
    return Transaction(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      title: title ?? this.title,
      category: category ?? this.category,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'amount': amount,
      'title': title,
      'category': category.toMap(),
      'detail': detail,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'].toInt() as int,
      date: map['date'] as String,
      amount: map['amount'] as String,
      title: map['title'] as String,
      category: Category.fromMap(map['category'] as Map<String,dynamic>),
      detail: map['detail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, date: $date, amount: $amount, title: $title, category: $category, detail: $detail)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.date == date &&
      other.amount == amount &&
      other.title == title &&
      other.category == category &&
      other.detail == detail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      date.hashCode ^
      amount.hashCode ^
      title.hashCode ^
      category.hashCode ^
      detail.hashCode;
  }
}

class Category {
  final int id;
  final String name;
  Category({
    required this.id,
    required this.name,
  });

  Category copyWith({
    int? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Category(id: $id, name: $name)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}