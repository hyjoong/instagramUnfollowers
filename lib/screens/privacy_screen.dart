import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('개인정보 처리방침'),
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
              '개인정보 처리방침',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '최종 업데이트: 2025년 4월 14일',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '수집하는 정보',
              'TrackFollows는 사용자의 인스타그램 데이터(ZIP 파일)를 분석하여 언팔로워, 맞팔 상태, 팔로우 날짜를 확인하는 서비스를 제공합니다. 모든 데이터 처리는 사용자의 브라우저에서만 이루어지며, 서버로 전송되지 않습니다. 업로드된 파일은 분석 후 자동으로 삭제되며 어디에도 저장되지 않습니다.',
            ),
            _buildSection(
              '데이터 보안',
              '모든 데이터 처리는 사용자의 브라우저에서만 이루어지며, 서버로 전송되지 않습니다. 업로드된 파일은 분석 후 자동으로 삭제되며 어디에도 저장되지 않습니다.',
            ),
            _buildSection(
              '연락처',
              '개인정보 처리방침에 대한 문의사항이 있으시면 trackfollows@google.com으로 연락해주세요.',
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
