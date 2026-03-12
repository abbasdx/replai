import 'package:flutter/material.dart';

/// Minimal, high-contrast design tokens for instant theme switching
class P {
  final bool isDark;
  const P(this.isDark);

  Color get bg => isDark ? const Color(0xFF03060E) : const Color(0xFFF8FAFC);
  Color get surface => isDark ? const Color(0xFF090E1A) : Colors.white;
  Color get surfaceSubtle =>
      isDark ? const Color(0xFF050811) : const Color(0xFFF1F5F9);
  Color get surfaceElevated =>
      isDark ? const Color(0xFF11182B) : const Color(0xFFF1F5F9);
  Color get border =>
      isDark ? const Color(0xFF172036) : const Color(0xFFE2E8F0);
  Color get borderSubtle =>
      isDark ? const Color(0xFF0F1626) : const Color(0xFFEDF2F7);

  Color get textPrimary =>
      isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A);
  Color get textSecondary =>
      isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);
  Color get textMuted =>
      isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

  static const Color primary = Color(0xFF6366F1);
  static const Color primaryAccent = Color(0xFF818CF8);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
}