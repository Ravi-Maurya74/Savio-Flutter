import 'dart:convert';

class ChartData {
  final String date;
  final int total_amount;
  ChartData({
    required this.date,
    required this.total_amount,
  });

  ChartData copyWith({
    String? date,
    int? total_amount,
  }) {
    return ChartData(
      date: date ?? this.date,
      total_amount: total_amount ?? this.total_amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'total_amount': total_amount,
    };
  }

  factory ChartData.fromMap(Map<String, dynamic> map) {
    return ChartData(
      date: map['date'] as String,
      total_amount: map['total_amount'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartData.fromJson(String source) => ChartData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChartData(date: $date, total_amount: $total_amount)';

  @override
  bool operator ==(covariant ChartData other) {
    if (identical(this, other)) return true;
  
    return 
      other.date == date &&
      other.total_amount == total_amount;
  }

  @override
  int get hashCode => date.hashCode ^ total_amount.hashCode;
}