import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String? avatar;
  final TypeWorker typeWorker;

  User(this.id, this.name, this.avatar, this.typeWorker);
}

enum TypeWorker {
  admin,
  user,
  zavscladom,
}

enum ItemStatus { 
  fixed, 
  replaced, 
  working, 
  test1,
  test3,
  test4,
  movingTo() }

class HistoryModel {
  final DateTime date;
  final ItemStatus status;
  final TypeWorker typeWorker;

  HistoryModel(
      {required this.date, required this.status, required this.typeWorker});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      date: json['date'],
      status: json['status'],
      typeWorker: json['workerType'],
    );
  }
}
