import 'package:flutter/material.dart';

import 'gyc_slot_booking.dart';
import '../AppColors/gyc_colors.dart';

class GycGuestUserScreen extends StatelessWidget {
  const GycGuestUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(title: 'Guest User'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 92,
                              height: 92,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDADADA),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned(
                              right: 6,
                              bottom: 6,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF39D353),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.bg,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              const Text(
                                'Your Name',
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(height: 1, color: AppColors.line),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2D2E30),
                                  border: Border.all(color: AppColors.line),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Color(0xFF39D353),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Available',
                                      style: TextStyle(
                                        color: AppColors.text,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.text,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _IconFieldRow(icon: Icons.call, hint: 'Phone Number'),
                    const SizedBox(height: 16),
                    _IconFieldRow(icon: Icons.mail_outline, hint: 'Email'),
                    const SizedBox(height: 20),
                    Container(height: 1, color: AppColors.line),
                    const SizedBox(height: 20),
                    _LabelFieldRow(label: 'Category', value: 'Guest User'),
                    const SizedBox(height: 18),
                    _LabelFieldRow(label: 'Address', value: ''),
                    const SizedBox(height: 18),
                    _LabelFieldRow(label: 'Profession', value: ''),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
              child: SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4C7AB),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const GycSlotBookingScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
  const _TopBar({required this.title});

  final String title;

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
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: AppColors.gold),
          ),
        ],
      ),
    );
  }
}

class _IconFieldRow extends StatelessWidget {
  const _IconFieldRow({required this.icon, required this.hint});

  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.muted, size: 22),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hint,
                style: const TextStyle(color: AppColors.text, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(height: 1, color: AppColors.line),
            ],
          ),
        ),
      ],
    );
  }
}

class _LabelFieldRow extends StatelessWidget {
  const _LabelFieldRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 14),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(color: AppColors.text, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Container(height: 1, color: AppColors.line),
            ],
          ),
        ),
      ],
    );
  }
}
