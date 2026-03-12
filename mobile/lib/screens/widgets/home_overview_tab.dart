// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../controllers/generator_controller.dart';
// import '../theme_tokens.dart';

// class HomeOverviewTab extends StatelessWidget {
//   final GeneratorController controller;
//   final P p;

//   const HomeOverviewTab({super.key, required this.controller, required this.p});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
//       child: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 560),
//           child: TweenAnimationBuilder<double>(
//             tween: Tween(begin: 0.0, end: 1.0),
//             duration: const Duration(milliseconds: 600),
//             curve: Curves.easeOutCubic,
//             builder: (context, value, child) {
//               return Opacity(
//                 opacity: value,
//                 child: Transform.translate(
//                   offset: Offset(0, 20 * (1 - value)),
//                   child: child,
//                 ),
//               );
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // 1. THE VALUE HOOK
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: P.primary.withValues(alpha: 0.1),
//                     borderRadius: BorderRadius.circular(30),
//                     border: Border.all(
//                       color: P.primary.withValues(alpha: 0.28),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: P.primaryAccent.withValues(alpha: 0.1),
//                         blurRadius: 12,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: const Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.bolt_rounded,
//                           size: 14, color: P.primaryAccent),
//                       SizedBox(width: 6),
//                       Text(
//                         'AI-Powered Email Workflow',
//                         style: TextStyle(
//                           fontSize: 11.5,
//                           fontWeight: FontWeight.w600,
//                           color: P.primaryAccent,
//                           letterSpacing: 0.2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(
//                     style: TextStyle(
//                       fontSize: 34,
//                       fontWeight: FontWeight.w800,
//                       color: p.textPrimary,
//                       height: 1.15,
//                       letterSpacing: -1.0,
//                     ),
//                     children: const [
//                       TextSpan(text: 'Write better emails in\n'),
//                       TextSpan(
//                         text: 'seconds',
//                         style: TextStyle(color: P.primaryAccent),
//                       ),
//                       TextSpan(text: '.'),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 14),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     'Paste an incoming email to generate a tailored reply, or turn rough notes into a polished draft instantly.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14.5,
//                       color: p.textSecondary,
//                       height: 1.55,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // 2. PRIMARY CORE ACTIONS
//                 _AnimatedBentoCard(
//                   p: p,
//                   icon: Icons.auto_awesome_rounded,
//                   accentColor: P.primaryAccent,
//                   badgeText: 'GENERATOR',
//                   title: 'Generate reply',
//                   description:
//                       'Paste an incoming email and get a context-aware response matched to your chosen tone.',
//                   onTap: () {
//                     HapticFeedback.lightImpact();
//                     controller.switchTab(1);
//                   },
//                 ),
//                 const SizedBox(height: 14),

//                 _AnimatedBentoCard(
//                   p: p,
//                   icon: Icons.tune_rounded,
//                   accentColor: const Color(0xFF38BDF8),
//                   badgeText: 'REFINER',
//                   title: 'Improve draft',
//                   description:
//                       'Fix grammar, sharpen phrasing, and turn rough thoughts into a crisp, ready-to-send email.',
//                   onTap: () {
//                     HapticFeedback.lightImpact();
//                     controller.switchTab(2);
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // 3. TRUST & PRIVACY INDICATORS (Moved up to neutralize anxiety early)
//                 Wrap(
//                   spacing: 16,
//                   runSpacing: 10,
//                   alignment: WrapAlignment.center,
//                   children: [
//                     _FeatureTick(p: p, label: 'No storage'),
//                     _FeatureTick(p: p, label: 'Instant copy'),
//                     _FeatureTick(p: p, label: 'Free & secure'),
//                   ],
//                 ),
//                 const SizedBox(height: 28),

//                 // 4. FRICTIONLESS WORKFLOW
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                   decoration: BoxDecoration(
//                     color: p.surface,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: p.borderSubtle, width: 1.5),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 36,
//                         height: 36,
//                         decoration: BoxDecoration(
//                           color: p.surfaceElevated,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Icon(
//                           Icons.ios_share_rounded,
//                           size: 16,
//                           color: P.primaryAccent,
//                         ),
//                       ),
//                       const SizedBox(width: 14),
//                       Expanded(
//                         child: Text(
//                           'Tip: Select text in Gmail → tap Share → choose Replai to auto-fill.',
//                           style: TextStyle(
//                             fontSize: 12.5,
//                             color: p.textSecondary,
//                             height: 1.45,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _AnimatedBentoCard extends StatefulWidget {
//   final P p;
//   final IconData icon;
//   final Color accentColor;
//   final String badgeText;
//   final String title;
//   final String description;
//   final VoidCallback onTap;

//   const _AnimatedBentoCard({
//     required this.p,
//     required this.icon,
//     required this.accentColor,
//     required this.badgeText,
//     required this.title,
//     required this.description,
//     required this.onTap,
//   });

//   @override
//   State<_AnimatedBentoCard> createState() => _AnimatedBentoCardState();
// }

// class _AnimatedBentoCardState extends State<_AnimatedBentoCard> {
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) {
//         setState(() => _isPressed = true);
//         HapticFeedback.selectionClick();
//       },
//       onTapUp: (_) {
//         setState(() => _isPressed = false);
//         widget.onTap();
//       },
//       onTapCancel: () => setState(() => _isPressed = false),
//       child: AnimatedScale(
//         scale: _isPressed ? 0.97 : 1.0,
//         duration: const Duration(milliseconds: 120),
//         curve: Curves.easeOutCubic,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 150),
//           width: double.infinity,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: _isPressed ? widget.p.surfaceSubtle : widget.p.surface,
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: _isPressed
//                   ? widget.accentColor.withValues(alpha: 0.3)
//                   : widget.p.border,
//             ),
//             boxShadow: _isPressed
//                 ? []
//                 : [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.02),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 42,
//                     height: 42,
//                     decoration: BoxDecoration(
//                       color: widget.accentColor.withValues(alpha: 0.12),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: widget.accentColor.withValues(alpha: 0.25),
//                       ),
//                     ),
//                     child: Icon(widget.icon, color: widget.accentColor, size: 20),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         widget.badgeText,
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 1.0,
//                           color: widget.p.textMuted,
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       Icon(
//                         Icons.arrow_forward_rounded,
//                         size: 14,
//                         color: widget.p.textMuted,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 widget.title,
//                 style: TextStyle(
//                   fontSize: 18.5,
//                   fontWeight: FontWeight.w800,
//                   color: widget.p.textPrimary,
//                   letterSpacing: -0.3,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 widget.description,
//                 style: TextStyle(
//                   fontSize: 13.5,
//                   color: widget.p.textSecondary,
//                   height: 1.5,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _PlatformPill extends StatelessWidget {
//   final P p;
//   final IconData icon;
//   final Color iconColor;
//   final String label;

//   const _PlatformPill({
//     required this.p,
//     required this.icon,
//     required this.iconColor,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//       decoration: BoxDecoration(
//         color: p.surfaceSubtle,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: p.border),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: iconColor),
//           const SizedBox(width: 6),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: p.textSecondary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _FeatureTick extends StatelessWidget {
//   final P p;
//   final String label;

//   const _FeatureTick({required this.p, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(2),
//           decoration: BoxDecoration(
//             color: P.primaryAccent.withValues(alpha: 0.1),
//             shape: BoxShape.circle,
//           ),
//           child: const Icon(Icons.check_rounded,
//               size: 11, color: P.primaryAccent),
//         ),
//         const SizedBox(width: 6),
//         Text(
//           label,
//           style: TextStyle(fontSize: 12, color: p.textSecondary),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../controllers/generator_controller.dart';
import '../theme_tokens.dart';

class HomeOverviewTab extends StatelessWidget {
  final GeneratorController controller;
  final P p;

  const HomeOverviewTab({super.key, required this.controller, required this.p});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Left-aligned for app feel
              children: [
                // 1. APP DASHBOARD HEADER
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: p.surfaceElevated,
                        border: Border.all(color: p.borderSubtle),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/headshot.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.person_rounded,
                            color: P.primaryAccent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: TextStyle(
                            fontSize: 13,
                            color: p.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ready to write? ✍️',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: p.textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                // 2. WORKSPACE SECTION
                Text(
                  'YOUR WORKSPACE',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: p.textMuted,
                  ),
                ),
                const SizedBox(height: 12),

                _AnimatedBentoCard(
                  p: p,
                  icon: Icons.auto_awesome_rounded,
                  accentColor: P.primaryAccent,
                  badgeText: 'CREATE',
                  title: 'Generate reply',
                  description: 'Turn an incoming email or rough notes into a context-aware response.',
                  onTap: () {
                    HapticFeedback.lightImpact();
                    controller.switchTab(1);
                  },
                ),
                const SizedBox(height: 12),

                _AnimatedBentoCard(
                  p: p,
                  icon: Icons.tune_rounded,
                  accentColor: const Color(0xFF38BDF8),
                  badgeText: 'REFINE',
                  title: 'Improve draft',
                  description: 'Fix grammar, sharpen phrasing, or change the tone of an existing draft.',
                  onTap: () {
                    HapticFeedback.lightImpact();
                    controller.switchTab(2);
                  },
                ),
                const SizedBox(height: 36),

                // 3. INTEGRATION / TIPS SECTION
                Text(
                  'PRO TIP',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: p.textMuted,
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: p.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: p.borderSubtle, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: p.surfaceElevated,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.ios_share_rounded,
                          size: 18,
                          color: P.primaryAccent,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seamless Gmail Integration',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: p.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Select text in any app → tap Share → choose Replai to auto-fill.',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: p.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // 4. SUBTLE TRUST INDICATORS
                Center(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      _FeatureTick(p: p, label: 'No storage'),
                      _FeatureTick(p: p, label: 'Instant copy'),
                      _FeatureTick(p: p, label: 'Free & secure'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedBentoCard extends StatefulWidget {
  final P p;
  final IconData icon;
  final Color accentColor;
  final String badgeText;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _AnimatedBentoCard({
    required this.p,
    required this.icon,
    required this.accentColor,
    required this.badgeText,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<_AnimatedBentoCard> createState() => _AnimatedBentoCardState();
}

class _AnimatedBentoCardState extends State<_AnimatedBentoCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        HapticFeedback.selectionClick();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: _isPressed ? widget.p.surfaceSubtle : widget.p.surface,
            borderRadius: BorderRadius.circular(24), // Increased border radius for iOS feel
            border: Border.all(
              color: _isPressed
                  ? widget.accentColor.withValues(alpha: 0.3)
                  : widget.p.border,
            ),
            boxShadow: _isPressed || widget.p.isDark
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: widget.accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: widget.accentColor.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Icon(widget.icon, color: widget.accentColor, size: 22),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: widget.p.surfaceElevated,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.badgeText,
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                            color: widget.p.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: widget.p.textMuted,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: widget.p.textPrimary,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 13.5,
                  color: widget.p.textSecondary,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureTick extends StatelessWidget {
  final P p;
  final String label;

  const _FeatureTick({required this.p, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.shield_rounded, size: 12, color: p.textMuted),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 11.5, color: p.textMuted, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}