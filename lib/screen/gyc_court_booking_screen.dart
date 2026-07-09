import 'package:flutter/material.dart';

import '../AppColors/gyc_colors.dart';
import 'gyc_ground_booking_screen.dart';
import 'gyc_sport_config.dart';
import 'widgets/gyc_court_booking_widgets.dart';

class GycCourtBookingScreen extends StatefulWidget {
  const GycCourtBookingScreen({super.key, required this.config});

  final SportConfig config;

  @override
  State<GycCourtBookingScreen> createState() => _GycCourtBookingScreenState();
}

class _GycCourtBookingScreenState extends State<GycCourtBookingScreen> {
  int _selectedDateIndex = 0;

  static const _dates = [
    DateItem(month: 'JUN', day: '17', label: 'Today'),
    DateItem(month: 'JUN', day: '18', label: 'Tue'),
    DateItem(month: 'JUN', day: '19', label: 'Wed'),
    DateItem(month: 'JUN', day: '20', label: 'Thu'),
  ];

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final label = config.courtLabel;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            CourtBookingAppBar(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      config.title,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      config.description,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const LegendRow(),
                    const SizedBox(height: 20),
                    DateSelector(
                      items: _dates,
                      selectedIndex: _selectedDateIndex,
                      onSelected: (index) => setState(() => _selectedDateIndex = index),
                    ),
                    const SizedBox(height: 20),
                    CourtGrid(
                      courtLabel: label,
                      sportName: config.name,
                      onAvailableTap: (selection) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => GycGroundBookingScreen(
                              selection: selection,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    MemberSlotsList(courtLabel: label),
                    const SizedBox(height: 20),
                    InfoCard(
                      title: 'Club Rules & Etiquette',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final rule in config.rules)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '•  ',
                                    style: TextStyle(
                                      color: AppColors.gold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      rule,
                                      style: const TextStyle(
                                        color: AppColors.muted,
                                        fontSize: 13,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    InfoCard(
                      title: 'Membership Benefits',
                      child: Text(
                        config.benefits,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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

