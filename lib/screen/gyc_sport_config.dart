import 'package:flutter/material.dart';

import '../AppColors/gyc_colors.dart';

enum SlotStatus { available, booked, gycMember }

enum MemberType { member, affiliatedMember, nonMember }

class SlotSelection {
  const SlotSelection({
    required this.sportName,
    required this.courtLabel,
    required this.courtNumber,
    required this.personCountLabel,
    required this.dateLabel,
    required this.timeRange,
    required this.price,
    required this.status,
  });

  final String sportName;
  final String courtLabel;
  final int courtNumber;
  final String personCountLabel; // e.g. "2 Person"
  final String dateLabel; // e.g. "Jun 17"
  final String timeRange; // e.g. "2:30 PM → 3:20 PM"
  final double price;
  final SlotStatus status;
}

class SportConfig {
  const SportConfig({
    required this.name,
    required this.title,
    required this.description,
    required this.rules,
    required this.benefits,
    this.courtLabel = 'Court',
  });

  final String name;
  final String title;
  final String description;
  final List<String> rules;
  final String benefits;
  final String courtLabel;

  static const badminton = SportConfig(
    name: 'Badminton',
    title: 'Badminton\nCourt',
    description:
        'Select your preferred slot from our premium indoor courts. Gold slots are reserved for GYC members and special sessions.',
    rules: [
      'Non-marking shoes are mandatory.',
      'Cancellation required 4 hours prior.',
      'Maximum 2 consecutive hours booking.',
    ],
    benefits:
        'Platinum members enjoy priority booking and 50% discount on peak hour slots. GYC Members have exclusive access to evening tournament courts.',
  );

  static const basketball = SportConfig(
    name: 'Basketball',
    title: 'Basketball\nCourt',
    description:
        'Select your preferred slot from our premium indoor courts. Gold slots are reserved for GYC members and special sessions.',
    rules: [
      'Proper sports shoes are mandatory.',
      'Cancellation required 4 hours prior.',
      'Maximum 2 consecutive hours booking.',
    ],
    benefits:
        'Platinum members enjoy priority booking and 50% discount on peak hour slots. GYC Members have exclusive access to evening tournament courts.',
  );

  static const cricket = SportConfig(
    name: 'Cricket',
    title: 'Cricket\nGround',
    description:
        'Select your preferred slot from our premium cricket facilities. Gold slots are reserved for GYC members and special sessions.',
    rules: [
      'Proper cricket gear is recommended.',
      'Cancellation required 4 hours prior.',
      'Maximum 2 consecutive hours booking.',
    ],
    benefits:
        'Platinum members enjoy priority booking and 50% discount on peak hour slots. GYC Members have exclusive access to evening practice nets.',
    courtLabel: 'Net',
  );

  static const football = SportConfig(
    name: 'Football',
    title: 'Football\nGround',
    description:
        'Select your preferred slot from our premium football grounds. Gold slots are reserved for GYC members and special sessions.',
    rules: [
      'Football boots or turf shoes required.',
      'Cancellation required 4 hours prior.',
      'Maximum 2 consecutive hours booking.',
    ],
    benefits:
        'Platinum members enjoy priority booking and 50% discount on peak hour slots. GYC Members have exclusive access to evening tournament grounds.',
    courtLabel: 'Ground',
  );

  static const swimming = SportConfig(
    name: 'Swimming',
    title: 'Swimming\nPool',
    description:
        'Select your preferred slot from our premium swimming facilities. Gold slots are reserved for GYC members and special sessions.',
    rules: [
      'Swimming cap and goggles recommended.',
      'Cancellation required 4 hours prior.',
      'Maximum 1 hour per booking.',
    ],
    benefits:
        'Platinum members enjoy priority booking and 50% discount on peak hour slots. GYC Members have exclusive access to evening lane sessions.',
    courtLabel: 'Lane',
  );

  static const tennis = SportConfig(
    name: 'Tennis',
    title: 'Tennis\nCourt',
    description:
        'Select your preferred slot from our premium tennis courts. Gold slots are reserved for GYC members and special sessions.',
    rules: [
      'Tennis shoes are mandatory.',
      'Cancellation required 4 hours prior.',
      'Maximum 2 consecutive hours booking.',
    ],
    benefits:
        'Platinum members enjoy priority booking and 50% discount on peak hour slots. GYC Members have exclusive access to evening tournament courts.',
  );

  static SportConfig forSport(String sportName) {
    switch (sportName) {
      case 'Badminton':
        return badminton;
      case 'Basketball':
        return basketball;
      case 'Cricket':
        return cricket;
      case 'Football':
        return football;
      case 'Swimming':
        return swimming;
      case 'Tennis':
        return tennis;
      default:
        return badminton;
    }
  }
}

class CourtBookingColors {
  static const cardBg = Color(0xFF2A2B2D);
  static const chipBg = Color(0xFF2D2E30);

  static const availableDot = Color(0xFF39D353);
  static const bookedDot = Color(0xFFE74C3C);
  static const memberDot = AppColors.gold;
}

