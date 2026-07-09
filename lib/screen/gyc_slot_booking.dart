import 'package:flutter/material.dart';

import '../AppColors/gyc_colors.dart';
import 'gyc_court_booking_screen.dart';
import 'gyc_sport_config.dart';

class GycSlotBookingScreen extends StatelessWidget {
  const GycSlotBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, color: AppColors.gold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1,
                  children: [
                    _SportTile(
                      title: 'Badminton',
                      icon: Icons.sports_tennis,
                      onTap: () => _openCourt(context, 'Badminton'),
                    ),
                    _SportTile(
                      title: 'Basketball',
                      icon: Icons.sports_basketball,
                      onTap: () => _openCourt(context, 'Basketball'),
                    ),
                    _SportTile(
                      title: 'Cricket',
                      icon: Icons.sports_cricket,
                      onTap: () => _openCourt(context, 'Cricket'),
                    ),
                    _SportTile(
                      title: 'Football',
                      icon: Icons.sports_soccer,
                      onTap: () => _openCourt(context, 'Football'),
                    ),
                    _SportTile(
                      title: 'Swimming',
                      icon: Icons.pool,
                      onTap: () => _openCourt(context, 'Swimming'),
                    ),
                    _SportTile(
                      title: 'Tennis',
                      icon: Icons.sports_tennis,
                      onTap: () => _openCourt(context, 'Tennis'),
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

  void _openCourt(BuildContext context, String sport) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GycCourtBookingScreen(
          config: SportConfig.forSport(sport),
        ),
      ),
    );
  }
}

class _SportTile extends StatelessWidget {
  const _SportTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(child: Icon(icon, size: 86, color: const Color(0xFFF2C46F))),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF5A5A5A),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
