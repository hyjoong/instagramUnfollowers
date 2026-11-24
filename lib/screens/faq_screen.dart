import 'package:flutter/material.dart';

import '../l10n/gen/app_localizations.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  // Same questions and translations as the web FAQ (FAQ bundle, synced by
  // tool/sync_l10n.dart).
  List<FAQItem> _faqItems(AppLocalizations l10n) => [
        FAQItem(question: l10n.faqIsSafeQuestion, answer: l10n.faqIsSafeAnswer),
        FAQItem(
          question: l10n.faqDownloadTimeQuestion,
          answer: l10n.faqDownloadTimeAnswer,
        ),
        FAQItem(
          question: l10n.faqWhatIsUnfollowerQuestion,
          answer: l10n.faqWhatIsUnfollowerAnswer,
        ),
        FAQItem(question: l10n.faqThreadsQuestion, answer: l10n.faqThreadsAnswer),
        FAQItem(question: l10n.faqIsFreeQuestion, answer: l10n.faqIsFreeAnswer),
        FAQItem(
          question: l10n.faqFileSelectErrorQuestion,
          answer: l10n.faqFileSelectErrorAnswer,
        ),
      ];

  List<FAQCard> _faqCards(AppLocalizations l10n) => [
        FAQCard(
          question: l10n.faqIncorrectListQuestion,
          answer: l10n.faqIncorrectListAnswer,
        ),
        FAQCard(
          question: l10n.faqDataSecurityQuestion,
          answer: l10n.faqDataSecurityAnswer,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final faqItems = _faqItems(l10n);
    final faqCards = _faqCards(l10n);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.faqTitle),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.faqTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // Accordion FAQ Items
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: faqItems.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = faqItems[index];
                  return ExpansionTile(
                    title: Text(
                      item.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(
                          item.answer,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // FAQ Cards
            ...faqCards.map((card) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildFAQCard(card),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQCard(FAQCard card) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              card.answer,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQCard {
  final String question;
  final String answer;

  FAQCard({required this.question, required this.answer});
}
