import 'dart:convert';

import 'package:savio/data/models/user.dart';

class ClearPendingRegistry {
  final int id;
  final User lender;
  final User borrower;
  final User initiated_by;
  final User cleared_by;
  final String accept_clear_request_url;
  final String reject_clear_request_url;
  final String amount;
  final String create_date;
  final String clear_date;
  final String status;
  final String description;
  ClearPendingRegistry({
    required this.id,
    required this.lender,
    required this.borrower,
    required this.initiated_by,
    required this.cleared_by,
    required this.accept_clear_request_url,
    required this.reject_clear_request_url,
    required this.amount,
    required this.create_date,
    required this.clear_date,
    required this.status,
    required this.description,
  });

  ClearPendingRegistry copyWith({
    int? id,
    User? lender,
    User? borrower,
    User? initiated_by,
    User? cleared_by,
    String? accept_clear_request_url,
    String? reject_clear_request_url,
    String? amount,
    String? create_date,
    String? clear_date,
    String? status,
    String? description,
  }) {
    return ClearPendingRegistry(
      id: id ?? this.id,
      lender: lender ?? this.lender,
      borrower: borrower ?? this.borrower,
      initiated_by: initiated_by ?? this.initiated_by,
      cleared_by: cleared_by ?? this.cleared_by,
      accept_clear_request_url:
          accept_clear_request_url ?? this.accept_clear_request_url,
      reject_clear_request_url:
          reject_clear_request_url ?? this.reject_clear_request_url,
      amount: amount ?? this.amount,
      create_date: create_date ?? this.create_date,
      clear_date: clear_date ?? this.clear_date,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lender': lender.toMap(),
      'borrower': borrower.toMap(),
      'initiated_by': initiated_by.toMap(),
      'cleared_by': cleared_by.toMap(),
      'accept_clear_request_url': accept_clear_request_url,
      'reject_clear_request_url': reject_clear_request_url,
      'amount': amount,
      'create_date': create_date,
      'clear_date': clear_date,
      'status': status,
      'description': description,
    };
  }

  factory ClearPendingRegistry.fromMap(Map<String, dynamic> map) {
    return ClearPendingRegistry(
      id: map['id'].toInt() as int,
      lender: User.fromMap(map['lender'] as Map<String, dynamic>),
      borrower: User.fromMap(map['borrower'] as Map<String, dynamic>),
      initiated_by: User.fromMap(map['initiated_by'] as Map<String, dynamic>),
      cleared_by: User.fromMap(map['cleared_by'] as Map<String, dynamic>),
      accept_clear_request_url: map['accept_clear_request_url'] as String,
      reject_clear_request_url: map['reject_clear_request_url'] as String,
      amount: map['amount'] as String,
      create_date: map['create_date'] as String,
      clear_date: map['clear_date'] as String,
      status: map['status'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClearPendingRegistry.fromJson(String source) =>
      ClearPendingRegistry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClearPendingRegistry(id: $id, lender: $lender, borrower: $borrower, initiated_by: $initiated_by, cleared_by: $cleared_by, accept_clear_request_url: $accept_clear_request_url, reject_clear_request_url: $reject_clear_request_url, amount: $amount, create_date: $create_date, clear_date: $clear_date, status: $status, description: $description)';
  }

  @override
  bool operator ==(covariant ClearPendingRegistry other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.lender == lender &&
        other.borrower == borrower &&
        other.initiated_by == initiated_by &&
        other.cleared_by == cleared_by &&
        other.accept_clear_request_url == accept_clear_request_url &&
        other.reject_clear_request_url == reject_clear_request_url &&
        other.amount == amount &&
        other.create_date == create_date &&
        other.clear_date == clear_date &&
        other.status == status &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        lender.hashCode ^
        borrower.hashCode ^
        initiated_by.hashCode ^
        cleared_by.hashCode ^
        accept_clear_request_url.hashCode ^
        reject_clear_request_url.hashCode ^
        amount.hashCode ^
        create_date.hashCode ^
        clear_date.hashCode ^
        status.hashCode ^
        description.hashCode;
  }
}
