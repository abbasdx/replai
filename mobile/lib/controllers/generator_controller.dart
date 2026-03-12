// import 'package:email_writer_flutter/controllers/api_exception.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../config/api_config.dart';
// import '../services/sharing_service.dart';
// import '../models/reply_request.dart';
// import '../services/reply_generator_service.dart';

// enum GenerationStatus { idle, generating, improving, success, error }

// class ToneItem {
//   final String label;
//   final String value;
//   final String description;

//   const ToneItem({
//     required this.label,
//     required this.value,
//     required this.description,
//   });
// }

// class ActionItem {
//   final String label;
//   final String value;

//   const ActionItem({
//     required this.label,
//     required this.value,
//   });
// }

// class GeneratorController extends GetxController {
//   final ReplyGeneratorService _service;
//   final SharingService _sharingService;

//   GeneratorController({
//     ReplyGeneratorService? service,
//     SharingService? sharingService,
//   })  : _service = service ?? ReplyGeneratorService(),
//         _sharingService = sharingService ?? SharingService();

//   // Bottom Navigation: 0 = Home, 1 = Generate, 2 = Improve, 3 = About
//   final RxInt currentNavIndex = 0.obs;

//   // Theme Toggle
//   final RxBool isDarkMode = true.obs;

//   static const List<ToneItem> tones = [
//     ToneItem(
//       label: 'Professional',
//       value: 'professional',
//       description: 'Polished and business-ready',
//     ),
//     ToneItem(
//       label: 'Friendly',
//       value: 'friendly',
//       description: 'Warm, approachable, and personable',
//     ),
//     ToneItem(
//       label: 'Concise',
//       value: 'concise',
//       description: 'Brief, direct, and to the point',
//     ),
//     ToneItem(
//       label: 'Formal',
//       value: 'formal',
//       description: 'Structured, respectful, and traditional',
//     ),
//     ToneItem(
//       label: 'Casual',
//       value: 'casual',
//       description: 'Relaxed and conversational',
//     ),
//   ];

//   static const List<ActionItem> improvementActions = [
//     ActionItem(label: 'Improve professionalism', value: 'professional'),
//     ActionItem(label: 'Fix grammar and clarity', value: 'grammar'),
//     ActionItem(label: 'Make it more concise', value: 'concise'),
//     ActionItem(label: 'Make it warmer and friendlier', value: 'friendly'),
//     ActionItem(label: 'Make it more polite and formal', value: 'formal'),
//   ];

//   // Generate Page State
//   final TextEditingController inputController = TextEditingController();
//   final TextEditingController outputController = TextEditingController();
//   final RxString selectedTone = 'professional'.obs;
//   final RxInt generateCharCount = 0.obs;
//   final RxString generatedReply = ''.obs;
//   final RxBool hasCopiedGenerate = false.obs;
//   final RxString generateStateTitle = ''.obs;
//   final RxString generateStateSubtitle = ''.obs;
//   final RxBool generateStateIsError = false.obs;

//   // Improve Page State
//   final TextEditingController draftController = TextEditingController();
//   final TextEditingController improvedOutputController = TextEditingController();
//   final RxString selectedActionLabel = 'Improve professionalism'.obs;
//   final RxInt improveCharCount = 0.obs;
//   final RxString improvedReply = ''.obs;
//   final RxBool hasCopiedImprove = false.obs;
//   final RxString improveStateTitle = ''.obs;
//   final RxString improveStateSubtitle = ''.obs;
//   final RxBool improveStateIsError = false.obs;

//   final Rx<GenerationStatus> status = GenerationStatus.idle.obs;

//   ToneItem get activeTone => tones.firstWhere(
//         (t) => t.value == selectedTone.value,
//         orElse: () => tones.first,
//       );

//   @override
//   void onInit() {
//     super.onInit();
//     inputController.addListener(() {
//       generateCharCount.value = inputController.text.trim().length;
//     });

//     draftController.addListener(() {
//       improveCharCount.value = draftController.text.trim().length;
//     });

//     _sharingService.initialize(
//       onSharedText: (sharedText) {
//         inputController.text = sharedText;
//         generateCharCount.value = sharedText.trim().length;
//         currentNavIndex.value = 1;
//       },
//     );
//   }

//   void switchTab(int index) {
//     FocusManager.instance.primaryFocus?.unfocus();
//     currentNavIndex.value = index;
//   }

//   void toggleTheme() {
//     isDarkMode.value = !isDarkMode.value;
//   }

//   Future<void> pasteGenerateInput() async {
//     final data = await Clipboard.getData(Clipboard.kTextPlain);
//     final text = data?.text?.trim() ?? '';
//     if (text.isNotEmpty) {
//       inputController.text = text;
//     }
//   }

//   Future<void> pasteImproveInput() async {
//     final data = await Clipboard.getData(Clipboard.kTextPlain);
//     final text = data?.text?.trim() ?? '';
//     if (text.isNotEmpty) {
//       draftController.text = text;
//     }
//   }

//   Future<void> generateReply() async {
//     final text = inputController.text.trim();
//     if (text.length < ApiConfig.minInputCharacters ||
//         text.length > ApiConfig.maxInputCharacters) {
//       generateStateIsError.value = true;
//       generateStateTitle.value = 'Validation error';
//       generateStateSubtitle.value =
//           'Email content must be between 30 and 4000 characters (currently ${text.length}).';
//       return;
//     }

//     FocusManager.instance.primaryFocus?.unfocus();
//     status.value = GenerationStatus.generating;
//     generateStateIsError.value = false;
//     generateStateTitle.value = 'Generating';
//     generateStateSubtitle.value = 'Crafting a ${selectedTone.value} reply...';

//     try {
//       final result = await _service.generateReply(
//         GenerateReplyRequest(
//           emailContent: text,
//           tone: selectedTone.value,
//         ),
//       );
//       outputController.text = result;
//       generatedReply.value = result;
//       status.value = GenerationStatus.success;
//       generateStateIsError.value = false;
//       generateStateTitle.value = 'Ready';
//       generateStateSubtitle.value = 'Generated a ${selectedTone.value} reply.';
//     } on ApiException catch (e) {
//       status.value = GenerationStatus.error;
//       generateStateIsError.value = true;
//       generateStateTitle.value = 'Could not generate reply';
//       generateStateSubtitle.value = e.message;
//     } catch (e) {
//       status.value = GenerationStatus.error;
//       generateStateIsError.value = true;
//       generateStateTitle.value = 'Error';
//       generateStateSubtitle.value = e.toString();
//     }
//   }

//   Future<void> improveDraft() async {
//     final text = draftController.text.trim();
//     if (text.length < ApiConfig.minInputCharacters ||
//         text.length > ApiConfig.maxInputCharacters) {
//       improveStateIsError.value = true;
//       improveStateTitle.value = 'Validation error';
//       improveStateSubtitle.value =
//           'Draft must be between 30 and 4000 characters (currently ${text.length}).';
//       return;
//     }

//     FocusManager.instance.primaryFocus?.unfocus();
//     status.value = GenerationStatus.improving;
//     improveStateIsError.value = false;
//     improveStateTitle.value = 'Improving';
//     improveStateSubtitle.value = 'Refining your draft...';

//     try {
//       final result = await _service.improveReply(
//         ImproveReplyRequest(
//           draftReply: text,
//           improvementAction: selectedActionLabel.value,
//         ),
//       );
//       improvedOutputController.text = result;
//       improvedReply.value = result;
//       status.value = GenerationStatus.success;
//       improveStateIsError.value = false;
//       improveStateTitle.value = 'Ready';
//       improveStateSubtitle.value = 'Improved your draft reply.';
//     } on ApiException catch (e) {
//       status.value = GenerationStatus.error;
//       improveStateIsError.value = true;
//       improveStateTitle.value = 'Could not improve draft';
//       improveStateSubtitle.value = e.message;
//     } catch (e) {
//       status.value = GenerationStatus.error;
//       improveStateIsError.value = true;
//       improveStateTitle.value = 'Error';
//       improveStateSubtitle.value = e.toString();
//     }
//   }

//   void moveGeneratedToImprove() {
//     final reply = outputController.text.trim();
//     if (reply.isEmpty) return;
//     draftController.text = reply;
//     currentNavIndex.value = 2;
//   }

//   Future<void> copyGenerated() async {
//     final text = outputController.text.trim();
//     if (text.isEmpty) return;
//     await Clipboard.setData(ClipboardData(text: text));
//     hasCopiedGenerate.value = true;
//     Future.delayed(const Duration(seconds: 2), () {
//       hasCopiedGenerate.value = false;
//     });
//   }

//   Future<void> copyImproved() async {
//     final text = improvedOutputController.text.trim();
//     if (text.isEmpty) return;
//     await Clipboard.setData(ClipboardData(text: text));
//     hasCopiedImprove.value = true;
//     Future.delayed(const Duration(seconds: 2), () {
//       hasCopiedImprove.value = false;
//     });
//   }

//   @override
//   void onClose() {
//     _sharingService.dispose();
//     inputController.dispose();
//     outputController.dispose();
//     draftController.dispose();
//     improvedOutputController.dispose();
//     super.onClose();
//   }
// }

import 'package:email_writer_flutter/controllers/api_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../config/api_config.dart';
import '../services/sharing_service.dart';
import '../models/reply_request.dart';
import '../services/reply_generator_service.dart';

enum GenerationStatus { idle, generating, improving, success, error }

class ToneItem {
  final String label;
  final String value;
  final String description;

  const ToneItem({
    required this.label,
    required this.value,
    required this.description,
  });
}

class ActionItem {
  final String label;
  final String value;

  const ActionItem({
    required this.label,
    required this.value,
  });
}

class GeneratorController extends GetxController {
  final ReplyGeneratorService _service;
  final SharingService _sharingService;

  GeneratorController({
    ReplyGeneratorService? service,
    SharingService? sharingService,
  })  : _service = service ?? ReplyGeneratorService(),
        _sharingService = sharingService ?? SharingService();

  // Bottom Navigation: 0 = Home, 1 = Generate, 2 = Improve, 3 = About
  final RxInt currentNavIndex = 0.obs;

  // Theme Toggle
  final RxBool isDarkMode = true.obs;

  static const List<ToneItem> tones = [
    ToneItem(
      label: 'Professional',
      value: 'professional',
      description: 'Polished and business-ready',
    ),
    ToneItem(
      label: 'Friendly',
      value: 'friendly',
      description: 'Warm, approachable, and personable',
    ),
    ToneItem(
      label: 'Concise',
      value: 'concise',
      description: 'Brief, direct, and to the point',
    ),
    ToneItem(
      label: 'Formal',
      value: 'formal',
      description: 'Structured, respectful, and traditional',
    ),
    ToneItem(
      label: 'Casual',
      value: 'casual',
      description: 'Relaxed and conversational',
    ),
    ToneItem(
      label: 'Custom',
      value: 'custom',
      description: 'Define your own specific tone',
    ),
  ];

  static const List<ActionItem> improvementActions = [
    ActionItem(label: 'Improve professionalism', value: 'professional'),
    ActionItem(label: 'Fix grammar and clarity', value: 'grammar'),
    ActionItem(label: 'Make it more concise', value: 'concise'),
    ActionItem(label: 'Make it warmer and friendlier', value: 'friendly'),
    ActionItem(label: 'Make it more polite and formal', value: 'formal'),
  ];

  // Generate Page State
  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();
  final TextEditingController customToneController = TextEditingController(); // Added Custom Tone Controller
  final RxString selectedTone = 'professional'.obs;
  final RxInt generateCharCount = 0.obs;
  final RxString generatedReply = ''.obs;
  final RxBool hasCopiedGenerate = false.obs;
  final RxString generateStateTitle = ''.obs;
  final RxString generateStateSubtitle = ''.obs;
  final RxBool generateStateIsError = false.obs;

  // Improve Page State
  final TextEditingController draftController = TextEditingController();
  final TextEditingController improvedOutputController = TextEditingController();
  final RxString selectedActionLabel = 'Improve professionalism'.obs;
  final RxInt improveCharCount = 0.obs;
  final RxString improvedReply = ''.obs;
  final RxBool hasCopiedImprove = false.obs;
  final RxString improveStateTitle = ''.obs;
  final RxString improveStateSubtitle = ''.obs;
  final RxBool improveStateIsError = false.obs;

  final Rx<GenerationStatus> status = GenerationStatus.idle.obs;

  ToneItem get activeTone => tones.firstWhere(
        (t) => t.value == selectedTone.value,
        orElse: () => tones.first,
      );

  @override
  void onInit() {
    super.onInit();
    inputController.addListener(() {
      generateCharCount.value = inputController.text.trim().length;
    });

    draftController.addListener(() {
      improveCharCount.value = draftController.text.trim().length;
    });

    _sharingService.initialize(
      onSharedText: (sharedText) {
        inputController.text = sharedText;
        generateCharCount.value = sharedText.trim().length;
        currentNavIndex.value = 1;
      },
    );
  }

  void switchTab(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    currentNavIndex.value = index;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  Future<void> pasteGenerateInput() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text?.trim() ?? '';
    if (text.isNotEmpty) {
      inputController.text = text;
    }
  }

  Future<void> pasteImproveInput() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text?.trim() ?? '';
    if (text.isNotEmpty) {
      draftController.text = text;
    }
  }

  Future<void> generateReply() async {
    final text = inputController.text.trim();
    if (text.length < ApiConfig.minInputCharacters ||
        text.length > ApiConfig.maxInputCharacters) {
      generateStateIsError.value = true;
      generateStateTitle.value = 'Validation error';
      generateStateSubtitle.value =
          'Email content must be between 30 and 4000 characters (currently ${text.length}).';
      return;
    }

    // Determine the exact tone string to send to the backend
    String finalTone = selectedTone.value;
    if (finalTone == 'custom') {
      finalTone = customToneController.text.trim();
      if (finalTone.isEmpty) {
        generateStateIsError.value = true;
        generateStateTitle.value = 'Validation error';
        generateStateSubtitle.value = 'Please enter a custom tone description.';
        return;
      }
    }

    FocusManager.instance.primaryFocus?.unfocus();
    status.value = GenerationStatus.generating;
    generateStateIsError.value = false;
    generateStateTitle.value = 'Generating';
    generateStateSubtitle.value = 'Crafting a ${selectedTone.value == 'custom' ? 'custom' : selectedTone.value} reply...';

    try {
      final result = await _service.generateReply(
        GenerateReplyRequest(
          emailContent: text,
          tone: finalTone, // Send the custom text if custom is selected
        ),
      );
      outputController.text = result;
      generatedReply.value = result;
      status.value = GenerationStatus.success;
      generateStateIsError.value = false;
      generateStateTitle.value = 'Ready';
      generateStateSubtitle.value = 'Generated a reply.';
    } on ApiException catch (e) {
      status.value = GenerationStatus.error;
      generateStateIsError.value = true;
      generateStateTitle.value = 'Could not generate reply';
      generateStateSubtitle.value = e.message;
    } catch (e) {
      status.value = GenerationStatus.error;
      generateStateIsError.value = true;
      generateStateTitle.value = 'Error';
      generateStateSubtitle.value = e.toString();
    }
  }

  Future<void> improveDraft() async {
    final text = draftController.text.trim();
    if (text.length < ApiConfig.minInputCharacters ||
        text.length > ApiConfig.maxInputCharacters) {
      improveStateIsError.value = true;
      improveStateTitle.value = 'Validation error';
      improveStateSubtitle.value =
          'Draft must be between 30 and 4000 characters (currently ${text.length}).';
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    status.value = GenerationStatus.improving;
    improveStateIsError.value = false;
    improveStateTitle.value = 'Improving';
    improveStateSubtitle.value = 'Refining your draft...';

    try {
      final result = await _service.improveReply(
        ImproveReplyRequest(
          draftReply: text,
          improvementAction: selectedActionLabel.value,
        ),
      );
      improvedOutputController.text = result;
      improvedReply.value = result;
      status.value = GenerationStatus.success;
      improveStateIsError.value = false;
      improveStateTitle.value = 'Ready';
      improveStateSubtitle.value = 'Improved your draft reply.';
    } on ApiException catch (e) {
      status.value = GenerationStatus.error;
      improveStateIsError.value = true;
      improveStateTitle.value = 'Could not improve draft';
      improveStateSubtitle.value = e.message;
    } catch (e) {
      status.value = GenerationStatus.error;
      improveStateIsError.value = true;
      improveStateTitle.value = 'Error';
      improveStateSubtitle.value = e.toString();
    }
  }

  void moveGeneratedToImprove() {
    final reply = outputController.text.trim();
    if (reply.isEmpty) return;
    draftController.text = reply;
    currentNavIndex.value = 2;
  }

  Future<void> copyGenerated() async {
    final text = outputController.text.trim();
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    hasCopiedGenerate.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      hasCopiedGenerate.value = false;
    });
  }

  Future<void> copyImproved() async {
    final text = improvedOutputController.text.trim();
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    hasCopiedImprove.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      hasCopiedImprove.value = false;
    });
  }

  @override
  void onClose() {
    _sharingService.dispose();
    inputController.dispose();
    outputController.dispose();
    draftController.dispose();
    improvedOutputController.dispose();
    customToneController.dispose(); // Don't forget to dispose the new controller!
    super.onClose();
  }
}