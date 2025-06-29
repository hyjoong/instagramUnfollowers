import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이용약관'),
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
              '이용약관',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '최종 업데이트: 2025년 3월 22일',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. 약관 동의',
              'TrackFollows를 접속하고 사용함으로써, 귀하는 이용약관을 읽고, 이해하며, 이에 동의함을 인정합니다. 이 약관의 어느 부분에도 동의하지 않는 경우, 본 서비스를 이용하지 않을 수 있습니다.',
            ),
            _buildSection(
              '2. 서비스 설명',
              'TrackFollows는 사용자가 인스타그램 팔로워 데이터를 분석하여 언팔로워, 맞팔 상태, 팔로우 날짜 등을 식별할 수 있는 웹 기반 도구를 제공합니다. 모든 처리는 브라우저의 클라이언트 측에서 이루어집니다.',
            ),
            _buildSection(
              '3. 개인정보 및 데이터 보안',
              '귀하의 개인정보 보호가 우리의 우선순위입니다. 모든 데이터 처리는 귀하의 브라우저에서 이루어지며, 인스타그램 데이터는 서버에 저장되지 않습니다. 자세한 내용은 개인정보 처리방침을 참조하세요.',
            ),
            _buildSection(
              '4. 사용자 책임',
              '귀하는 자신의 인스타그램 데이터를 얻고 그것에 접근하고 분석할 권리가 있는지 확인할 책임이 있습니다. TrackFollows는 인스타그램과 제휴하지 않으며, 본 서비스 사용은 인스타그램의 서비스 약관을 준수해야 합니다.',
            ),
            _buildSection(
              '5. 지적 재산권',
              '디자인, 텍스트, 그래픽, 로고, 코드를 포함하되 이에 제한되지 않는 TrackFollows의 모든 콘텐츠, 기능, 기능성은 TrackFollows의 독점 자산이며 국제 저작권, 상표 및 기타 지적 재산권법에 의해 보호됩니다.',
            ),
            _buildSection(
              '6. 책임의 제한',
              'TrackFollows는 어떠한 종류의 보증도 없이 \'있는 그대로\' 제공됩니다. 당사는 본 서비스의 사용 또는 사용 불능으로 인한 직접적, 간접적, 우발적, 특별 또는 결과적 손해에 대해 책임을 지지 않습니다.',
            ),
            _buildSection(
              '7. 서비스 수정',
              '당사는 사전 통지 없이 언제든지 TrackFollows 또는 그 일부를 수정, 중단 또는 중지할 권리를 보유합니다. 당사는 그러한 수정, 중단 또는 중지에 대해 귀하나 제3자에게 책임을 지지 않습니다.',
            ),
            _buildSection(
              '8. 준거법',
              '이 약관은 법률 충돌 조항에 관계없이 대한민국 법률에 따라 관리되고 해석됩니다.',
            ),
            _buildSection(
              '9. 문의하기',
              '이 약관에 대해 질문이 있으시면 trackfollows@google.com으로 문의해 주세요.',
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TrackFollows',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEC4899),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '인스타그램 언팔로워 분석 서비스',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
