import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/generator_controller.dart';
import '../theme_tokens.dart';

class GenerateWorkspaceTab extends StatelessWidget {
  final GeneratorController controller;
  final P p;

  const GenerateWorkspaceTab({super.key, required this.controller, required this.p});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'GENERATE REPLY',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: P.primaryAccent,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Polished responses for any email.',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: p.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: p.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: p.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Incoming email',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: p.textPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            _SmallUtilityBtn(
                              p: p,
                              icon: Icons.content_paste_rounded,
                              label: 'Paste',
                              onTap: () {
                                HapticFeedback.selectionClick();
                                controller.pasteGenerateInput();
                              },
                            ),
                            Obx(() {
                              if (controller.generateCharCount.value == 0) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: _SmallUtilityBtn(
                                  p: p,
                                  icon: Icons.close_rounded,
                                  label: 'Clear',
                                  isMuted: true,
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    controller.inputController.clear();
                                    controller.generateStateTitle.value = '';
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: controller.inputController,
                      minLines: 5,
                      maxLines: 8,
                      style: TextStyle(
                        fontSize: 14,
                        color: p.textPrimary,
                        height: 1.5,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Paste the email you want to reply to...',
                        hintStyle: TextStyle(
                          fontSize: 13.5,
                          color: p.textMuted,
                        ),
                        filled: true,
                        fillColor: p.surfaceSubtle,
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: p.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: p.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: P.primary,
                            width: 1.4,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Obx(
                      () => _CharacterCounterBar(
                        p: p,
                        count: controller.generateCharCount.value,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tone',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: p.textPrimary,
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.activeTone.description,
                            style: TextStyle(
                              fontSize: 11.5,
                              color: p.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),

                    Obx(() {
                      final activeVal = controller.selectedTone.value;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: GeneratorController.tones.map((tone) {
                            final selected = tone.value == activeVal;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  controller.selectedTone.value = tone.value;
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? P.primary
                                        : p.surfaceSubtle,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: selected ? P.primary : p.border,
                                    ),
                                  ),
                                  child: Text(
                                    tone.label,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: selected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: selected
                                          ? Colors.white
                                          : p.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),

                    Obx(() {
                        if (controller.selectedTone.value != 'custom') {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: TextField(
                            controller: controller.customToneController,
                            style: TextStyle(
                              fontSize: 14,
                              color: p.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: 'E.g. Firm but polite, persuasive...',
                              hintStyle: TextStyle(
                                fontSize: 13.5,
                                color: p.textMuted,
                              ),
                              filled: true,
                              fillColor: p.surfaceSubtle,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: p.border),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: p.border),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: P.primary,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      
                    const SizedBox(height: 16),

                    Obx(() {
                      final isBusy = controller.status.value ==
                          GenerationStatus.generating;
                      return SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: isBusy
                              ? null
                              : () {
                                  HapticFeedback.mediumImpact();
                                  controller.generateStateTitle.value = '';
                                  controller.generateReply();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: P.primary,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                P.primary.withValues(alpha: 0.5),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isBusy
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Generating...',
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.auto_awesome_rounded, size: 16),
                                    SizedBox(width: 8),
                                    Text(
                                      'Generate reply',
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: p.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: p.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Generated reply',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: p.textPrimary,
                          ),
                        ),
                        Obx(() {
                          if (controller.generatedReply.value.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Row(
                            children: [
                              _ActionPillButton(
                                p: p,
                                icon: Icons.tune_rounded,
                                label: 'Improve',
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  controller.moveGeneratedToImprove();
                                },
                              ),
                              const SizedBox(width: 8),
                              _ActionPillButton(
                                p: p,
                                icon: controller.hasCopiedGenerate.value
                                    ? Icons.check_rounded
                                    : Icons.copy_rounded,
                                label: controller.hasCopiedGenerate.value
                                    ? 'Copied'
                                    : 'Copy',
                                isSuccess: controller.hasCopiedGenerate.value,
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  controller.copyGenerated();
                                },
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(color: p.borderSubtle, height: 1),
                    const SizedBox(height: 12),
                    Obx(() {
                      if (controller.generatedReply.value.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Icon(Icons.notes_rounded,
                                  size: 16, color: p.textMuted),
                              const SizedBox(width: 8),
                              Text(
                                'Your generated reply will appear here.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: p.textMuted,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return TextField(
                        controller: controller.outputController,
                        maxLines: null,
                        minLines: 4,
                        style: TextStyle(
                          fontSize: 14,
                          color: p.textPrimary,
                          height: 1.55,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.transparent,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterCounterBar extends StatelessWidget {
  final P p;
  final int count;

  const _CharacterCounterBar({required this.p, required this.count});

  @override
  Widget build(BuildContext context) {
    final bool isUnderMin = count > 0 && count < 30;
    final bool isValid = count >= 30 && count <= 4000;

    Color statusColor = p.textMuted;
    if (isUnderMin) statusColor = P.warning;
    if (isValid) statusColor = P.success;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isUnderMin
              ? '${30 - count} more characters required'
              : '30 to 4,000 characters',
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: isUnderMin ? FontWeight.w600 : FontWeight.w400,
            color: statusColor,
          ),
        ),
        Text(
          '$count / 4000',
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: statusColor,
          ),
        ),
      ],
    );
  }
}

class _SmallUtilityBtn extends StatelessWidget {
  final P p;
  final IconData icon;
  final String label;
  final bool isMuted;
  final VoidCallback onTap;

  const _SmallUtilityBtn({
    required this.p,
    required this.icon,
    required this.label,
    this.isMuted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = isMuted ? p.textMuted : P.primaryAccent;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: p.surfaceSubtle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: p.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionPillButton extends StatelessWidget {
  final P p;
  final IconData icon;
  final String label;
  final bool isSuccess;
  final VoidCallback onTap;

  const _ActionPillButton({
    required this.p,
    required this.icon,
    required this.label,
    this.isSuccess = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = isSuccess ? P.success : p.textPrimary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: p.surfaceElevated,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSuccess ? P.success : p.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12.5, color: fg),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}