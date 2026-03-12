import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/generator_controller.dart';
import 'theme_tokens.dart';
import 'widgets/product_app_bar.dart';
import 'widgets/product_bottom_nav.dart';
import 'widgets/home_overview_tab.dart';
import 'widgets/generate_workspace_tab.dart';
import 'widgets/improve_workspace_tab.dart';
import 'widgets/about_product_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GeneratorController controller;
  Worker? _genWorker;
  Worker? _impWorker;

  @override
  void initState() {
    super.initState();
    controller = Get.put(GeneratorController());

    _genWorker = ever<String>(controller.generateStateTitle, (title) {
      if (title.isEmpty || title == 'Generating') return;
      _showTopPopup(
        title: title,
        subtitle: controller.generateStateSubtitle.value,
        isError: controller.generateStateIsError.value,
      );
    });

    _impWorker = ever<String>(controller.improveStateTitle, (title) {
      if (title.isEmpty || title == 'Improving') return;
      _showTopPopup(
        title: title,
        subtitle: controller.improveStateSubtitle.value,
        isError: controller.improveStateIsError.value,
      );
    });
  }

  @override
  void dispose() {
    _genWorker?.dispose();
    _impWorker?.dispose();
    super.dispose();
  }

  void _showTopPopup({
    required String title,
    required String subtitle,
    required bool isError,
  }) {
    if (!mounted) return;

    if (isError) {
      HapticFeedback.heavyImpact();
    } else {
      HapticFeedback.lightImpact();
    }

    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: EdgeInsets.zero,
      duration: Duration(seconds: isError ? 4 : 2),
      animationDuration: const Duration(milliseconds: 260),
      messageText: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isError ? const Color(0xFF1F0910) : const Color(0xFF071F1C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isError
                ? P.danger.withValues(alpha: 0.45)
                : P.success.withValues(alpha: 0.45),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (isError ? P.danger : P.success)
                    .withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isError
                    ? Icons.error_outline_rounded
                    : Icons.check_rounded,
                size: 16,
                color: isError ? const Color(0xFFF87171) : P.success,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFCBD5E1),
                        height: 1.35,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => Get.closeCurrentSnackbar(),
              child: const Icon(
                Icons.close_rounded,
                size: 16,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final p = P(controller.isDarkMode.value);

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: p.isDark
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: p.surface,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: p.surface,
              ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: p.bg,
            appBar: ProductAppBar(controller: controller, p: p),
            body: SafeArea(
              child: IndexedStack(
                index: controller.currentNavIndex.value,
                children: [
                  HomeOverviewTab(controller: controller, p: p),
                  GenerateWorkspaceTab(controller: controller, p: p),
                  ImproveWorkspaceTab(controller: controller, p: p),
                  AboutProductTab(
                    p: p,
                    onCopied: (label) => _showTopPopup(
                      title: 'Copied to clipboard',
                      subtitle: label,
                      isError: false,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: ProductBottomNav(controller: controller, p: p),
          ),
        ),
      );
    });
  }
}