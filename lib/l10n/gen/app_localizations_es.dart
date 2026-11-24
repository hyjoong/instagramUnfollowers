// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonUnfollowers => 'No te siguen';

  @override
  String get commonFans => 'Fans';

  @override
  String get commonMutual => 'Mutuos';

  @override
  String get commonFollowers => 'Seguidores';

  @override
  String get commonTotalFollowers => 'Seguidores totales';

  @override
  String get commonTotalFollowing => 'Seguidos totales';

  @override
  String get commonNewFollowers => 'Nuevos seguidores';

  @override
  String get commonNotificationPermissionOff =>
      'Las notificaciones están desactivadas. Actívalas en los ajustes de tu dispositivo.';

  @override
  String get navAnalyze => 'Analizar';

  @override
  String get navHistory => 'Historial';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get mainFilePickFailed => 'No se pudo seleccionar el archivo';

  @override
  String get mainPreparingResults => 'Preparando tus resultados';

  @override
  String get mainReminderPrompt =>
      'Sabrás quién dejó de seguirte en tu próximo análisis. ¿Quieres que te avisemos en 2 semanas?';

  @override
  String get mainReminderAction => 'Avisarme';

  @override
  String get mainReminderEnabled =>
      'Te avisaremos en 2 semanas. Puedes desactivarlo en Ajustes.';

  @override
  String get mainExitTitle => 'Salir de la app';

  @override
  String get mainExitMessage => '¿Quieres salir de la app?';

  @override
  String get mainExitConfirm => 'Salir';

  @override
  String get loadingTitle => 'Análisis de unfollowers de Instagram';

  @override
  String get loadingMessage => 'Cargando...';

  @override
  String get errorTitle => 'Error de conexión';

  @override
  String get onboardingWelcomeTitle => 'Te damos la bienvenida a TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'Analiza los datos de seguidores de Instagram para ver quién no te sigue, los seguidores mutuos y las fechas de seguimiento.';

  @override
  String get onboardingSafeTitle => '100 % seguro y privado';

  @override
  String get onboardingSafeBody =>
      'Todos los datos se procesan en tu dispositivo. No recopilamos ni guardamos información personal.';

  @override
  String get onboardingEasyTitle => 'Fácil de usar';

  @override
  String get onboardingEasyBody =>
      'Solo tienes que subir tu archivo de datos de Instagram y verás los resultados al instante.';

  @override
  String get onboardingReadyTitle => 'Todo listo para empezar';

  @override
  String get onboardingReadyBody =>
      '¡Empieza a analizar tus seguidores de Instagram!';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingStart => 'Empezar';

  @override
  String get historyTitle => 'Historial de análisis';

  @override
  String get historyLowOverlap =>
      'Los seguidores de estos dos registros apenas coinciden. Comprueba que sean de la misma cuenta.';

  @override
  String get historyDeleteTitle => 'Eliminar análisis';

  @override
  String get historyDeleteMessage => '¿Quieres eliminar este análisis?';

  @override
  String get historyDeleted => 'Se eliminó el análisis';

  @override
  String get historyDeleteFailed => 'No se pudo eliminar';

  @override
  String get historyShareSubject => 'Resultados del análisis de Instagram';

  @override
  String get historyShareFooter => 'Creado con la app TrackFollows';

  @override
  String get historyCompare => 'Comparar dos registros';

  @override
  String get historyCompareSelected => 'Comparar los registros elegidos';

  @override
  String historyCompareHint(String count) {
    return 'Elige dos registros para comparar ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'No hay historial de análisis';

  @override
  String get historyEmptyBody =>
      'Los resultados de tus análisis aparecerán aquí';

  @override
  String historyExportedOn(String date) {
    return 'Exportado el $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Seguidores $followers · Siguiendo $following · No te siguen $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Análisis: $date';
  }

  @override
  String get historyViewStats => 'Ver estadísticas';

  @override
  String get historyShare => 'Compartir';

  @override
  String get historyFirstRecord =>
      'Primer registro · Compararemos los cambios desde tu próximo análisis';

  @override
  String get historyNoChange =>
      'Sin cambios de seguidores desde el registro anterior';

  @override
  String get historyVsPrevious => 'Respecto al registro anterior';

  @override
  String historyLostCount(String count) {
    return 'Dejaron de seguirte $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'Nuevos seguidores $count';
  }

  @override
  String get statsTitle => 'Resultados del análisis';

  @override
  String get statsNotFoundTitle => 'No se encontraron datos del análisis';

  @override
  String get statsNotFoundBody => 'Estos datos se eliminaron o no existen';

  @override
  String get statsBack => 'Volver';

  @override
  String get statsSummary => 'Resumen del análisis';

  @override
  String get statsNoData => 'No hay datos de análisis';

  @override
  String get statsDistribution => 'Distribución de seguidores';

  @override
  String get statsDetailedStats => 'Estadísticas detalladas';

  @override
  String get statsDetails => 'Detalles';

  @override
  String get statsAnalysisDate => 'Fecha del análisis';

  @override
  String statsMutualRate(String rate) {
    return 'Porcentaje de seguidores mutuos: $rate%';
  }

  @override
  String get compareTitle => 'Comparar registros';

  @override
  String get compareRecentStats => 'Estadísticas del registro más reciente';

  @override
  String compareAnalysisDay(String date) {
    return '$date (día del análisis)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(día del análisis) indica un registro antiguo cuyo nombre de archivo no incluye la fecha de exportación, así que se muestra el día en que se analizó.';

  @override
  String get compareLostTitle => 'Quienes dejaron de seguirte';

  @override
  String get compareLostEmpty => 'Nadie dejó de seguirte en este periodo.';

  @override
  String get compareNewEmpty => 'No hay nuevos seguidores en este periodo.';

  @override
  String get compareRenamedTitle =>
      'Cuentas que cambiaron de nombre de usuario';

  @override
  String get compareDisappearedNote =>
      'Algunas cuentas que desaparecieron de la lista pueden haberse desactivado o eliminado en lugar de dejar de seguirte. Toca el perfil para comprobarlo.';

  @override
  String get compareNoChange => 'Sin cambios';

  @override
  String get compareExportDateNote =>
      'Las fechas indican el día en que se exportó el archivo de Instagram.';

  @override
  String get compareChange => 'Cambio';

  @override
  String get compareLost => 'Dejaron de seguirte';

  @override
  String get appSettingsTitle => 'Ajustes de la app';

  @override
  String get appSettingsAnalysisSection => 'Ajustes de análisis';

  @override
  String get appSettingsDataSection => 'Gestión de datos';

  @override
  String get appSettingsAnalysisNotify => 'Notificaciones de análisis';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Recibe un aviso cuando termine un análisis';

  @override
  String get appSettingsAutoRefresh => 'Actualizar historial automáticamente';

  @override
  String get appSettingsAutoRefreshBody =>
      'Actualiza los datos del historial de forma automática';

  @override
  String get appSettingsClearHistory => 'Eliminar historial de análisis';

  @override
  String get appSettingsClearHistoryBody =>
      'Elimina todos los datos de análisis guardados';

  @override
  String get appSettingsExportAll => 'Exportar todos los datos';

  @override
  String get appSettingsExportAllBody =>
      'Exporta todos los datos de análisis como texto';

  @override
  String get appSettingsClearTitle => 'Eliminar historial';

  @override
  String get appSettingsClearMessage =>
      '¿Quieres eliminar todo el historial de análisis? Esta acción no se puede deshacer.';

  @override
  String get appSettingsCleared =>
      'El historial de análisis se eliminó correctamente';

  @override
  String get appSettingsClearFailed => 'No se pudo eliminar el historial';

  @override
  String get appSettingsNothingToExport =>
      'No hay datos de análisis para exportar';

  @override
  String get appSettingsExportTitle =>
      'Exportación de datos de análisis de TrackFollows';

  @override
  String appSettingsExportCreated(String date) {
    return 'Creado: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Análisis $index';
  }

  @override
  String get appSettingsExportDate => 'Fecha';

  @override
  String get appSettingsExportFailed => 'No se pudieron exportar los datos';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsNotificationsSection => 'Notificaciones';

  @override
  String get settingsRecheckTitle => 'Aviso para volver a comprobar';

  @override
  String get settingsRecheckBody =>
      'Te avisamos 2 semanas después de analizar para que compruebes con un archivo nuevo';

  @override
  String get settingsSupportSection => 'Soporte y aviso legal';

  @override
  String get settingsFaq => 'Preguntas frecuentes';

  @override
  String get settingsTerms => 'Términos de Uso';

  @override
  String get settingsPrivacy => 'Política de Privacidad';

  @override
  String get settingsAdPrivacy => 'Privacidad de los anuncios';

  @override
  String get settingsAppInfoSection => 'Información de la app';

  @override
  String get settingsAboutTitle => 'Acerca de TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows es una herramienta que analiza tus datos de Instagram en tu dispositivo. Puedes consultar cómo los servicios de anuncios tratan la información en la Política de Privacidad.';

  @override
  String settingsVersion(String version, String build) {
    return 'Versión $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. Todos los derechos reservados.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Seguir el idioma del dispositivo';

  @override
  String get settingsOpenLinkFailed => 'No se pudo abrir el enlace.';

  @override
  String get adConsentNotReady =>
      'Vuelve a abrir esta pantalla e inténtalo de nuevo.';

  @override
  String get adConsentPreparing =>
      'Estamos preparando los ajustes de privacidad de anuncios. Inténtalo de nuevo en un momento.';

  @override
  String get adConsentNothingToChange =>
      'Ahora mismo no hay ajustes de privacidad de anuncios que cambiar.';

  @override
  String get adConsentOpenFailed =>
      'No se pudieron abrir los ajustes de privacidad. Inténtalo de nuevo en un momento.';

  @override
  String get adConsentStatusFailed =>
      'No se pudo comprobar el estado de los ajustes de privacidad. Inténtalo de nuevo en un momento.';

  @override
  String get reminderTitle =>
      'Es hora de volver a comprobar quién te dejó de seguir';

  @override
  String get reminderBody =>
      'Han pasado 2 semanas desde tu último análisis. Analiza un archivo nuevo para saber quién dejó de seguirte desde entonces.';

  @override
  String get reminderChannelName => 'Aviso para volver a comprobar';

  @override
  String get reminderChannelDescription =>
      'Te avisa 2 semanas después de analizar para que vuelvas a comprobar con un archivo nuevo';

  @override
  String get faqTitle => 'Preguntas Frecuentes';

  @override
  String get faqIsSafeQuestion => '¿Es seguro este servicio?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows no pide tu contraseña de Instagram ni inicia sesión en tu cuenta. Los archivos seleccionados se analizan en tu dispositivo. La Política de privacidad explica por separado el tratamiento de datos de diagnóstico de uso y de los servicios publicitarios.';

  @override
  String get faqDownloadTimeQuestion =>
      '¿Cuánto tiempo tarda en descargar mis datos?';

  @override
  String get faqDownloadTimeAnswer =>
      'Instagram prepara la exportación. El tiempo de preparación varía; consulta la notificación o la pantalla de exportación y descarga el ZIP cuando esté listo.';

  @override
  String get faqWhatIsUnfollowerQuestion =>
      '¿Qué es exactamente un seguidor no recíproco?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'Son las cuentas que aparecen en tu lista de seguidos, pero no en la de seguidores de los archivos que proporcionas. Pueden incluir cuentas que nunca te siguieron. Una sola exportación no permite saber si alguien te seguía antes ni cuándo dejó de hacerlo.';

  @override
  String get faqThreadsQuestion =>
      '¿También puedo ver quién me dejó de seguir en Threads?';

  @override
  String get faqThreadsAnswer =>
      'Sí. Si el ZIP que descargaste de Instagram incluye tus listas de seguidores y seguidos de Threads, verás un resultado de Threads aparte del de Instagram. Puedes cambiar entre Instagram y Threads en la parte superior de los resultados. Los seguidores de Threads son una lista distinta de tus seguidores de Instagram.';

  @override
  String get faqIsFreeQuestion => '¿Cuesta algo usar este servicio?';

  @override
  String get faqIsFreeAnswer =>
      'No, este servicio es completamente gratuito. Puedes usar todas las funciones sin costo.';

  @override
  String get faqIncorrectListQuestion =>
      'La lista de unfollowers aparece diferente de lo que esperaba. ¿Por qué?';

  @override
  String get faqIncorrectListAnswer =>
      'Los resultados reflejan las listas de tu exportación y pueden diferir de Instagram actualmente. El momento de la exportación, el período elegido y las cuentas eliminadas o desactivadas pueden afectar a las listas y los recuentos.\n\nElige «Desde el principio» al exportar y comprueba que se incluyan todos los archivos de seguidores y seguidos. Una nueva exportación tampoco garantiza que coincida con el estado actual de las cuentas.';

  @override
  String get faqFileSelectErrorQuestion =>
      'No puedo seleccionar el archivo ZIP';

  @override
  String get faqFileSelectErrorAnswer =>
      'Cuando abres el enlace a través de KakaoTalk u otras aplicaciones de mensajería, la selección de archivos puede no funcionar. En este caso, intenta acceder al sitio web directamente a través del navegador Chrome o Samsung Internet y luego selecciona el archivo. La selección de archivos funciona normalmente cuando accedes a través de un navegador directamente.';

  @override
  String get faqDataSecurityQuestion => 'Seguridad de datos y privacidad';

  @override
  String get faqDataSecurityAnswer =>
      'Tus archivos originales de Instagram, nombres de cuenta y listas de seguidores no se envían a ningún servidor para el análisis. Para comparar con tu último análisis, los nombres de usuario de seguidores y seguidos se guardan solo en este dispositivo (navegador o app) y puedes borrarlos cuando quieras con \'Borrar historial\' en la pantalla de resultados. Consulta la Política de privacidad para saber cómo se tratan los datos de diagnóstico y de los servicios publicitarios.';
}
