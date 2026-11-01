import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: "이 서비스는 안전한가요?",
      answer:
          "인스타그램 비밀번호를 받거나 계정에 로그인하지 않습니다. Instagram에서 공식적으로 제공하는 내보내기 파일만 사용하며, ZIP 파일을 직접 열어보시면 해당 계정의 팔로워/팔로잉 목록과 날짜만 포함되어 있음을 확인하실 수 있습니다.\n\n선택한 파일은 기기에서 분석하며, 원본 파일과 팔로워·팔로잉 목록을 서버에 업로드하지 않습니다. 다만 앱에는 광고(AdMob)가 포함되어 있고, 서비스 개선을 위한 이용 통계와 오류 정보는 개인정보처리방침에 따라 처리됩니다.\n\n궁금한 점은 hyjoong12@gmail.com으로 언제든지 문의해 주세요.",
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
          "인스타그램에서 데이터를 다운로드할 때 기간을 '전체 기간'이 아닌 '작년'(기본값)이나 '최근 3년' 등으로 선택했을 수 있습니다. 정확한 분석을 위해서는 반드시 '전체 기간'으로 데이터를 다운로드해야 합니다.\n\n또한, 인스타그램에서 데이터 요청 시점과 실제 데이터 다운로드 시점 사이에 시간 차이(몇 시간에서 며칠)가 있을 수 있습니다. 이 기간 동안 팔로워나 팔로잉 상태가 변경되었다면, 현재 계정 상태와 분석 결과가 다르게 나타날 수 있습니다. 분석 결과는 데이터 요청 시점을 기준으로 하기 때문입니다.",
    ),
    FAQCard(
      question: "데이터 보안 및 개인정보 보호",
      answer:
          "선택한 인스타그램 파일은 기기에서 분석하며, 원본 파일과 팔로워·팔로잉 목록을 서버에 업로드하지 않습니다. 광고와 이용 통계 등 앱이 처리하는 정보는 설정의 개인정보처리방침에서 확인할 수 있습니다.",
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
                itemCount: _faqItems.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _faqItems[index];
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
            ..._faqCards.map((card) => Padding(
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
