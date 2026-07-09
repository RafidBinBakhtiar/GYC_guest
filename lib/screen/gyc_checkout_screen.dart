import 'package:flutter/material.dart';

import '../AppColors/gyc_colors.dart';
import 'gyc_payment_method_screen.dart';
import 'gyc_sport_config.dart';

class GycCheckoutScreen extends StatelessWidget {
  const GycCheckoutScreen({
    super.key,
    required this.selection,
    required this.memberType,
  });

  final SlotSelection selection;
  final MemberType memberType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              title: 'Slot Booking',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Checkout',
                      style: TextStyle(
                        color: Color(0xFFE6D5BB),
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Complete your booking for court and club facilities.',
                      style: TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    _BillingDetailsCard(),
                    const SizedBox(height: 16),
                    _OrderCard(selection: selection),
                    const SizedBox(height: 16),
                    _PayOnlineCard(total: selection.price),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 52,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4C7AB),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => GycPaymentMethodScreen(
                                selection: selection,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'CONFIRM',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Selected: ${_memberTypeLabel(memberType)}',
                      style: const TextStyle(color: AppColors.line, fontSize: 12),
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

  String _memberTypeLabel(MemberType t) {
    switch (t) {
      case MemberType.member:
        return 'Member';
      case MemberType.affiliatedMember:
        return 'Affiliated member';
      case MemberType.nonMember:
        return 'Non member';
    }
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
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.menu, color: AppColors.gold),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: AppColors.gold),
          ),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2B2D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _BillingDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: 'Billing Details',
      child: Column(
        children: const [
          _LabeledField(label: 'First Name *', hint: 'Enter your first name'),
          SizedBox(height: 14),
          _LabeledField(label: 'Phone *', hint: 'e.g. +880 1XXX XXX XXX'),
          SizedBox(height: 14),
          _LabeledField(label: 'Email Address *', hint: 'example@domain.com'),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            hint,
            style: const TextStyle(color: Color(0xFF77818A), fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.selection});

  final SlotSelection selection;

  @override
  Widget build(BuildContext context) {
    final s = selection;
    return _CardShell(
      title: 'Your Order',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${s.sportName} (${s.personCountLabel}) × 1',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                s.price.toStringAsFixed(2),
                style: const TextStyle(
                  color: Color(0xFFE6D5BB),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${s.courtLabel} ${s.courtNumber}, Person 2 Tk ${s.price.toStringAsFixed(0)}, ${s.dateLabel} - ${s.timeRange}',
            style: const TextStyle(color: AppColors.muted, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: AppColors.line),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(color: AppColors.muted)),
              Text(
                '${s.price.toStringAsFixed(2)}৳',
                style: const TextStyle(color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${s.price.toStringAsFixed(2)}৳',
                style: const TextStyle(
                  color: Color(0xFFE6D5BB),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PayOnlineCard extends StatelessWidget {
  const _PayOnlineCard({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: 'Pay Online',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'CREDIT / DEBIT / MOBILE\nBANKING',
                  style: TextStyle(color: AppColors.muted, fontSize: 10, height: 1.4),
                ),
                SizedBox(height: 10),
                Text(
                  'Pay securely via Credit/Debit card, Internet banking or Mobile banking (bkash, Nagad, Rocket) through SSLCommerz.',
                  style: TextStyle(color: AppColors.line, fontSize: 11, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 92,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: const Text(
              'SSLCOMMERZ\nVERIFIED',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

