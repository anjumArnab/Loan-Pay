import 'package:hive/hive.dart';
import 'package:loan_pay/models/loan.dart';

class LoanService {
  static const String LOANS_BOX = 'loansBox';
  
  // Initialize Hive and register adapters
  static Future<void> init() async {
    Hive.registerAdapter(LoanAdapter());
    if (!Hive.isBoxOpen(LOANS_BOX)) {
      await Hive.openBox<Loan>(LOANS_BOX);
    }
  }

  // Get box with safety check
  static Future<Box<Loan>> _getBox() async {
    if (!Hive.isBoxOpen(LOANS_BOX)) {
      await Hive.openBox<Loan>(LOANS_BOX);
    }
    return Hive.box<Loan>(LOANS_BOX);
  }

  // CREATE - Add a new loan
  static Future<void> addLoan(Loan loan) async {
    final box = await _getBox();
    await box.add(loan);
  }

  // READ - Get all loans
  static Future<List<Loan>> getAllLoans() async {
    final box = await _getBox();
    return box.values.toList();
  }

  // UPDATE - Update a loan at specific index
  static Future<void> updateLoan(int index, Loan newLoan) async {
    final box = await _getBox();
    if (index >= 0 && index < box.length) {
      await box.putAt(index, newLoan);
    } else {
      throw RangeError('Index out of range');
    }
  }

  // DELETE - Delete a loan at specific index
  static Future<void> deleteLoan(int index) async {
    final box = await _getBox();
    if (index >= 0 && index < box.length) {
      await box.deleteAt(index);
    } else {
      throw RangeError('Index out of range');
    }
  }
}