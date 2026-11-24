// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonDelete => '削除';

  @override
  String get commonRetry => '再試行';

  @override
  String get commonUnfollowers => 'フォロー解除した人';

  @override
  String get commonFans => 'ファン';

  @override
  String get commonMutual => '相互フォロー';

  @override
  String get commonFollowers => 'フォロワー';

  @override
  String get commonTotalFollowers => 'フォロワー合計';

  @override
  String get commonTotalFollowing => 'フォロー中合計';

  @override
  String get commonNewFollowers => '新しいフォロワー';

  @override
  String get commonNotificationPermissionOff =>
      '通知がオフになっています。端末の設定で通知を許可してください。';

  @override
  String get navAnalyze => '分析';

  @override
  String get navHistory => '履歴';

  @override
  String get navSettings => '設定';

  @override
  String get mainFilePickFailed => 'ファイルの選択に失敗しました';

  @override
  String get mainPreparingResults => '分析結果を準備しています';

  @override
  String get mainReminderPrompt => '誰にフォロー解除されたかは、次回の分析でわかります。2週間後にお知らせしましょうか？';

  @override
  String get mainReminderAction => '通知を受け取る';

  @override
  String get mainReminderEnabled => '2週間後にお知らせします。設定でオフにできます。';

  @override
  String get mainExitTitle => 'アプリを終了';

  @override
  String get mainExitMessage => 'アプリを終了しますか？';

  @override
  String get mainExitConfirm => '終了';

  @override
  String get loadingTitle => 'Instagramフォロー解除分析';

  @override
  String get loadingMessage => '読み込み中...';

  @override
  String get errorTitle => '接続エラー';

  @override
  String get onboardingWelcomeTitle => 'TrackFollowsへようこそ';

  @override
  String get onboardingWelcomeBody =>
      'Instagramのフォロワーデータを分析して、フォロー解除した人や相互フォローの状況、フォロー日を確認しましょう。';

  @override
  String get onboardingSafeTitle => '100%安全でプライバシーも安心';

  @override
  String get onboardingSafeBody => 'すべてのデータ処理は端末内で行われます。個人情報の収集や保存は一切ありません。';

  @override
  String get onboardingEasyTitle => 'かんたんに使えます';

  @override
  String get onboardingEasyBody =>
      'Instagramのデータファイルをアップロードするだけで、すぐに分析結果を確認できます。';

  @override
  String get onboardingReadyTitle => '準備ができました';

  @override
  String get onboardingReadyBody => 'Instagramのフォロワー分析を始めましょう！';

  @override
  String get onboardingSkip => 'スキップ';

  @override
  String get onboardingNext => '次へ';

  @override
  String get onboardingStart => 'はじめる';

  @override
  String get historyTitle => '分析履歴';

  @override
  String get historyLowOverlap =>
      '2つの記録でフォロワーがほとんど重なっていません。同じアカウントの記録か確認してください。';

  @override
  String get historyDeleteTitle => '分析記録を削除';

  @override
  String get historyDeleteMessage => 'この分析記録を削除しますか？';

  @override
  String get historyDeleted => '分析記録を削除しました';

  @override
  String get historyDeleteFailed => '削除に失敗しました';

  @override
  String get historyShareSubject => 'Instagram分析結果';

  @override
  String get historyShareFooter => 'TrackFollowsアプリで作成';

  @override
  String get historyCompare => '2つの記録を比較';

  @override
  String get historyCompareSelected => '選んだ2つの記録を比較';

  @override
  String historyCompareHint(String count) {
    return '比較する記録を2つ選んでください（$count/2）';
  }

  @override
  String get historyEmptyTitle => '分析履歴がありません';

  @override
  String get historyEmptyBody => '分析結果はここに表示されます';

  @override
  String historyExportedOn(String date) {
    return '$date にエクスポート';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'フォロワー $followers · フォロー中 $following · フォロー解除 $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return '分析日: $date';
  }

  @override
  String get historyViewStats => '統計を見る';

  @override
  String get historyShare => '共有';

  @override
  String get historyFirstRecord => '最初の記録 · 次回の分析から変化を比較します';

  @override
  String get historyNoChange => '前回の記録からフォロワーの変化はありません';

  @override
  String get historyVsPrevious => '前回の記録との比較';

  @override
  String historyLostCount(String count) {
    return '解除 $count';
  }

  @override
  String historyGainedCount(String count) {
    return '新規フォロワー $count';
  }

  @override
  String get statsTitle => '分析結果';

  @override
  String get statsNotFoundTitle => '分析データが見つかりません';

  @override
  String get statsNotFoundBody => '削除されたか、存在しないデータです';

  @override
  String get statsBack => '戻る';

  @override
  String get statsSummary => '分析の概要';

  @override
  String get statsNoData => '分析データがありません';

  @override
  String get statsDistribution => 'フォロワーの内訳';

  @override
  String get statsDetailedStats => '詳細な統計';

  @override
  String get statsDetails => '詳細情報';

  @override
  String get statsAnalysisDate => '分析日';

  @override
  String statsMutualRate(String rate) {
    return '相互フォローの割合: $rate%';
  }

  @override
  String get compareTitle => '記録を比較';

  @override
  String get compareRecentStats => '最新の記録の統計';

  @override
  String compareAnalysisDay(String date) {
    return '$date（分析日）';
  }

  @override
  String get compareAnalysisDayNote =>
      '（分析日）は、ファイル名にエクスポート日がない古い記録のため、分析した日を表示しています。';

  @override
  String get compareLostTitle => 'あなたをフォロー解除した人';

  @override
  String get compareLostEmpty => 'この期間にフォロー解除した人はいません。';

  @override
  String get compareNewEmpty => 'この期間に増えたフォロワーはいません。';

  @override
  String get compareRenamedTitle => 'ユーザーネームを変更したアカウント';

  @override
  String get compareDisappearedNote =>
      'リストから消えたアカウントには、フォロー解除ではなく、アカウントを停止・削除した場合もあります。プロフィールをタップして確認してみてください。';

  @override
  String get compareNoChange => '変化なし';

  @override
  String get compareExportDateNote => '日付はInstagramからファイルをエクスポートした日です。';

  @override
  String get compareChange => '増減';

  @override
  String get compareLost => '解除';

  @override
  String get appSettingsTitle => 'アプリ設定';

  @override
  String get appSettingsAnalysisSection => '分析設定';

  @override
  String get appSettingsDataSection => 'データ管理';

  @override
  String get appSettingsAnalysisNotify => '分析通知';

  @override
  String get appSettingsAnalysisNotifyBody => '分析が完了したら通知を受け取ります';

  @override
  String get appSettingsAutoRefresh => '履歴の自動更新';

  @override
  String get appSettingsAutoRefreshBody => '履歴データを自動で更新します';

  @override
  String get appSettingsClearHistory => '分析履歴を削除';

  @override
  String get appSettingsClearHistoryBody => '保存されているすべての分析データを削除します';

  @override
  String get appSettingsExportAll => 'すべてのデータをエクスポート';

  @override
  String get appSettingsExportAllBody => 'すべての分析データをテキストでエクスポートします';

  @override
  String get appSettingsClearTitle => '履歴を削除';

  @override
  String get appSettingsClearMessage => 'すべての分析履歴を削除しますか？この操作は元に戻せません。';

  @override
  String get appSettingsCleared => '分析履歴を削除しました';

  @override
  String get appSettingsClearFailed => '履歴の削除に失敗しました';

  @override
  String get appSettingsNothingToExport => 'エクスポートできる分析データがありません';

  @override
  String get appSettingsExportTitle => 'TrackFollows分析データのエクスポート';

  @override
  String appSettingsExportCreated(String date) {
    return '作成日: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return '分析 $index';
  }

  @override
  String get appSettingsExportDate => '日付';

  @override
  String get appSettingsExportFailed => 'データのエクスポートに失敗しました';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsNotificationsSection => '通知';

  @override
  String get settingsRecheckTitle => '再確認の通知';

  @override
  String get settingsRecheckBody => '分析から2週間後に、新しいファイルで確認するようお知らせします';

  @override
  String get settingsSupportSection => 'サポートと法的情報';

  @override
  String get settingsFaq => 'よくある質問';

  @override
  String get settingsTerms => '利用規約';

  @override
  String get settingsPrivacy => 'プライバシーポリシー';

  @override
  String get settingsAdPrivacy => '広告のプライバシー設定';

  @override
  String get settingsAppInfoSection => 'アプリ情報';

  @override
  String get settingsAboutTitle => 'TrackFollowsについて';

  @override
  String get settingsAboutBody =>
      'TrackFollowsは、Instagramのデータを端末内で分析するツールです。広告サービスによる情報の取り扱いについては、プライバシーポリシーをご確認ください。';

  @override
  String settingsVersion(String version, String build) {
    return 'バージョン $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. All rights reserved.';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageSystem => '端末の言語に合わせる';

  @override
  String get settingsOpenLinkFailed => 'リンクを開けませんでした。';

  @override
  String get adConsentNotReady => '画面を開き直してから、もう一度お試しください。';

  @override
  String get adConsentPreparing => '広告のプライバシー設定を準備しています。しばらくしてからもう一度お試しください。';

  @override
  String get adConsentNothingToChange => '現在、変更できる広告のプライバシー設定はありません。';

  @override
  String get adConsentOpenFailed => 'プライバシー設定を開けませんでした。しばらくしてからもう一度お試しください。';

  @override
  String get adConsentStatusFailed =>
      'プライバシー設定の状態を確認できませんでした。しばらくしてからもう一度お試しください。';

  @override
  String get reminderTitle => 'フォロー解除を再確認するタイミングです';

  @override
  String get reminderBody =>
      '前回の分析から2週間が経ちました。新しいファイルで分析すると、その間にフォロー解除した人がわかります。';

  @override
  String get reminderChannelName => '再確認の通知';

  @override
  String get reminderChannelDescription => '分析から2週間後に、新しいファイルで再確認するようお知らせします';

  @override
  String get faqTitle => 'よくある質問';

  @override
  String get faqIsSafeQuestion => 'このサービスは安全ですか？';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollowsはInstagramのパスワードを求めたり、アカウントにログインしたりしません。選択したファイルは端末で解析します。利用状況・エラーの診断や広告サービスでのデータの取り扱いは、プライバシーポリシーをご覧ください。';

  @override
  String get faqDownloadTimeQuestion => 'データのダウンロードにはどれくらい時間がかかりますか？';

  @override
  String get faqDownloadTimeAnswer =>
      'エクスポートはInstagramが準備します。所要時間は一定ではありません。通知またはエクスポート画面を確認し、準備ができたらZIPをダウンロードしてください。';

  @override
  String get faqWhatIsUnfollowerQuestion => 'フォロー解除者とは正確には何ですか？';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      '提供されたファイルの「フォロー中」には存在し、「フォロワー」には存在しないアカウントです。最初からあなたをフォローしていないアカウントも含まれる場合があります。1回分のエクスポートだけでは、以前あなたをフォローしていたか、いつ解除したかは確認できません。';

  @override
  String get faqThreadsQuestion => 'Threads(スレッズ)のフォロー解除も確認できますか?';

  @override
  String get faqThreadsAnswer =>
      'はい。Instagramからダウンロードした ZIP に Threads のフォロワー・フォロー中のリストが含まれていれば、Instagram とは別に Threads の結果を表示します。結果画面の上部で Instagram と Threads を切り替えられます。Threads のフォロワーは Instagram のフォロワーとは別のリストです。';

  @override
  String get faqIsFreeQuestion => 'このサービスを使用するのにコストがかかりますか？';

  @override
  String get faqIsFreeAnswer => 'いいえ、このサービスは完全に無料です。すべての機能を無料でご利用いただけます。';

  @override
  String get faqIncorrectListQuestion => 'フォロー解除者リストが実際と異なって表示されます。なぜですか？';

  @override
  String get faqIncorrectListAnswer =>
      '分析結果はエクスポートファイル内のリストに基づくため、現在のInstagramの表示と異なる場合があります。エクスポートの時点、指定した期間、アカウントの削除や利用解除などがリストや件数に影響する可能性があります。\n\nエクスポートの期間を「全期間」にし、フォロワーとフォロー中のファイルがすべて含まれているか確認してください。新しいファイルでも現在のアカウント状態との一致は保証できません。';

  @override
  String get faqFileSelectErrorQuestion => 'ZIPファイルを選択できません';

  @override
  String get faqFileSelectErrorAnswer =>
      'KakaoTalkなどのメッセージングアプリからリンクを開いた場合、ファイル選択機能が正常に動作しない場合があります。その場合は、ChromeやSamsung Internetなどのブラウザから直接サイトにアクセスしてファイルを選択してください。通常、ブラウザから直接アクセスすると正常にファイルを選択できます';

  @override
  String get faqDataSecurityQuestion => 'データセキュリティとプライバシー';

  @override
  String get faqDataSecurityAnswer =>
      '解析のためにInstagramの元ファイル、アカウント名、フォロワーのリストをサーバーに送信することはありません。前回の分析と比較できるよう、フォロワー・フォロー中のユーザーネームのリストをこの端末（ブラウザまたはアプリ）にのみ保存し、結果画面の「履歴を削除」でいつでも削除できます。利用状況・エラーの診断や広告サービスでのデータの取り扱いは、プライバシーポリシーをご確認ください。';
}
