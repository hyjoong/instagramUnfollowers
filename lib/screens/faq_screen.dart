import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int? _expandedIndex;

  final List<FAQItem> _faqItems = [
    FAQItem(
      question: "이 서비스는 안전한가요?",
      answer:
          "네, 완전히 안전합니다. 저는 웹 개발자로 일하는 평범한 직장인입니다. 사용자의 동의 없이 개인 정보를 수집하거나 해킹하는 것은 불법이며, 이러한 위험한 행동은 법적 책임을 초래할 수 있습니다.\n\nInstagram에서 공식적으로 제공하는 데이터만 사용하고 있으며, ZIP 파일을 직접 열어보시면 해당 계정의 팔로워/팔로잉 목록과 날짜만 포함되어 있음을 확인하실 수 있습니다. 비밀번호나 개인 정보는 포함되어 있지 않습니다.\n\n자세한 내용은 개인정보처리방침에서 확인하실 수 있습니다. 제 연락처(trackfollows@google.com)는 공개되어 있으며, 언제든지 연락하실 수 있습니다.\n\n모든 데이터는 사용자의 브라우저에서만 처리되며 서버로 전송되지 않습니다. 업로드된 파일은 분석 후 자동으로 삭제되며 어디에도 저장되지 않습니다.",
    ),
    FAQItem(
      question: "데이터 다운로드에 얼마나 시간이 걸리나요?",
      answer:
          "인스타그램에 데이터를 요청하고 실제 다운로드 링크를 받기까지 팔로워와 팔로잉 수에 따라 몇 분에서 몇 시간까지 걸릴 수 있습니다.",
    ),
    FAQItem(
      question: "언팔로워란 정확히 무엇인가요?",
      answer:
          "언팔로워란 당신이 팔로우하고 있지만 당신을 팔로우하지 않는 사용자를 의미합니다. 즉, 맞팔이 아닌 사람들입니다. TrackFollows는 이러한 사용자를 쉽게 식별할 수 있도록 도와줍니다.",
    ),
    FAQItem(
      question: "이 서비스를 사용하는데 비용이 드나요?",
      answer: "아니요, 이 서비스는 완전 무료입니다. 모든 기능을 무료로 이용하실 수 있습니다.",
    ),
    FAQItem(
      question: "ZIP 파일을 선택할 수 없어요",
      answer:
          "카카오톡 등의 메시징 앱에서 링크를 열었을 때 파일 선택 기능이 정상적으로 작동하지 않을 수 있습니다. 이 경우 Chrome이나 Samsung Internet 등의 브라우저에서 직접 사이트에 접속하여 파일을 선택해보세요. 브라우저에서 직접 접속하면 일반적으로 파일을 정상적으로 선택할 수 있습니다",
    ),
  ];

  final List<FAQCard> _faqCards = [
    FAQCard(
      question: "언팔로워 목록이 예상과 다르게 표시됩니다. 왜 그런가요?",
      answer:
          "인스타그램에서 데이터를 다운로드할 때 '전체 기간' 대신 '특정 기간'을 선택했을 수 있습니다. 정확한 분석을 위해서는 반드시 '전체 기간'으로 데이터를 다운로드해야 합니다.\n\n또한, 인스타그램에서 데이터 요청 시점과 실제 데이터 다운로드 시점 사이에 시간 차이(몇 시간에서 며칠)가 있을 수 있습니다. 이 기간 동안 팔로워나 팔로잉 상태가 변경되었다면, 현재 계정 상태와 분석 결과가 다르게 나타날 수 있습니다. 분석 결과는 데이터 요청 시점을 기준으로 하기 때문입니다.",
    ),
    FAQCard(
      question: "데이터 보안 및 개인정보 보호",
      answer:
          "모든 처리는 사용자의 브라우저에서만 이루어집니다. 데이터는 어떤 서버로도 전송되지 않으며, 분석 후 자동으로 삭제되며 어디에도 저장되지 않습니다. 개인정보를 전혀 수집하지 않으며 모든 분석이 브라우저 내에서 이루어집니다.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('자주 묻는 질문'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '자주 묻는 질문',
              style: TextStyle(
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
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _faqItems.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _faqItems[index];
                  final isExpanded = _expandedIndex == index;

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
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
              childAspectRatio: 2.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: _faqCards.map((card) => _buildFAQCard(card)).toList(),
            ),
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
            color: Colors.grey.withOpacity(0.1),
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
            Expanded(
              child: Text(
                card.answer,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.4,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
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
