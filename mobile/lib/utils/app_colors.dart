import 'package:flutter/material.dart';

abstract class AppColors {
  // Core Backgrounds & Surfaces
  static const Color background = Color(0xFF090D16);
  static const Color surface = Color(0xFF0F172A);
  static const Color surfaceElevated = Color(0xFF1E293B);
  static const Color surfaceBorder = Color(0xFF334155);

  // Brand Accents
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryHover = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryContainer = Color(0xFF1E1E38);

  // Typography
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Semantic Feedback
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFF064E3B);
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFF450A0A);
  static const Color warning = Color(0xFFF59E0B);
}