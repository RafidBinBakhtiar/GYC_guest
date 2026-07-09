import 'dart:ui';

import 'package:flutter/material.dart';

import '../AppColors/gyc_colors.dart';
import 'gyc_login_screen.dart';

class GycPaymentDoneScreen extends StatefulWidget {
  const GycPaymentDoneScreen({super.key});

  @override
  State<GycPaymentDoneScreen> createState() => _GycPaymentDoneScreenState();
}

class _GycPaymentDoneScreenState extends State<GycPaymentDoneScreen> {
  bool _showDialog = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2022),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const _TopBar(title: 'Done'),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 145,
                          height: 145,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFAFAFAF),
                              width: 8,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.check,
                            color: Color(0xFFAFAFAF),
                            size: 68,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Done',
                          style: TextStyle(
                            color: Color(0xFF9F9F9F),
                            fontSize: 52,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 34),
                        SizedBox(
                          width: 160,
                          height: 42,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFD2C8B3),
                              side: const BorderSide(
                                color: Color(0xFFD2C8B3),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'See Statement',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_showDialog) ...[
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.6, sigmaY: 2.6),
                  child: Container(color: Colors.black.withValues(alpha: 0.50)),
                ),
              ),
              Center(
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD2C8B3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF26292C), width: 4),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.check, color: Color(0xFF26292C), size: 38),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Done',
                        style: TextStyle(
                          color: Color(0xFF1E1F20),
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF2A2B2D),
                                side: const BorderSide(color: Color(0xFF666358)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => const GycLoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: const Text(
                                'Close',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE2D9C6),
                                foregroundColor: const Color(0xFF2A2B2D),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: const BorderSide(color: Color(0xFF666358)),
                                ),
                              ),
                              onPressed: () => setState(() => _showDialog = false),
                              child: const Text(
                                'See Statement',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.gold, size: 18),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  fontWeight: FontWeight.w400,
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
