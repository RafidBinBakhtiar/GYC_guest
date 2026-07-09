import 'package:flutter/material.dart';

import '../AppColors/gyc_colors.dart';
import 'gyc_card_checkout_screen.dart';
import 'gyc_sport_config.dart';

enum PaymentMethod { bkash, nagad }

class GycPaymentMethodScreen extends StatefulWidget {
  const GycPaymentMethodScreen({super.key, required this.selection});

  final SlotSelection selection;

  @override
  State<GycPaymentMethodScreen> createState() => _GycPaymentMethodScreenState();
}

class _GycPaymentMethodScreenState extends State<GycPaymentMethodScreen> {
  PaymentMethod? _method = PaymentMethod.bkash;

  @override
  Widget build(BuildContext context) {
    final amount = widget.selection.price.toStringAsFixed(0);
    return Scaffold(
      backgroundColor: const Color(0xFF1F2022),
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              title: 'Select Payment Method',
              onBack: () => Navigator.of(context).pop(),
            ),
            Container(height: 1, color: const Color(0xFF2A2B2D)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              color: const Color(0xFF404144),
              child: Row(
                children: [
                  const Text(
                    'Amount:',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4C7AB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        amount,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'BDT',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _MethodRow(
                    logo: const _LogoBox(letter: 'b', color: Color(0xFFE91E63)),
                    title: 'Bkash',
                    selected: _method == PaymentMethod.bkash,
                    onTap: () => setState(() => _method = PaymentMethod.bkash),
                  ),
                  _MethodRow(
                    logo: const _LogoBox(letter: 'N', color: Color(0xFFFF9800)),
                    title: 'Nagad',
                    selected: _method == PaymentMethod.nagad,
                    onTap: () => setState(() => _method = PaymentMethod.nagad),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
              child: SizedBox(
                height: 44,
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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GycCardCheckoutScreen(
                          selection: widget.selection,
                          method: _method ?? PaymentMethod.bkash,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Next',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
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

class _MethodRow extends StatelessWidget {
  const _MethodRow({
    required this.logo,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final Widget logo;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: const BoxDecoration(
          color: Color(0xFF1F2022),
          border: Border(
            bottom: BorderSide(color: Color(0xFF2A2B2D), width: 1),
          ),
        ),
        child: Row(
          children: [
            logo,
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.gold : const Color(0xFF8D8D8D),
                  width: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoBox extends StatelessWidget {
  const _LogoBox({required this.letter, required this.color});

  final String letter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.15),
            ),
          ),
          Text(
            letter,
            style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

