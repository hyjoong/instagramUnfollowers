import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              '최종 업데이트: 2026년 9월 27일',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '인스타그램 분석 파일',
              '선택한 인스타그램 ZIP·JSON·HTML 파일은 기기에서 분석합니다. 분석을 위해 원본 파일을 서버에 업로드하지 않습니다. 앱의 광고 요청에도 원본 파일이나 계정 목록을 넣지 않습니다.',
            ),
            _buildSection(
              '분석 기록',
              '계정명, 관계 날짜, 분석 시각과 인원 수가 포함된 최근 분석 기록을 기기에 최대 50개 저장할 수 있습니다. 히스토리에서 개별 기록을 삭제할 수 있습니다. 기록 삭제는 사용자가 선택한 원본 파일이나 외부 서비스의 운영 통계를 삭제하지 않습니다.',
            ),
            _buildSection(
              '이용 통계와 오류 확인',
              '앱 안의 웹 화면은 서비스 개선을 위해 분석 성공·실패, 처리 시간, 파일 형식·크기 구간·구성 통계, 실행 환경과 화면 이용 기록을 미국의 PostHog으로 전송합니다. 직접 구현한 통계에는 원본 파일명·내용, 계정명, 복사 내용이나 피드백 본문을 넣지 않습니다. 일일 집계와 개별 오류 진단 정보는 운영자의 Discord 채널에도 전달됩니다.\n\n같은 탭의 이용 흐름을 연결하는 임의 식별자는 30분 동안 유효합니다. 이 시간이 지나도 이미 전송된 운영 통계가 자동 삭제되는 것은 아닙니다.',
            ),
            _buildSection(
              '웹 화면과 알림 서비스',
              '웹 화면의 Google Analytics·Google Tag Manager는 위 통계와 별도로 동작하며, 웹 광고에는 카카오 AdFit이 사용됩니다. 이 서비스는 쿠키나 기기·접속 정보를 처리할 수 있습니다. 새 앱의 AdMob 화면에서는 AdFit 광고 자리를 숨기지만, 웹 화면의 외부 서비스 연결까지 모두 중지하는 것은 아닙니다.\n\n알림 기능에는 Firebase Cloud Messaging을 사용하며 Google이 앱 설치 식별자 등을 처리할 수 있습니다. 외부 피드백 양식에 직접 제출한 내용은 해당 양식 서비스와 운영자에게 전달됩니다.',
            ),
            _buildSection(
              '광고 서비스',
              '앱에서는 Google AdMob을 사용해 광고를 제공합니다. Google은 광고 제공, 성과 측정, 부정행위 방지를 위해 IP 주소, 기기 식별자, 광고 상호작용 및 진단 정보를 처리할 수 있습니다. 인스타그램 분석 파일이나 분석 결과는 AdMob에 전달하지 않습니다.',
            ),
            _buildSection(
              '광고 개인정보 선택',
              '앱의 AdMob 광고 요청 가능 여부는 Google의 동의 관리 기능으로 확인합니다. 적용 조건에 따라 동의 안내가 표시되며, 선택을 변경할 수 있는 경우 설정에 광고 개인정보 설정 메뉴가 나타납니다. 이 선택은 앱의 AdMob 광고에 적용되며 웹 통계·웹 광고·알림 서비스를 모두 제어하지는 않습니다. 앱은 광고 식별자 접근을 위한 iOS 추적 권한을 요청하지 않습니다.',
            ),
            TextButton(
              onPressed: () async {
                final opened = await launchUrl(
                  Uri.parse(
                      'https://policies.google.com/technologies/ads?hl=ko'),
                  mode: LaunchMode.externalApplication,
                );
                if (!opened && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('브라우저를 열지 못했습니다.')),
                  );
                }
              },
              child: const Text('Google 광고 및 개인정보 안내'),
            ),
            _buildSection(
              '연락처',
              '운영자: 김현중 (Hyeonjoong Kim)\n개인정보 및 삭제 문의: hyjoong12@gmail.com\n외부 서비스의 보관·삭제와 이용자 선택에 관한 자세한 안내는 전체 개인정보 처리방침에서 확인할 수 있습니다.',
            ),
            TextButton(
              onPressed: () async {
                final opened = await launchUrl(
                  Uri.parse('https://trackfollows.com/ko/privacy'),
                  mode: LaunchMode.externalApplication,
                );
                if (!opened && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('브라우저를 열지 못했습니다.')),
                  );
                }
              },
              child: const Text('전체 개인정보 처리방침 보기'),
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
