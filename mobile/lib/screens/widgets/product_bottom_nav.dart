// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../controllers/generator_controller.dart';
// import '../theme_tokens.dart';

// class ProductBottomNav extends StatelessWidget {
//   final GeneratorController controller;
//   final P p;

//   const ProductBottomNav({super.key, required this.controller, required this.p});

//   static const _items = [
//     (icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
//     (
//       icon: Icons.auto_awesome_outlined,
//       activeIcon: Icons.auto_awesome_rounded,
//       label: 'Generate'
//     ),
//     (
//       icon: Icons.tune_rounded,
//       activeIcon: Icons.tune_rounded,
//       label: 'Improve'
//     ),
//     (
//       icon: Icons.person_outline_rounded,
//       activeIcon: Icons.person_rounded,
//       label: 'About'
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final currentIndex = controller.currentNavIndex.value;

//     return Container(
//       decoration: BoxDecoration(
//         color: p.surface,
//         border: Border(top: BorderSide(color: p.borderSubtle, width: 1)),
//       ),
//       padding: EdgeInsets.only(
//         left: 12,
//         right: 12,
//         top: 8,
//         bottom: MediaQuery.of(context).padding.bottom > 0 ? 6 : 10,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: List.generate(_items.length, (i) {
//           final item = _items[i];
//           final isSelected = currentIndex == i;

//           return Expanded(
//             child: GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: () {
//                 if (currentIndex != i) {
//                   HapticFeedback.selectionClick();
//                   controller.switchTab(i);
//                 }
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 180),
//                     curve: Curves.easeOutCubic,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? P.primary.withValues(alpha: 0.14)
//                           : Colors.transparent,
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Icon(
//                       isSelected ? item.activeIcon : item.icon,
//                       size: 20,
//                       color: isSelected ? P.primaryAccent : p.textMuted,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     item.label,
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight:
//                           isSelected ? FontWeight.w700 : FontWeight.w500,
//                       color: isSelected ? p.textPrimary : p.textMuted,
//                       letterSpacing: -0.1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../controllers/generator_controller.dart';
import '../theme_tokens.dart';

class ProductBottomNav extends StatelessWidget {
  final GeneratorController controller;
  final P p;

  const ProductBottomNav({super.key, required this.controller, required this.p});

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    (
      icon: Icons.auto_awesome_outlined,
      activeIcon: Icons.auto_awesome_rounded,
      label: 'Generate'
    ),
    (
      icon: Icons.tune_rounded,
      activeIcon: Icons.tune_rounded,
      label: 'Improve'
    ),
    (
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'About'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = controller.currentNavIndex.value;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        border: Border(top: BorderSide(color: p.borderSubtle, width: 1)),
        // Subtle ambient shadow for depth on light mode
        boxShadow: p.isDark
            ? []
            : [
                BoxShadow(
                  color: p.borderSubtle.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                )
              ],
      ),
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 10,
        bottom: bottomPadding > 0 ? bottomPadding + 4 : 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          final isSelected = currentIndex == i;

          return Expanded(
            child: _PremiumTabItem(
              p: p,
              icon: item.icon,
              activeIcon: item.activeIcon,
              label: item.label,
              isSelected: isSelected,
              onTap: () {
                if (!isSelected) {
                  HapticFeedback.selectionClick();
                  controller.switchTab(i);
                }
              },
            ),
          );
        }),
      ),
    );
  }
}

/// A highly tactile, animated individual tab item.
class _PremiumTabItem extends StatefulWidget {
  final P p;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PremiumTabItem({
    required this.p,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_PremiumTabItem> createState() => _PremiumTabItemState();
}

class _PremiumTabItemState extends State<_PremiumTabItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        if (!widget.isSelected) {
          setState(() => _isPressed = true);
          HapticFeedback.lightImpact();
        }
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.90 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pill Background & Icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? P.primary.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: AnimatedScale(
                scale: widget.isSelected ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.elasticOut,
                child: Icon(
                  widget.isSelected ? widget.activeIcon : widget.icon,
                  size: 22,
                  color: widget.isSelected ? P.primaryAccent : widget.p.textMuted,
                ),
              ),
            ),
            const SizedBox(height: 5),
            
            // Fluid Text Label
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter', // Will fall back gracefully if not defined
                fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                color: widget.isSelected ? widget.p.textPrimary : widget.p.textMuted,
                letterSpacing: widget.isSelected ? 0.0 : -0.2,
              ),
              child: Text(widget.label),
            ),
          ],
        ),
      ),
    );
  }
}