import 'package:flutter/material.dart';

import '../../AppColors/gyc_colors.dart';
import '../gyc_sport_config.dart';

class DateItem {
  const DateItem({
    required this.month,
    required this.day,
    required this.label,
  });

  final String month;
  final String day;
  final String label;
}

class MemberSlot {
  const MemberSlot({
    required this.time,
    required this.title,
    required this.reserved,
  });

  final String time;
  final String title;
  final bool reserved;
}

class SlotColors {
  const SlotColors({
    required this.background,
    required this.timeColor,
    required this.statusColor,
    required this.priceColor,
  });

  final Color background;
  final Color timeColor;
  final Color statusColor;
  final Color priceColor;
}

SlotColors slotColors(SlotStatus status) {
  switch (status) {
    case SlotStatus.available:
      return const SlotColors(
        background: Color(0xFF1A3D2E),
        timeColor: Color(0xFF4ADE80),
        statusColor: Color(0xFFE6E6E6),
        priceColor: Color(0xFF4ADE80),
      );
    case SlotStatus.booked:
      return const SlotColors(
        background: Color(0xFF3D2525),
        timeColor: Color(0xFFB8956B),
        statusColor: Color(0xFF9E9E9E),
        priceColor: Color(0xFF9E9E9E),
      );
    case SlotStatus.gycMember:
      return const SlotColors(
        background: Color(0xFF3D3A35),
        timeColor: AppColors.gold,
        statusColor: AppColors.text,
        priceColor: AppColors.gold,
      );
  }
}

String statusLabel(SlotStatus status) {
  switch (status) {
    case SlotStatus.available:
      return 'Available';
    case SlotStatus.booked:
      return 'Booked';
    case SlotStatus.gycMember:
      return 'GYC Member';
  }
}

class CourtBookingAppBar extends StatelessWidget {
  const CourtBookingAppBar({super.key, required this.onBack});

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
          const Expanded(
            child: Center(
              child: Text(
                'Slot Booking',
                style: TextStyle(
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

class LegendRow extends StatelessWidget {
  const LegendRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        LegendChip(dotColor: CourtBookingColors.availableDot, label: 'Available'),
        SizedBox(width: 10),
        LegendChip(dotColor: CourtBookingColors.bookedDot, label: 'Booked'),
        SizedBox(width: 10),
        LegendChip(dotColor: CourtBookingColors.memberDot, label: 'GYC Member'),
      ],
    );
  }
}

class LegendChip extends StatelessWidget {
  const LegendChip({super.key, required this.dotColor, required this.label});

  final Color dotColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: CourtBookingColors.chipBg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: AppColors.text, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<DateItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final date = items[index];
          final selected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              width: 72,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: CourtBookingColors.chipBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: selected ? AppColors.gold : AppColors.line,
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.month,
                    style: TextStyle(
                      color: selected ? AppColors.gold : AppColors.muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day,
                    style: TextStyle(
                      color: selected ? AppColors.gold : Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date.label,
                    style: TextStyle(
                      color: selected ? AppColors.gold : AppColors.muted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CourtGrid extends StatelessWidget {
  const CourtGrid({
    super.key,
    required this.courtLabel,
    required this.sportName,
    this.onAvailableTap,
  });

  final String courtLabel;
  final String sportName;
  final ValueChanged<SlotSelection>? onAvailableTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CourtBookingColors.cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          _gridRow([
            _HeaderCell('$courtLabel 1 (2P)'),
            _HeaderCell('$courtLabel 1 (4P)'),
          ]),
          _gridRow([
            _HeaderCell('$courtLabel 2 (2P)'),
            _HeaderCell('$courtLabel 2 (4P)'),
          ]),
          _gridRow([
            _SlotCell(
              time: '2:30 pm - 3:20 pm',
              status: SlotStatus.booked,
              price: 'Tk 800',
            ),
            _SlotCell(
              time: '2:30 pm - 3:20 pm',
              status: SlotStatus.available,
              price: 'Tk 1400',
              onTap: () => _emitAvailableTap(
                courtNumber: 1,
                personCountLabel: '4 Person',
                timeRange: '2:30 PM → 3:20 PM',
                price: 1400,
              ),
            ),
          ]),
          _gridRow([
            _SlotCell(
              time: '2:30 pm - 3:20 pm',
              status: SlotStatus.available,
              price: 'Tk 800',
              onTap: () => _emitAvailableTap(
                courtNumber: 2,
                personCountLabel: '2 Person',
                timeRange: '2:30 PM → 3:20 PM',
                price: 800,
              ),
            ),
            _SlotCell(
              time: '2:30 pm - 3:20 pm',
              status: SlotStatus.available,
              price: 'Tk 1400',
              onTap: () => _emitAvailableTap(
                courtNumber: 2,
                personCountLabel: '4 Person',
                timeRange: '2:30 PM → 3:20 PM',
                price: 1400,
              ),
            ),
          ]),
          _gridRow([
            _SlotCell(
              time: '3:30 pm - 4:20 pm',
              status: SlotStatus.available,
              price: 'Tk 800',
              onTap: () => _emitAvailableTap(
                courtNumber: 1,
                personCountLabel: '2 Person',
                timeRange: '3:30 PM → 4:20 PM',
                price: 800,
              ),
            ),
            _SlotCell(
              time: '3:30 pm - 4:20 pm',
              status: SlotStatus.available,
              price: 'Tk 1400',
              onTap: () => _emitAvailableTap(
                courtNumber: 1,
                personCountLabel: '4 Person',
                timeRange: '3:30 PM → 4:20 PM',
                price: 1400,
              ),
            ),
          ]),
          _gridRow([
            _SlotCell(
              time: '3:30 pm - 4:20 pm',
              status: SlotStatus.available,
              price: 'Tk 800',
              onTap: () => _emitAvailableTap(
                courtNumber: 2,
                personCountLabel: '2 Person',
                timeRange: '3:30 PM → 4:20 PM',
                price: 800,
              ),
            ),
            _SlotCell(
              time: '3:30 pm - 4:20 pm',
              status: SlotStatus.available,
              price: 'Tk 1400',
              onTap: () => _emitAvailableTap(
                courtNumber: 2,
                personCountLabel: '4 Person',
                timeRange: '3:30 PM → 4:20 PM',
                price: 1400,
              ),
            ),
          ], isLast: true),
        ],
      ),
    );
  }

  void _emitAvailableTap({
    required int courtNumber,
    required String personCountLabel,
    required String timeRange,
    required double price,
  }) {
    final cb = onAvailableTap;
    if (cb == null) return;
    cb(
      SlotSelection(
        sportName: sportName,
        courtLabel: courtLabel,
        courtNumber: courtNumber,
        personCountLabel: personCountLabel,
        dateLabel: 'Jun 17',
        timeRange: timeRange,
        price: price,
        status: SlotStatus.available,
      ),
    );
  }

  Widget _gridRow(List<Widget> children, {bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: i < children.length - 1
                        ? const BorderSide(color: AppColors.line)
                        : BorderSide.none,
                    bottom: isLast
                        ? BorderSide.none
                        : const BorderSide(color: AppColors.line),
                  ),
                ),
                child: children[i],
              ),
            ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.gold,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _SlotCell extends StatelessWidget {
  const _SlotCell({
    required this.time,
    required this.status,
    required this.price,
    this.onTap,
  });

  final String time;
  final SlotStatus status;
  final String price;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = slotColors(status);

    final child = Container(
      color: colors.background,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.timeColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            statusLabel(status),
            style: TextStyle(color: colors.statusColor, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(color: colors.priceColor, fontSize: 12),
          ),
        ],
      ),
    );

    if (onTap == null || status != SlotStatus.available) return child;
    return InkWell(onTap: onTap, child: child);
  }
}

class MemberSlotsList extends StatelessWidget {
  const MemberSlotsList({super.key, required this.courtLabel});

  final String courtLabel;

  @override
  Widget build(BuildContext context) {
    final slots = [
      MemberSlot(
        time: '6:30 pm - 7:20 pm',
        title: 'GYC Members Women Time $courtLabel 1',
        reserved: true,
      ),
      MemberSlot(
        time: '6:30 pm - 7:20 pm',
        title: 'GYC Member $courtLabel 2',
        reserved: true,
      ),
      MemberSlot(
        time: '7:30 pm - 8:20 pm',
        title: 'GYC Member $courtLabel 1',
        reserved: false,
      ),
      MemberSlot(
        time: '7:30 pm - 8:20 pm',
        title: 'GYC Member $courtLabel 2',
        reserved: false,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: CourtBookingColors.cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          for (var i = 0; i < slots.length; i++)
            _MemberSlotCell(slot: slots[i], isLast: i == slots.length - 1),
        ],
      ),
    );
  }
}

class _MemberSlotCell extends StatelessWidget {
  const _MemberSlotCell({required this.slot, required this.isLast});

  final MemberSlot slot;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF3D3A35),
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : const BorderSide(color: AppColors.line),
        ),
      ),
      child: Column(
        children: [
          Text(
            slot.time,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            slot.title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.text, fontSize: 13),
          ),
          if (slot.reserved) ...[
            const SizedBox(height: 6),
            const Text(
              'RESERVED',
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CourtBookingColors.cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

