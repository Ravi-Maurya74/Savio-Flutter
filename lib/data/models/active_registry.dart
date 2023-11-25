import 'dart:convert';

import 'package:savio/data/models/user.dart';

class ActiveRegistry {
  final int id;
  final User lender;
  final User borrower;
  final User initiated_by;
  final User? cleared_by;
  final String initiate_clearing_request_url;
  final String amount;
  final String create_date;
  final String? clear_date;
  final String status;
  final String? description;
  ActiveRegistry({
    required this.id,
    required this.lender,
    required this.borrower,
    required this.initiated_by,
    required this.cleared_by,
    required this.initiate_clearing_request_url,
    required this.amount,
    required this.create_date,
    required this.clear_date,
    required this.status,
    required this.description,
  });

  ActiveRegistry copyWith({
    int? id,
    User? lender,
    User? borrower,
    User? initiated_by,
    User? cleared_by,
    String? initiate_clearing_request_url,
    String? amount,
    String? create_date,
    String? clear_date,
    String? status,
    String? description,
  }) {
    return ActiveRegistry(
      id: id ?? this.id,
      lender: lender ?? this.lender,
      borrower: borrower ?? this.borrower,
      initiated_by: initiated_by ?? this.initiated_by,
      cleared_by: cleared_by ?? this.cleared_by,
      initiate_clearing_request_url: initiate_clearing_request_url ?? this.initiate_clearing_request_url,
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
      'cleared_by': cleared_by!=null?cleared_by!.toMap():null,
      'initiate_clearing_request_url': initiate_clearing_request_url,
      'amount': amount,
      'create_date': create_date,
      'clear_date': clear_date,
      'status': status,
      'description': description,
    };
  }

  factory ActiveRegistry.fromMap(Map<String, dynamic> map) {
    return ActiveRegistry(
      id: map['id'].toInt() as int,
      lender: User.fromMap(map['lender'] as Map<String,dynamic>),
      borrower: User.fromMap(map['borrower'] as Map<String,dynamic>),
      initiated_by: User.fromMap(map['initiated_by'] as Map<String,dynamic>),
      cleared_by: map['cleared_by']!=null? User.fromMap(map['cleared_by'] as Map<String,dynamic>):null,
      initiate_clearing_request_url: map['initiate_clearing_request_url'] as String,
      amount: map['amount'] as String,
      create_date: map['create_date'] as String,
      clear_date:  map['clear_date']!=null?map['clear_date'] as String:null ,
      status: map['status'] as String,
      description: map['description']!=null?map['description'] as String:null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveRegistry.fromJson(String source) => ActiveRegistry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ActiveRegistry(id: $id, lender: $lender, borrower: $borrower, initiated_by: $initiated_by, cleared_by: $cleared_by, initiate_clearing_request_url: $initiate_clearing_request_url, amount: $amount, create_date: $create_date, clear_date: $clear_date, status: $status, description: $description)';
  }

  @override
  bool operator ==(covariant ActiveRegistry other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.lender == lender &&
      other.borrower == borrower &&
      other.initiated_by == initiated_by &&
      other.cleared_by == cleared_by &&
      other.initiate_clearing_request_url == initiate_clearing_request_url &&
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
      initiate_clearing_request_url.hashCode ^
      amount.hashCode ^
      create_date.hashCode ^
      clear_date.hashCode ^
      status.hashCode ^
      description.hashCode;
  }
}

