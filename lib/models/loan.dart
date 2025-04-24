import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'loan.g.dart';

@HiveType(typeId: 0)
class Loan extends HiveObject {
  @HiveField(0)
  final double loan;

  @HiveField(1)
  final String date;

  Loan({required this.loan, required this.date});
}