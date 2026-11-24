// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonRetry => 'Повторить';

  @override
  String get commonUnfollowers => 'Не подписаны';

  @override
  String get commonFans => 'Поклонники';

  @override
  String get commonMutual => 'Взаимные';

  @override
  String get commonFollowers => 'Подписчики';

  @override
  String get commonTotalFollowers => 'Всего подписчиков';

  @override
  String get commonTotalFollowing => 'Всего подписок';

  @override
  String get commonNewFollowers => 'Новые подписчики';

  @override
  String get commonNotificationPermissionOff =>
      'Уведомления отключены. Разрешите их в настройках устройства.';

  @override
  String get navAnalyze => 'Анализ';

  @override
  String get navHistory => 'История';

  @override
  String get navSettings => 'Настройки';

  @override
  String get mainFilePickFailed => 'Не удалось выбрать файл';

  @override
  String get mainPreparingResults => 'Готовим результаты анализа';

  @override
  String get mainReminderPrompt =>
      'Кто отписался от вас, станет видно при следующем анализе. Напомнить через 2 недели?';

  @override
  String get mainReminderAction => 'Напомнить';

  @override
  String get mainReminderEnabled =>
      'Напомним через 2 недели. Это можно отключить в настройках.';

  @override
  String get mainExitTitle => 'Выход из приложения';

  @override
  String get mainExitMessage => 'Выйти из приложения?';

  @override
  String get mainExitConfirm => 'Выйти';

  @override
  String get loadingTitle => 'Анализ отписок в Instagram';

  @override
  String get loadingMessage => 'Загрузка...';

  @override
  String get errorTitle => 'Ошибка подключения';

  @override
  String get onboardingWelcomeTitle => 'Добро пожаловать в TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'Анализируйте данные подписчиков Instagram: смотрите, кто отписался, взаимные подписки и даты подписки.';

  @override
  String get onboardingSafeTitle => '100% безопасно и конфиденциально';

  @override
  String get onboardingSafeBody =>
      'Все данные обрабатываются на вашем устройстве. Личная информация не собирается и не хранится.';

  @override
  String get onboardingEasyTitle => 'Просто в использовании';

  @override
  String get onboardingEasyBody =>
      'Достаточно загрузить файл данных Instagram, и результаты анализа появятся сразу.';

  @override
  String get onboardingReadyTitle => 'Всё готово';

  @override
  String get onboardingReadyBody => 'Начните анализ подписчиков Instagram!';

  @override
  String get onboardingSkip => 'Пропустить';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get onboardingStart => 'Начать';

  @override
  String get historyTitle => 'История анализов';

  @override
  String get historyLowOverlap =>
      'Подписчики в двух записях почти не совпадают. Проверьте, что это записи одного аккаунта.';

  @override
  String get historyDeleteTitle => 'Удалить запись анализа';

  @override
  String get historyDeleteMessage => 'Удалить эту запись анализа?';

  @override
  String get historyDeleted => 'Запись анализа удалена';

  @override
  String get historyDeleteFailed => 'Не удалось удалить';

  @override
  String get historyShareSubject => 'Результат анализа Instagram';

  @override
  String get historyShareFooter => 'Создано в приложении TrackFollows';

  @override
  String get historyCompare => 'Сравнить две записи';

  @override
  String get historyCompareSelected => 'Сравнить выбранные записи';

  @override
  String historyCompareHint(String count) {
    return 'Выберите две записи для сравнения ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'Истории анализов пока нет';

  @override
  String get historyEmptyBody => 'Здесь появятся результаты анализа';

  @override
  String historyExportedOn(String date) {
    return 'Экспорт: $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Подписчики $followers · Подписки $following · Не подписаны $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Анализ: $date';
  }

  @override
  String get historyViewStats => 'Статистика';

  @override
  String get historyShare => 'Поделиться';

  @override
  String get historyFirstRecord =>
      'Первая запись · Изменения будут видны со следующего анализа';

  @override
  String get historyNoChange => 'Подписчики не изменились с прошлой записи';

  @override
  String get historyVsPrevious => 'По сравнению с прошлой записью';

  @override
  String historyLostCount(String count) {
    return 'Отписались $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'Новые подписчики $count';
  }

  @override
  String get statsTitle => 'Результат анализа';

  @override
  String get statsNotFoundTitle => 'Данные анализа не найдены';

  @override
  String get statsNotFoundBody => 'Данные удалены или не существуют';

  @override
  String get statsBack => 'Назад';

  @override
  String get statsSummary => 'Сводка анализа';

  @override
  String get statsNoData => 'Нет данных анализа';

  @override
  String get statsDistribution => 'Распределение подписчиков';

  @override
  String get statsDetailedStats => 'Подробная статистика';

  @override
  String get statsDetails => 'Подробности';

  @override
  String get statsAnalysisDate => 'Дата анализа';

  @override
  String statsMutualRate(String rate) {
    return 'Доля взаимных подписок: $rate%';
  }

  @override
  String get compareTitle => 'Сравнение записей';

  @override
  String get compareRecentStats => 'Статистика последней записи';

  @override
  String compareAnalysisDay(String date) {
    return '$date (день анализа)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(день анализа) отмечает старые записи, в названии файла которых нет даты экспорта, поэтому показан день, когда был сделан анализ.';

  @override
  String get compareLostTitle => 'Кто от вас отписался';

  @override
  String get compareLostEmpty => 'За этот период от вас никто не отписался.';

  @override
  String get compareNewEmpty => 'За этот период новых подписчиков нет.';

  @override
  String get compareRenamedTitle => 'Аккаунты со сменой имени пользователя';

  @override
  String get compareDisappearedNote =>
      'Среди пропавших из списка аккаунтов бывают и отключённые или удалённые, а не только отписавшиеся. Откройте профиль, чтобы проверить.';

  @override
  String get compareNoChange => 'Без изменений';

  @override
  String get compareExportDateNote =>
      'Дата — это день, когда файл был экспортирован из Instagram.';

  @override
  String get compareChange => 'Изменение';

  @override
  String get compareLost => 'Отписки';

  @override
  String get appSettingsTitle => 'Настройки приложения';

  @override
  String get appSettingsAnalysisSection => 'Настройки анализа';

  @override
  String get appSettingsDataSection => 'Управление данными';

  @override
  String get appSettingsAnalysisNotify => 'Уведомление об анализе';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Вы получите уведомление, когда анализ завершится';

  @override
  String get appSettingsAutoRefresh => 'Автообновление истории';

  @override
  String get appSettingsAutoRefreshBody =>
      'Данные истории обновляются автоматически';

  @override
  String get appSettingsClearHistory => 'Удалить историю анализов';

  @override
  String get appSettingsClearHistoryBody =>
      'Удаляет все сохранённые данные анализа';

  @override
  String get appSettingsExportAll => 'Экспорт всех данных';

  @override
  String get appSettingsExportAllBody =>
      'Экспортирует все данные анализа в виде текста';

  @override
  String get appSettingsClearTitle => 'Удаление истории';

  @override
  String get appSettingsClearMessage =>
      'Удалить всю историю анализов? Это действие нельзя отменить.';

  @override
  String get appSettingsCleared => 'История анализов успешно удалена';

  @override
  String get appSettingsClearFailed => 'Не удалось удалить историю';

  @override
  String get appSettingsNothingToExport => 'Нет данных анализа для экспорта';

  @override
  String get appSettingsExportTitle => 'Экспорт данных анализа TrackFollows';

  @override
  String appSettingsExportCreated(String date) {
    return 'Создано: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Анализ $index';
  }

  @override
  String get appSettingsExportDate => 'Дата';

  @override
  String get appSettingsExportFailed => 'Не удалось экспортировать данные';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsNotificationsSection => 'Уведомления';

  @override
  String get settingsRecheckTitle => 'Напоминание о повторной проверке';

  @override
  String get settingsRecheckBody =>
      'Напомним через 2 недели после анализа проверить снова с новым файлом';

  @override
  String get settingsSupportSection => 'Поддержка и правовая информация';

  @override
  String get settingsFaq => 'Часто задаваемые вопросы';

  @override
  String get settingsTerms => 'Условия использования';

  @override
  String get settingsPrivacy => 'Политика конфиденциальности';

  @override
  String get settingsAdPrivacy => 'Конфиденциальность рекламы';

  @override
  String get settingsAppInfoSection => 'О приложении';

  @override
  String get settingsAboutTitle => 'О TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows — инструмент, который анализирует данные Instagram на вашем устройстве. Сведения об обработке данных рекламными сервисами есть в Политике конфиденциальности.';

  @override
  String settingsVersion(String version, String build) {
    return 'Версия $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. Все права защищены.';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageSystem => 'Как на устройстве';

  @override
  String get settingsOpenLinkFailed => 'Не удалось открыть ссылку.';

  @override
  String get adConsentNotReady => 'Откройте экран заново и повторите попытку.';

  @override
  String get adConsentPreparing =>
      'Готовим настройки конфиденциальности рекламы. Повторите попытку чуть позже.';

  @override
  String get adConsentNothingToChange =>
      'Сейчас нет настроек конфиденциальности рекламы, которые можно изменить.';

  @override
  String get adConsentOpenFailed =>
      'Не удалось открыть настройки конфиденциальности. Повторите попытку чуть позже.';

  @override
  String get adConsentStatusFailed =>
      'Не удалось проверить состояние настроек конфиденциальности. Повторите попытку чуть позже.';

  @override
  String get reminderTitle => 'Пора проверить отписки снова';

  @override
  String get reminderBody =>
      'С прошлого анализа прошло 2 недели. Проанализируйте новый файл, чтобы узнать, кто отписался за это время.';

  @override
  String get reminderChannelName => 'Напоминание о повторной проверке';

  @override
  String get reminderChannelDescription =>
      'Напоминает через 2 недели после анализа проверить снова с новым файлом';

  @override
  String get faqTitle => 'Часто задаваемые вопросы';

  @override
  String get faqIsSafeQuestion => 'Этот сервис безопасен?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows не запрашивает пароль Instagram и не входит в ваш аккаунт. Выбранные файлы анализируются на вашем устройстве. Обработка данных диагностики использования и рекламных сервисов отдельно описана в Политике конфиденциальности.';

  @override
  String get faqDownloadTimeQuestion =>
      'Сколько времени занимает загрузка моих данных?';

  @override
  String get faqDownloadTimeAnswer =>
      'Экспорт готовит Instagram. Время подготовки бывает разным. Проверьте уведомление или экран экспорта и скачайте ZIP, когда он будет готов.';

  @override
  String get faqWhatIsUnfollowerQuestion => 'Что такое неподписчики?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'Эти аккаунты есть в списке ваших подписок, но отсутствуют в списке подписчиков в предоставленных файлах. Среди них могут быть те, кто никогда на вас не подписывался. Один экспорт не позволяет установить, был ли человек подписан раньше и когда он отписался.';

  @override
  String get faqThreadsQuestion => 'Можно ли проверить отписки в Threads?';

  @override
  String get faqThreadsAnswer =>
      'Да. Если ZIP, скачанный из Instagram, содержит списки подписчиков и подписок Threads, вы увидите отдельный результат по Threads рядом с результатом Instagram. Переключайтесь между Instagram и Threads в верхней части результатов. Подписчики Threads — это отдельный список, не совпадающий с подписчиками Instagram.';

  @override
  String get faqIsFreeQuestion =>
      'Есть ли плата за использование этого сервиса?';

  @override
  String get faqIsFreeAnswer =>
      'Нет, этот сервис полностью бесплатный. Вы можете использовать все функции без каких-либо затрат';

  @override
  String get faqIncorrectListQuestion =>
      'Список отписавшихся отображается не так, как я ожидал. Почему?';

  @override
  String get faqIncorrectListAnswer =>
      'Результаты отражают списки в экспорте и могут отличаться от текущих данных Instagram. Время экспорта, выбранный период и удалённые или деактивированные аккаунты могут влиять на списки и количество записей.\n\nПри экспорте выберите весь период и проверьте, что включены все файлы подписчиков и подписок. Даже новый экспорт не гарантирует совпадения с текущим состоянием аккаунтов.';

  @override
  String get faqFileSelectErrorQuestion => 'Я не могу выбрать ZIP-файл';

  @override
  String get faqFileSelectErrorAnswer =>
      'При открытии ссылок через мессенджеры, такие как KakaoTalk, функция выбора файла может работать некорректно. В этом случае попробуйте открыть сайт напрямую через браузеры, такие как Chrome или Samsung Internet, чтобы выбрать файл. Обычно, при прямом доступе через браузер, вы можете нормально выбирать файлы.';

  @override
  String get faqDataSecurityQuestion =>
      'Безопасность данных и конфиденциальность';

  @override
  String get faqDataSecurityAnswer =>
      'Исходные файлы Instagram, имена аккаунтов и списки подписчиков не отправляются на сервер для анализа. Чтобы сравнивать с прошлым анализом, имена пользователей подписчиков и подписок сохраняются только на этом устройстве (в браузере или приложении), и их можно удалить в любой момент кнопкой «Удалить историю» на экране результатов. Об обработке данных диагностики и рекламных сервисов читайте в Политике конфиденциальности.';
}
