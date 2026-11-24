// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonUnfollowers => 'Não te seguem';

  @override
  String get commonFans => 'Fãs';

  @override
  String get commonMutual => 'Mútuos';

  @override
  String get commonFollowers => 'Seguidores';

  @override
  String get commonTotalFollowers => 'Total de seguidores';

  @override
  String get commonTotalFollowing => 'Total de seguidos';

  @override
  String get commonNewFollowers => 'Novos seguidores';

  @override
  String get commonNotificationPermissionOff =>
      'As notificações estão desativadas. Permita-as nas configurações do dispositivo.';

  @override
  String get navAnalyze => 'Análise';

  @override
  String get navHistory => 'Histórico';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get mainFilePickFailed => 'Falha ao selecionar o arquivo';

  @override
  String get mainPreparingResults => 'Preparando os resultados da análise';

  @override
  String get mainReminderPrompt =>
      'Você só vai saber quem deixou de te seguir na próxima análise. Quer que a gente avise em 2 semanas?';

  @override
  String get mainReminderAction => 'Me avisar';

  @override
  String get mainReminderEnabled =>
      'Vamos avisar você em 2 semanas. Dá para desativar nos ajustes.';

  @override
  String get mainExitTitle => 'Sair do app';

  @override
  String get mainExitMessage => 'Deseja sair do app?';

  @override
  String get mainExitConfirm => 'Sair';

  @override
  String get loadingTitle => 'Análise de quem não te segue no Instagram';

  @override
  String get loadingMessage => 'Carregando...';

  @override
  String get errorTitle => 'Erro de conexão';

  @override
  String get onboardingWelcomeTitle => 'Boas-vindas ao TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'Analise os dados de seguidores do Instagram e veja quem não te segue, os seguidores mútuos e as datas em que começaram a seguir.';

  @override
  String get onboardingSafeTitle => '100% seguro e privado';

  @override
  String get onboardingSafeBody =>
      'Todo o processamento dos dados é feito no seu dispositivo. Nenhuma informação pessoal é coletada ou armazenada.';

  @override
  String get onboardingEasyTitle => 'Fácil de usar';

  @override
  String get onboardingEasyBody =>
      'Basta enviar o arquivo de dados do Instagram para ver os resultados da análise na hora.';

  @override
  String get onboardingReadyTitle => 'Tudo pronto para começar';

  @override
  String get onboardingReadyBody =>
      'Comece a analisar seus seguidores do Instagram!';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingNext => 'Próximo';

  @override
  String get onboardingStart => 'Começar';

  @override
  String get historyTitle => 'Histórico de análises';

  @override
  String get historyLowOverlap =>
      'Os seguidores dos dois registros quase não coincidem. Verifique se são da mesma conta.';

  @override
  String get historyDeleteTitle => 'Excluir registro de análise';

  @override
  String get historyDeleteMessage => 'Deseja excluir este registro de análise?';

  @override
  String get historyDeleted => 'Registro de análise excluído';

  @override
  String get historyDeleteFailed => 'Falha ao excluir';

  @override
  String get historyShareSubject => 'Resultado da análise do Instagram';

  @override
  String get historyShareFooter => 'Gerado pelo app TrackFollows';

  @override
  String get historyCompare => 'Comparar dois registros';

  @override
  String get historyCompareSelected => 'Comparar os registros selecionados';

  @override
  String historyCompareHint(String count) {
    return 'Escolha dois registros para comparar ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'Nenhum histórico de análises';

  @override
  String get historyEmptyBody => 'Os resultados das análises aparecerão aqui';

  @override
  String historyExportedOn(String date) {
    return 'Exportado em $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Seguidores $followers · Seguindo $following · Não te seguem $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Análise: $date';
  }

  @override
  String get historyViewStats => 'Ver estatísticas';

  @override
  String get historyShare => 'Compartilhar';

  @override
  String get historyFirstRecord =>
      'Primeiro registro · Na próxima análise você verá as mudanças';

  @override
  String get historyNoChange =>
      'Sem mudança de seguidores desde o registro anterior';

  @override
  String get historyVsPrevious => 'Em relação ao registro anterior';

  @override
  String historyLostCount(String count) {
    return 'Deixaram de te seguir $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'Novos seguidores $count';
  }

  @override
  String get statsTitle => 'Resultado da análise';

  @override
  String get statsNotFoundTitle => 'Dados da análise não encontrados';

  @override
  String get statsNotFoundBody => 'Os dados foram excluídos ou não existem';

  @override
  String get statsBack => 'Voltar';

  @override
  String get statsSummary => 'Resumo da análise';

  @override
  String get statsNoData => 'Não há dados de análise';

  @override
  String get statsDistribution => 'Distribuição de seguidores';

  @override
  String get statsDetailedStats => 'Estatísticas detalhadas';

  @override
  String get statsDetails => 'Detalhes';

  @override
  String get statsAnalysisDate => 'Data da análise';

  @override
  String statsMutualRate(String rate) {
    return 'Taxa de seguidores mútuos: $rate%';
  }

  @override
  String get compareTitle => 'Comparar registros';

  @override
  String get compareRecentStats => 'Estatísticas do registro mais recente';

  @override
  String compareAnalysisDay(String date) {
    return '$date (dia da análise)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(dia da análise) indica registros antigos cujo nome de arquivo não traz a data de exportação, então mostramos o dia em que foram analisados.';

  @override
  String get compareLostTitle => 'Quem deixou de te seguir';

  @override
  String get compareLostEmpty => 'Ninguém deixou de te seguir neste período.';

  @override
  String get compareNewEmpty => 'Não há novos seguidores neste período.';

  @override
  String get compareRenamedTitle => 'Contas que mudaram de nome de usuário';

  @override
  String get compareDisappearedNote =>
      'Algumas contas que sumiram da lista podem ter sido desativadas ou excluídas, em vez de terem deixado de te seguir. Toque no perfil para conferir.';

  @override
  String get compareNoChange => 'Sem mudanças';

  @override
  String get compareExportDateNote =>
      'A data é o dia em que o arquivo foi exportado do Instagram.';

  @override
  String get compareChange => 'Variação';

  @override
  String get compareLost => 'Deixaram de te seguir';

  @override
  String get appSettingsTitle => 'Ajustes do app';

  @override
  String get appSettingsAnalysisSection => 'Ajustes de análise';

  @override
  String get appSettingsDataSection => 'Gerenciamento de dados';

  @override
  String get appSettingsAnalysisNotify => 'Notificação de análise';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Você recebe uma notificação quando a análise terminar';

  @override
  String get appSettingsAutoRefresh => 'Atualizar histórico automaticamente';

  @override
  String get appSettingsAutoRefreshBody =>
      'Atualiza os dados do histórico automaticamente';

  @override
  String get appSettingsClearHistory => 'Excluir histórico de análises';

  @override
  String get appSettingsClearHistoryBody =>
      'Exclui todos os dados de análise salvos';

  @override
  String get appSettingsExportAll => 'Exportar todos os dados';

  @override
  String get appSettingsExportAllBody =>
      'Exporta todos os dados de análise como texto';

  @override
  String get appSettingsClearTitle => 'Excluir histórico';

  @override
  String get appSettingsClearMessage =>
      'Deseja excluir todo o histórico de análises? Esta ação não pode ser desfeita.';

  @override
  String get appSettingsCleared => 'Histórico de análises excluído com sucesso';

  @override
  String get appSettingsClearFailed => 'Falha ao excluir o histórico';

  @override
  String get appSettingsNothingToExport =>
      'Não há dados de análise para exportar';

  @override
  String get appSettingsExportTitle =>
      'Exportação de dados de análise do TrackFollows';

  @override
  String appSettingsExportCreated(String date) {
    return 'Criado em: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Análise $index';
  }

  @override
  String get appSettingsExportDate => 'Data';

  @override
  String get appSettingsExportFailed => 'Falha ao exportar os dados';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsNotificationsSection => 'Notificações';

  @override
  String get settingsRecheckTitle => 'Lembrete para verificar de novo';

  @override
  String get settingsRecheckBody =>
      'Avisamos você 2 semanas após a análise para conferir com um arquivo novo';

  @override
  String get settingsSupportSection => 'Suporte e informações legais';

  @override
  String get settingsFaq => 'Perguntas Frequentes';

  @override
  String get settingsTerms => 'Termos de Uso';

  @override
  String get settingsPrivacy => 'Política de Privacidade';

  @override
  String get settingsAdPrivacy => 'Privacidade de anúncios';

  @override
  String get settingsAppInfoSection => 'Informações do app';

  @override
  String get settingsAboutTitle => 'Sobre o TrackFollows';

  @override
  String get settingsAboutBody =>
      'O TrackFollows é uma ferramenta que analisa os dados do Instagram no seu dispositivo. Informações sobre o tratamento de dados pelos serviços de publicidade estão na Política de Privacidade.';

  @override
  String settingsVersion(String version, String build) {
    return 'Versão $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. Todos os direitos reservados.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Usar o idioma do dispositivo';

  @override
  String get settingsOpenLinkFailed => 'Não foi possível abrir o link.';

  @override
  String get adConsentNotReady => 'Reabra a tela e tente novamente.';

  @override
  String get adConsentPreparing =>
      'Estamos preparando as configurações de privacidade de anúncios. Tente novamente em instantes.';

  @override
  String get adConsentNothingToChange =>
      'No momento não há configurações de privacidade de anúncios para alterar.';

  @override
  String get adConsentOpenFailed =>
      'Não foi possível abrir as configurações de privacidade. Tente novamente em instantes.';

  @override
  String get adConsentStatusFailed =>
      'Não foi possível verificar o status das configurações de privacidade. Tente novamente em instantes.';

  @override
  String get reminderTitle => 'Hora de ver quem deixou de te seguir';

  @override
  String get reminderBody =>
      'Já se passaram 2 semanas desde a última análise. Analise um arquivo novo para saber quem deixou de te seguir nesse período.';

  @override
  String get reminderChannelName => 'Lembrete para verificar de novo';

  @override
  String get reminderChannelDescription =>
      'Avisa você 2 semanas após a análise para conferir de novo com um arquivo novo';

  @override
  String get faqTitle => 'Perguntas Frequentes';

  @override
  String get faqIsSafeQuestion => 'Este serviço é seguro?';

  @override
  String get faqIsSafeAnswer =>
      'O TrackFollows não pede sua senha do Instagram nem acessa sua conta. Os arquivos selecionados são analisados no seu dispositivo. O tratamento de dados de diagnóstico de uso e dos serviços de publicidade é explicado separadamente na Política de Privacidade.';

  @override
  String get faqDownloadTimeQuestion =>
      'Quanto tempo leva para baixar meus dados?';

  @override
  String get faqDownloadTimeAnswer =>
      'O Instagram prepara a exportação. O tempo de preparação varia; consulte a notificação ou a tela de exportação e baixe o ZIP quando estiver pronto.';

  @override
  String get faqWhatIsUnfollowerQuestion =>
      'O que exatamente é um não seguidor?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'São as contas que aparecem na lista de quem você segue, mas não na sua lista de seguidores, nos arquivos fornecidos. Isso pode incluir contas que nunca seguiram você. Uma única exportação não permite saber se alguém seguia você antes nem quando deixou de seguir.';

  @override
  String get faqThreadsQuestion =>
      'Também posso ver quem deixou de me seguir no Threads?';

  @override
  String get faqThreadsAnswer =>
      'Sim. Se o ZIP que você baixou do Instagram incluir as listas de seguidores e de quem você segue no Threads, você verá um resultado do Threads separado do Instagram. Alterne entre Instagram e Threads no topo dos resultados. Os seguidores do Threads são uma lista separada dos seguidores do Instagram.';

  @override
  String get faqIsFreeQuestion => 'Usar este serviço é pago?';

  @override
  String get faqIsFreeAnswer =>
      'Não, este serviço é totalmente gratuito. Você pode usar todos os recursos sem custo.';

  @override
  String get faqIncorrectListQuestion =>
      'A lista de unfollowers aparece diferente do que eu esperava. Por quê?';

  @override
  String get faqIncorrectListAnswer =>
      'Os resultados refletem as listas da exportação e podem ser diferentes do Instagram hoje. O momento da exportação, o período escolhido e as contas excluídas ou desativadas podem afetar as listas e contagens.\n\nSelecione Todo o período ao exportar e confira se todos os arquivos de seguidores e de quem você segue estão incluídos. Mesmo uma nova exportação não garante correspondência com o estado atual das contas.';

  @override
  String get faqFileSelectErrorQuestion =>
      'Não consigo selecionar o arquivo ZIP';

  @override
  String get faqFileSelectErrorAnswer =>
      'Ao abrir links através de aplicativos de mensagens como KakaoTalk, a função de seleção de arquivo pode não funcionar corretamente. Nesse caso, tente acessar o site diretamente através de navegadores como Chrome ou Samsung Internet para selecionar o arquivo. Normalmente, você pode selecionar arquivos normalmente ao acessar diretamente através de um navegador.';

  @override
  String get faqDataSecurityQuestion => 'Segurança de dados e privacidade';

  @override
  String get faqDataSecurityAnswer =>
      'Seus arquivos originais do Instagram, nomes de conta e listas de seguidores não são enviados a nenhum servidor para a análise. Para comparar com sua última análise, os nomes de usuário de seguidores e seguindo ficam salvos apenas neste dispositivo (navegador ou app), e você pode apagá-los a qualquer momento em \'Apagar histórico\' na tela de resultados. Consulte a Política de Privacidade sobre dados de diagnóstico e serviços de publicidade.';
}
