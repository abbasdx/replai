class GenerateReplyRequest {
  final String emailContent;
  final String tone;

  const GenerateReplyRequest({
    required this.emailContent,
    required this.tone,
  });

  Map<String, dynamic> toJson() => {
        'emailContent': emailContent.trim(),
        'tone': tone.trim().toLowerCase(),
      };
}

class ImproveReplyRequest {
  final String draftReply;
  final String improvementAction;

  const ImproveReplyRequest({
    required this.draftReply,
    required this.improvementAction,
  });

  Map<String, dynamic> toJson() => {
        'draftReply': draftReply.trim(),
        'draft': draftReply.trim(),
        'emailContent': draftReply.trim(),
        'improvementAction': improvementAction.trim(),
        'action': improvementAction.trim(),
        'instruction': improvementAction.trim(),
      };
}