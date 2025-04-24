import 'package:flutter/material.dart';
import 'package:loan_pay/models/loan.dart';
import 'package:loan_pay/widgets/button.dart';
import 'package:loan_pay/widgets/common_text_field.dart';
import 'package:loan_pay/widgets/info_container.dart';

import '../services/loan_service.dart';

class LoanPayScreen extends StatefulWidget {
  const LoanPayScreen({super.key});

  @override
  State<LoanPayScreen> createState() => _LoanPayScreenState();
}

class _LoanPayScreenState extends State<LoanPayScreen> with WidgetsBindingObserver {
  List<Loan> loans = [];
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final double totalLoanAmount = 12000;
  double remainingAmount = 12000;

  @override
  void initState() {
    super.initState();
    _loadLoans();
    // Register this class as an observer for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadLoans();
    }
  }

  // Load loans and update UI
  Future<void> _loadLoans() async {
    final loadedLoans = await LoanService.getAllLoans();
    setState(() {
      loans = loadedLoans;
      _calculateRemainingAmount();
    });
  }

  // Calculate remaining amount
  void _calculateRemainingAmount() {
    double usedAmount = 0;
    for (var loan in loans) {
      usedAmount += loan.loan;
    }
    remainingAmount = totalLoanAmount - usedAmount;
  }

  // Create a new loan
  Future<void> _createLoan(Loan loan) async {
    await LoanService.addLoan(loan);
    _loadLoans(); // Reload the data
  }
  
  // Update an existing loan
  Future<void> _updateLoan(int index, Loan loan) async {
    await LoanService.updateLoan(index, loan);
    _loadLoans(); // Reload the data
  }
  
  // Delete a loan
  Future<void> _deleteLoan(int index) async {
    await LoanService.deleteLoan(index);
    _loadLoans(); // Reload the data
  }

  @override
  void dispose() {
    // Remove observer when disposing
    WidgetsBinding.instance.removeObserver(this);
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F5EC),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Loan Pay',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            InfoContainer(
              title: 'Remaining Loan',
              subtitle: '\$${remainingAmount.toStringAsFixed(2)}',
              titleStyle: const TextStyle(fontSize: 14),
              subtitleStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment History',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: loans.isEmpty
              ? const Center(
                  child: Text('No payment history'),
                )
              : ListView.builder(
                  itemCount: loans.length,
                  itemBuilder: (_, index) {
                    final loan = loans[index];
                    return Column(
                      children: [
                        InfoContainer(
                          title: loan.date,
                          subtitle: 'Payment: \$${loan.loan.toStringAsFixed(2)}',
                          spacing: 2,
                          onDelete: () {
                            _deleteLoan(index);
                          },
                        ),
                        const SizedBox(height: 5),
                      ],
                    );
                  },
                ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Make Payment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            // Amount Input with controller
            CommonTextField(
              label: 'Amount',
              hint: '\$ 450.00',
              controller: amountController,
              //keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            // Date Input with controller
            CommonTextField(
              label: 'Date',
              hint: 'April 17, 2025',
              controller: dateController,
              onTap: () async {
                // Add date picker functionality
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  dateController.text = _formatDate(picked);
                }
              },
            ),
            const SizedBox(height: 16),
            // Submit Payment Button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Submit Payment',
                onPressed: () {
                  if (amountController.text.isNotEmpty && dateController.text.isNotEmpty) {
                    final double amount = double.parse(amountController.text);
                    final String date = dateController.text;
                    final Loan newLoan = Loan(loan: amount, date: date);
                    _createLoan(newLoan);
                    amountController.clear();
                    dateController.clear();
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method to format date
  String _formatDate(DateTime date) {
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June', 
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}