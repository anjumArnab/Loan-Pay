import 'package:flutter/material.dart';
import 'package:loan_pay/widgets/common_text_field.dart';
import 'package:loan_pay/widgets/info_container.dart';

class LoanPayScreen extends StatelessWidget {
  const LoanPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F5EC), // Light beige background
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

            // Remaining Loan Section
            const InfoContainer(
              title: 'Remaining Loan',
              subtitle: '\$12,450.00',
              titleStyle: TextStyle(fontSize: 14),
              subtitleStyle: TextStyle(
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

            // Payment History Cards
            const InfoContainer(
              title: 'April 15, 2025',
              subtitle: 'Payment: \$450.00',
              spacing: 2,
            ),

            const SizedBox(height: 10),
            const InfoContainer(
              title: 'April 17, 2025',
              subtitle: 'Payment: \$450.00',
              spacing: 2,
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

            // Amount Input

            const CommonTextField(
              label: 'Amount',
              hint: '\$ 450.00',
            ),

            const SizedBox(height: 10),
            // Date Input
            const CommonTextField(
              label: 'Date',
              hint: 'April 17, 2025',
            ),

            const SizedBox(height: 16),
            // Submit Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Submit Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
