import 'dart:convert';

import 'package:flutter/foundation.dart';

class PredictionModel {
  final double monthly_budget;
  final double predicted_total_expenditure;
  final List<PredictionData> cumulative_expenditures;
  PredictionModel({
    required this.monthly_budget,
    required this.predicted_total_expenditure,
    required this.cumulative_expenditures,
  });

  PredictionModel copyWith({
    double? monthly_budget,
    double? predicted_total_expenditure,
    List<PredictionData>? cumulative_expenditures,
  }) {
    return PredictionModel(
      monthly_budget: monthly_budget ?? this.monthly_budget,
      predicted_total_expenditure:
          predicted_total_expenditure ?? this.predicted_total_expenditure,
      cumulative_expenditures:
          cumulative_expenditures ?? this.cumulative_expenditures,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'monthly_budget': monthly_budget,
      'predicted_total_expenditure': predicted_total_expenditure,
      'cumulative_expenditures':
          cumulative_expenditures.map((x) => x.toMap()).toList(),
    };
  }

  factory PredictionModel.fromMap(Map<String, dynamic> map) {
    return PredictionModel(
      monthly_budget: double.parse((map['monthly_budget'].toDouble()).toStringAsFixed(2)),
      predicted_total_expenditure:
          double.parse((map['predicted_total_expenditure'].toDouble()).toStringAsFixed(2)),
      cumulative_expenditures: List<PredictionData>.from(
        (map['cumulative_expenditures'] as List<dynamic>).map<PredictionData>(
          (x) => PredictionData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PredictionModel.fromJson(String source) =>
      PredictionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PredictionModel(monthly_budget: $monthly_budget, predicted_total_expenditure: $predicted_total_expenditure, cumulative_expenditures: $cumulative_expenditures)';

  @override
  bool operator ==(covariant PredictionModel other) {
    if (identical(this, other)) return true;

    return other.monthly_budget == monthly_budget &&
        other.predicted_total_expenditure == predicted_total_expenditure &&
        listEquals(other.cumulative_expenditures, cumulative_expenditures);
  }

  @override
  int get hashCode =>
      monthly_budget.hashCode ^
      predicted_total_expenditure.hashCode ^
      cumulative_expenditures.hashCode;
}

class PredictionData {
  final String date;
  final double expenditure;
  PredictionData({
    required this.date,
    required this.expenditure,
  });

  PredictionData copyWith({
    String? date,
    double? expenditure,
  }) {
    return PredictionData(
      date: date ?? this.date,
      expenditure: expenditure ?? this.expenditure,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'expenditure': expenditure,
    };
  }

  factory PredictionData.fromMap(Map<String, dynamic> map) {
    return PredictionData(
      date: map['date'] as String,
      expenditure: double.parse((map['expenditure'].toDouble()).toStringAsFixed(2)),
    );
  }

  String toJson() => json.encode(toMap());

  factory PredictionData.fromJson(String source) =>
      PredictionData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Cumulative_expenditure(date: $date, expenditure: $expenditure)';

  @override
  bool operator ==(covariant PredictionData other) {
    if (identical(this, other)) return true;

    return other.date == date && other.expenditure == expenditure;
  }

  @override
  int get hashCode => date.hashCode ^ expenditure.hashCode;
}
