// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../theme_tokens.dart';

// class AboutProductTab extends StatelessWidget {
//   final P p;
//   final void Function(String label) onCopied;

//   const AboutProductTab({super.key, required this.p, required this.onCopied});

//   void _copy(String text, String label) {
//     Clipboard.setData(ClipboardData(text: text));
//     onCopied(text);
//   }

//   void _showComingSoon(BuildContext context, String feature) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('$feature will be available soon'),
//         behavior: SnackBarBehavior.floating,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'ABOUT',
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 1.5,
//                     color: P.primaryAccent,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   'Zero-friction email communication.',
//                   style: TextStyle(
//                     fontSize: 21,
//                     fontWeight: FontWeight.w800,
//                     color: p.textPrimary,
//                     letterSpacing: -0.5,
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // 1. CREATOR PROFILE
//                 Container(
//                   padding: const EdgeInsets.all(18),
//                   decoration: BoxDecoration(
//                     color: p.surface,
//                     borderRadius: BorderRadius.circular(18),
//                     border: Border.all(color: p.border),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             width: 52,
//                             height: 52,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               border: Border.all(
//                                 color: P.primaryAccent.withValues(alpha: 0.3),
//                                 width: 2,
//                               ),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.asset(
//                                 'assets/headshot.jpg',
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (_, __, ___) => Container(
//                                   color: P.primary.withValues(alpha: 0.2),
//                                   child: const Icon(
//                                     Icons.person_rounded,
//                                     color: P.primaryAccent,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 14),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Abbas Ansari',
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w800,
//                                     color: p.textPrimary,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   'Software Engineer',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: p.textSecondary,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   'Gurgaon, India',
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     color: p.textMuted,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Powered by a Spring Boot backend and Google Gemini, delivering fast, stateless email workflows across Web, Chrome Extension, and Android.',
//                         style: TextStyle(
//                           fontSize: 13.5,
//                           color: p.textSecondary,
//                           height: 1.5,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: [
//                           _SocialChip(
//                             p: p,
//                             icon: Icons.language_rounded,
//                             label: 'abbasansari.me',
//                             onTap: () => _copy('https://abbasansari.me', 'Website'),
//                           ),
//                           _SocialChip(
//                             p: p,
//                             icon: Icons.code_rounded,
//                             label: 'github.com/abbasdx',
//                             onTap: () => _copy('https://github.com/abbasdx', 'GitHub'),
//                           ),
//                           _SocialChip(
//                             p: p,
//                             icon: Icons.work_outline_rounded,
//                             label: 'in/abbas-ansari',
//                             onTap: () => _copy('https://linkedin.com/in/abbas-ansari', 'LinkedIn'),
//                           ),
//                           _SocialChip(
//                             p: p,
//                             icon: Icons.alternate_email_rounded,
//                             label: '@_abbasansari',
//                             onTap: () => _copy('https://x.com/_abbasansari', 'X'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 // 2. TECH SPECIFICATIONS
//                 Container(
//                   padding: const EdgeInsets.all(18),
//                   decoration: BoxDecoration(
//                     color: p.surface,
//                     borderRadius: BorderRadius.circular(18),
//                     border: Border.all(color: p.border),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Specifications',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: p.textPrimary,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       _SpecItem(
//                         p: p,
//                         label: 'Stack',
//                         value: 'Java 21 • Spring Boot • Flutter • Gemini AI',
//                       ),
//                       Divider(color: p.borderSubtle, height: 18),
//                       _SpecItem(
//                         p: p,
//                         label: 'Privacy',
//                         value: 'Stateless in-memory processing with zero email persistence.',
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 // 3. SUPPORT & LEGAL (Missing Standard Component)
//                 Container(
//                   decoration: BoxDecoration(
//                     color: p.surface,
//                     borderRadius: BorderRadius.circular(18),
//                     border: Border.all(color: p.border),
//                   ),
//                   child: Column(
//                     children: [
//                       _MenuRow(
//                         p: p,
//                         icon: Icons.mail_outline_rounded,
//                         label: 'Send Feedback',
//                         onTap: () => _showComingSoon(context, 'Feedback'),
//                         isFirst: true,
//                       ),
//                       Divider(color: p.borderSubtle, height: 1, indent: 46),
//                       _MenuRow(
//                         p: p,
//                         icon: Icons.shield_outlined,
//                         label: 'Privacy Policy',
//                         onTap: () => _showComingSoon(context, 'Privacy Policy'),
//                       ),
//                       Divider(color: p.borderSubtle, height: 1, indent: 46),
//                       _MenuRow(
//                         p: p,
//                         icon: Icons.description_outlined,
//                         label: 'Open Source Licenses',
//                         onTap: () {
//                           HapticFeedback.lightImpact();
//                           showLicensePage(
//                             context: context,
//                             applicationName: 'Replai',
//                             applicationVersion: '1.0.0',
//                             applicationIcon: Image.asset('assets/logo.png', width: 48, height: 48),
//                             applicationLegalese: '© 2026 Abbas Ansari',
//                           );
//                         },
//                         isLast: true,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // 4. PLATFORMS
//                 Center(
//                   child: Column(
//                     children: [
//                       Text(
//                         'ALSO AVAILABLE ON',
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 1.5,
//                           color: p.textMuted,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Wrap(
//                         spacing: 12,
//                         runSpacing: 12,
//                         alignment: WrapAlignment.center,
//                         children: [
//                           _PlatformPill(
//                             p: p,
//                             icon: Icons.extension_rounded,
//                             iconColor: const Color(0xFFFBBF24),
//                             label: 'Chrome Extension',
//                           ),
//                           _PlatformPill(
//                             p: p,
//                             icon: Icons.language_rounded,
//                             iconColor: const Color(0xFF38BDF8),
//                             label: 'Web',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 // 5. APP VERSION FOOTER (Missing Standard Component)
//                 Center(
//                   child: Column(
//                     children: [
//                       Text(
//                         'Replai v1.0.0',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: p.textSecondary,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         '© 2026 Abbas Ansari',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: p.textMuted,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _MenuRow extends StatelessWidget {
//   final P p;
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final bool isFirst;
//   final bool isLast;

//   const _MenuRow({
//     required this.p,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     this.isFirst = false,
//     this.isLast = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         HapticFeedback.lightImpact();
//         onTap();
//       },
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(isFirst ? 18 : 0),
//         bottom: Radius.circular(isLast ? 18 : 0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
//         child: Row(
//           children: [
//             Icon(icon, size: 18, color: p.textSecondary),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 13.5,
//                   fontWeight: FontWeight.w600,
//                   color: p.textPrimary,
//                 ),
//               ),
//             ),
//             Icon(Icons.chevron_right_rounded, size: 18, color: p.textMuted),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SocialChip extends StatelessWidget {
//   final P p;
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;

//   const _SocialChip({
//     required this.p,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         HapticFeedback.lightImpact();
//         onTap();
//       },
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//         decoration: BoxDecoration(
//           color: p.surfaceSubtle,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: p.border),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 13, color: P.primaryAccent),
//             const SizedBox(width: 6),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 11.5,
//                 fontWeight: FontWeight.w600,
//                 color: p.textPrimary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SpecItem extends StatelessWidget {
//   final P p;
//   final String label;
//   final String value;

//   const _SpecItem({
//     required this.p,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 11,
//             fontWeight: FontWeight.w700,
//             color: P.primaryAccent,
//           ),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 12.5,
//             color: p.textSecondary,
//             height: 1.4,
//           ),
//         ),
//       ],
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme_tokens.dart';

class AboutProductTab extends StatelessWidget {
  final P p;
  final void Function(String label) onCopied;

  const AboutProductTab({super.key, required this.p, required this.onCopied});

  void _copy(String text, String label) {
    HapticFeedback.selectionClick();
    Clipboard.setData(ClipboardData(text: text));
    onCopied(text);
  }

  void _showComingSoon(BuildContext context, String feature) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature will be available soon'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 24 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ABOUT',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.8,
                            color: P.primaryAccent,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Replai Assistant',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: p.textPrimary,
                            letterSpacing: -0.8,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: p.surfaceElevated,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: p.borderSubtle),
                      ),
                      child: Text(
                        'v1.0.0',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: p.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // 2. PREMIUM DEVELOPER HERO CARD
                _DeveloperHeroCard(p: p, onCopy: _copy),
                const SizedBox(height: 24),

                // 3. ENGINE & PRIVACY (Grouped List)
                _GroupedSection(
                  p: p,
                  title: 'TECHNOLOGY',
                  children: [
                    _SettingsRow(
                      p: p,
                      icon: Icons.memory_rounded,
                      iconBg: const Color(0xFF6366F1),
                      title: 'Engine Stack',
                      subtitle: 'Java 21 • Spring Boot • Gemini AI',
                      isFirst: true,
                    ),
                    _SettingsRow(
                      p: p,
                      icon: Icons.shield_rounded,
                      iconBg: const Color(0xFF10B981),
                      title: 'Zero-Storage Privacy',
                      subtitle: 'Stateless execution. Emails are never saved.',
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 4. ECOSYSTEM (Grouped List)
                _GroupedSection(
                  p: p,
                  title: 'AVAILABLE PLATFORMS',
                  children: [
                    _SettingsRow(
                      p: p,
                      icon: Icons.extension_rounded,
                      iconBg: const Color(0xFFF59E0B),
                      title: 'Chrome Extension',
                      subtitle: 'Integrates directly into your desktop browser.',
                      isFirst: true,
                    ),
                    _SettingsRow(
                      p: p,
                      icon: Icons.language_rounded,
                      iconBg: const Color(0xFF38BDF8),
                      title: 'Web Application',
                      subtitle: 'Access Replai from any browser, anywhere.',
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 5. SUPPORT & LEGAL (Grouped List)
                _GroupedSection(
                  p: p,
                  title: 'SUPPORT & LEGAL',
                  children: [
                    _SettingsRow(
                      p: p,
                      icon: Icons.favorite_rounded,
                      iconBg: const Color(0xFFEC4899),
                      title: 'Send Feedback',
                      onTap: () => _showComingSoon(context, 'Feedback'),
                      isFirst: true,
                      showArrow: true,
                    ),
                    _SettingsRow(
                      p: p,
                      icon: Icons.lock_rounded,
                      iconBg: const Color(0xFF8B5CF6),
                      title: 'Privacy Policy',
                      onTap: () => _showComingSoon(context, 'Privacy Policy'),
                      showArrow: true,
                    ),
                    _SettingsRow(
                      p: p,
                      icon: Icons.gavel_rounded,
                      iconBg: const Color(0xFF64748B),
                      title: 'Open Source Licenses',
                      onTap: () {
                        HapticFeedback.lightImpact();
                        showLicensePage(
                          context: context,
                          applicationName: 'Replai',
                          applicationVersion: '1.0.0',
                          applicationIcon: Image.asset('assets/logo.png', width: 64, height: 64),
                          applicationLegalese: '© 2026 Abbas Ansari\nAll rights reserved.',
                        );
                      },
                      isLast: true,
                      showArrow: true,
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // 6. MINIMAL FOOTER
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: p.surfaceElevated,
                        ),
                        child: Icon(Icons.code_rounded, size: 14, color: p.textMuted),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Designed & Engineered by Abbas Ansari',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: p.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '© 2026 All rights reserved.',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: p.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// PREMIUM HERO CARD (Digital Business Card Style)
// ============================================================================
class _DeveloperHeroCard extends StatelessWidget {
  final P p;
  final void Function(String text, String label) onCopy;

  const _DeveloperHeroCard({required this.p, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: p.border),
        boxShadow: [
          BoxShadow(
            color: P.primary.withValues(alpha: p.isDark ? 0.05 : 0.03),
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            P.primary.withValues(alpha: 0.08),
            p.surface.withValues(alpha: 0.0),
            p.surface.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar with animated glow ring
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF38BDF8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: P.primary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: p.surface, width: 3),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/headshot.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: p.surfaceElevated,
                      child: const Icon(Icons.person, color: P.primaryAccent, size: 32),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Name & Title
            Text(
              'Abbas Ansari',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: p.textPrimary,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Software Engineer • Backend & Flutter',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: P.primaryAccent,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_rounded, size: 12, color: p.textMuted),
                const SizedBox(width: 4),
                Text(
                  'Gurgaon, India',
                  style: TextStyle(fontSize: 12, color: p.textMuted),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2x2 Symmetrical Social Grid
            Row(
              children: [
                Expanded(
                  child: _SocialPill(
                    p: p,
                    icon: Icons.language_rounded,
                    label: 'Website',
                    onTap: () => onCopy('https://abbasansari.me', 'Website URL'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SocialPill(
                    p: p,
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    onTap: () => onCopy('https://github.com/abbasdx', 'GitHub URL'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _SocialPill(
                    p: p,
                    icon: Icons.work_outline_rounded,
                    label: 'LinkedIn',
                    onTap: () => onCopy('https://linkedin.com/in/abbas-ansari', 'LinkedIn URL'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SocialPill(
                    p: p,
                    icon: Icons.alternate_email_rounded,
                    label: 'Twitter / X',
                    onTap: () => onCopy('https://x.com/_abbasansari', 'X Profile'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialPill extends StatelessWidget {
  final P p;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialPill({
    required this.p,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: p.surfaceElevated,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: p.borderSubtle),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15, color: p.textPrimary),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: p.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// APPLE-STYLE GROUPED LISTS
// ============================================================================
class _GroupedSection extends StatelessWidget {
  final P p;
  final String title;
  final List<Widget> children;

  const _GroupedSection({
    required this.p,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: p.textMuted,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: p.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: p.border),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final P p;
  final IconData icon;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isFirst;
  final bool isLast;
  final bool showArrow;

  const _SettingsRow({
    required this.p,
    required this.icon,
    required this.iconBg,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isFirst = false,
    this.isLast = false,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Premium Icon Badge
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: iconBg.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 14),
          
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: p.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: p.textSecondary,
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Optional Chevron
          if (showArrow)
            Icon(Icons.chevron_right_rounded, size: 20, color: p.textMuted),
        ],
      ),
    );

    // Add touch interactions if onTap is provided
    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isFirst ? 20 : 0),
          bottom: Radius.circular(isLast ? 20 : 0),
        ),
        child: content,
      );
    }

    return Column(
      children: [
        content,
        // Inset divider for items that aren't the last one
        if (!isLast)
          Divider(color: p.borderSubtle, height: 1, indent: 62),
      ],
    );
  }
}