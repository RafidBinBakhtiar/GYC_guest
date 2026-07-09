import 'package:flutter/material.dart';

import '../AppColors/gyc_colors.dart';
import 'gyc_payment_done_screen.dart';
import 'gyc_payment_method_screen.dart';
import 'gyc_sport_config.dart';

class GycCardCheckoutScreen extends StatelessWidget {
  const GycCardCheckoutScreen({
    super.key,
    required this.selection,
    required this.method,
  });

  final SlotSelection selection;
  final PaymentMethod method;

  @override
  Widget build(BuildContext context) {
    final brand = method == PaymentMethod.bkash ? 'bKash' : 'Nagad';
    return Scaffold(
      backgroundColor: const Color(0xFF1F2022),
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              title: 'Card Checkout',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 154,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9E9E9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x66000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        brand,
                        style: TextStyle(
                          color: method == PaymentMethod.bkash
                              ? const Color(0xFFE91E63)
                              : const Color(0xFFFF9800),
                          fontSize: 56,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const _FieldLabel('Card Number'),
                    const SizedBox(height: 10),
                    const _DarkField(text: '0095 - 2586 - 6541 - 3256'),
                    const SizedBox(height: 24),
                    const _FieldLabel('Name'),
                    const SizedBox(height: 10),
                    const _DarkField(text: 'Md. Sumon Biswas'),
                    const SizedBox(height: 24),
                    const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FieldLabel('Expiry date'),
                              SizedBox(height: 10),
                              _DarkField(text: '11/19'),
                            ],
                          ),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FieldLabel('CVV'),
                              SizedBox(height: 10),
                              _DarkField(text: '123'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 92),
                    SizedBox(
                      height: 46,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4C7AB),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () =>
                            _showPaymentConfirmation(context, selection.price),
                        child: const Text(
                          'Pay Now',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColors.appBar,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.gold, size: 18),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: AppColors.gold),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF969696),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _DarkField extends StatelessWidget {
  const _DarkField({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF4A4B4E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

Future<void> _showPaymentConfirmation(BuildContext context, double amount) async {
  final confirmed = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: const Color(0xFFD2C8B3),
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: const BoxDecoration(
                  color: Color(0xFFC9AF69),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                ),
                child: Center(
                  child: Text(
                    'Amount: ${amount.toStringAsFixed(0)} BDT',
                    style: TextStyle(
                      color: Color(0xFF222426),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
                child: Text(
                  'Are you sure about\nthis transaction?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF232527),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF222426),
                          side: const BorderSide(color: Color(0xFF565347)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A2B2D),
                          foregroundColor: const Color(0xFFD2C8B3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                        child: const Text('Confirm'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  if (confirmed == true && context.mounted) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GycPaymentDoneScreen()),
    );
  }
}

