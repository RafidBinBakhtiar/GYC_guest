import 'package:flutter/material.dart';

import '../AppColors/gyc_colors.dart';
import 'gyc_checkout_screen.dart';
import 'gyc_sport_config.dart';

class GycGroundBookingScreen extends StatefulWidget {
  const GycGroundBookingScreen({super.key, required this.selection});

  final SlotSelection selection;

  @override
  State<GycGroundBookingScreen> createState() => _GycGroundBookingScreenState();
}

class _GycGroundBookingScreenState extends State<GycGroundBookingScreen> {
  MemberType? _memberType;

  @override
  Widget build(BuildContext context) {
    final s = widget.selection;

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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  children: [
                    _BigTitleCard(title: 'Ground\nBooking'),
                    const SizedBox(height: 16),
                    _CartItemCard(selection: s),
                    const SizedBox(height: 16),
                    _CouponCard(),
                    const SizedBox(height: 16),
                    _MemberTypeCard(
                      selected: _memberType,
                      onChanged: (t) {
                        setState(() => _memberType = t);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => GycCheckoutScreen(
                              selection: s,
                              memberType: t,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _CartTotalsCard(amount: s.price),
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
  const _CardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CourtBookingColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: child,
    );
  }
}

class _BigTitleCard extends StatelessWidget {
  const _BigTitleCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFE6D5BB),
              fontSize: 34,
              fontWeight: FontWeight.w700,
              height: 1.05,
            ),
          ),
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.selection});

  final SlotSelection selection;

  @override
  Widget build(BuildContext context) {
    final s = selection;
    final title = '${s.sportName} (${s.personCountLabel})';
    final meta = '${s.courtLabel} ${s.courtNumber} • Tk ${s.price.toStringAsFixed(0)} • ${s.dateLabel}';

    return _CardShell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.line),
            ),
            child: const Icon(Icons.sports_tennis, color: AppColors.gold),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  meta,
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  s.timeRange,
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CouponCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF161718),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.line),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Coupon code',
              style: TextStyle(color: Color(0xFF65717D), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberTypeCard extends StatelessWidget {
  const _MemberTypeCard({required this.selected, required this.onChanged});

  final MemberType? selected;
  final ValueChanged<MemberType> onChanged;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Are you? *',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _radioRow(
            context,
            value: MemberType.member,
            label: 'Member',
          ),
          const SizedBox(height: 10),
          _radioRow(
            context,
            value: MemberType.affiliatedMember,
            label: 'Affiliated member',
          ),
          const SizedBox(height: 10),
          _radioRow(
            context,
            value: MemberType.nonMember,
            label: 'Non member',
          ),
        ],
      ),
    );
  }

  Widget _radioRow(
    BuildContext context, {
    required MemberType value,
    required String label,
  }) {
    final isSelected = value == selected;
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.gold : AppColors.muted,
                width: 1.5,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(color: AppColors.text, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _CartTotalsCard extends StatelessWidget {
  const _CartTotalsCard({required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cart Totals',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(color: AppColors.muted)),
              Text(
                '${amount.toStringAsFixed(2)} ৳',
                style: const TextStyle(color: AppColors.text),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: AppColors.line),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(color: AppColors.muted)),
              Text(
                amount.toStringAsFixed(2),
                style: const TextStyle(
                  color: Color(0xFFE6D5BB),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.lock, color: AppColors.line, size: 14),
                SizedBox(width: 8),
                Text(
                  'Secure Checkout',
                  style: TextStyle(color: AppColors.line, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

