import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_socks_proxy/socks_proxy.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nostrmo/provider/follow_new_event_provider.dart';
import 'package:nostrmo/provider/mention_me_new_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'client/cust_nostr.dart';
import 'consts/base.dart';
import 'consts/colors.dart';
import 'consts/router_path.dart';
import 'consts/theme_style.dart';
import 'data/db.dart';
import 'generated/l10n.dart';
import 'provider/contact_list_provider.dart';
import 'provider/data_util.dart';
import 'provider/dm_provider.dart';
import 'provider/event_reactions_provider.dart';
import 'provider/filter_provider.dart';
import 'provider/follow_event_provider.dart';
import 'provider/index_provider.dart';
import 'provider/link_preview_data_provider.dart';
import 'provider/mention_me_provider.dart';
import 'provider/metadata_provider.dart';
import 'provider/relay_provider.dart';
import 'provider/notice_provider.dart';
import 'provider/setting_provider.dart';
import 'provider/single_event_provider.dart';
import 'router/dm/dm_detail_router.dart';
import 'router/donate/donate_router.dart';
import 'router/event_detail/event_detail_router.dart';
import 'router/filter/filter_router.dart';
import 'router/profile_editor/profile_editor_router.dart';
import 'router/index/index_router.dart';
import 'router/keybackup/key_backup_router.dart';
import 'router/notice/notice_router.dart';
import 'router/relays/relays_router.dart';
import 'router/setting/setting_router.dart';
import 'router/tag/tag_detail_router.dart';
import 'router/thread/thread_detail_router.dart';
import 'router/user/user_contact_list_router.dart';
import 'router/user/user_relays_router.dart';
import 'router/user/user_router.dart';
import 'system_timer.dart';
import 'util/colors_util.dart';
import 'util/image/cache_manager_builder.dart';
import 'util/locale_util.dart';
import 'util/media_data_cache.dart';
import 'util/string_util.dart';

late SharedPreferences sharedPreferences;

late SettingProvider settingProvider;

late MetadataProvider metadataProvider;

late ContactListProvider contactListProvider;

late FollowEventProvider followEventProvider;

late FollowNewEventProvider followNewEventProvider;

late MentionMeProvider mentionMeProvider;

late MentionMeNewProvider mentionMeNewProvider;

late DMProvider dmProvider;

late IndexProvider indexProvider;

late EventReactionsProvider eventReactionsProvider;

late NoticeProvider noticeProvider;

late SingleEventProvider singleEventProvider;

late RelayProvider relayProvider;

late FilterProvider filterProvider;

late LinkPreviewDataProvider linkPreviewDataProvider;

late MediaDataCache mediaDataCache;

late CacheManager localCacheManager;

CustNostr? nostr;

bool firstLogin = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  } catch (e) {
    print(e);
  }

  var dbInitTask = DB.getCurrentDatabase();
  var dataUtilTask = DataUtil.getInstance();
  var dataFutureResultList = await Future.wait([dbInitTask, dataUtilTask]);
  sharedPreferences = dataFutureResultList[1] as SharedPreferences;

  var settingTask = SettingProvider.getInstance();
  var metadataTask = MetadataProvider.getInstance();
  var futureResultList = await Future.wait([settingTask, metadataTask]);
  settingProvider = futureResultList[0] as SettingProvider;
  metadataProvider = futureResultList[1] as MetadataProvider;
  contactListProvider = ContactListProvider.getInstance();
  followEventProvider = FollowEventProvider();
  followNewEventProvider = FollowNewEventProvider();
  mentionMeProvider = MentionMeProvider();
  mentionMeNewProvider = MentionMeNewProvider();
  dmProvider = DMProvider();
  indexProvider = IndexProvider(
    indexTap: settingProvider.defaultIndex,
  );
  eventReactionsProvider = EventReactionsProvider();
  noticeProvider = NoticeProvider();
  singleEventProvider = SingleEventProvider();
  relayProvider = RelayProvider.getInstance();
  filterProvider = FilterProvider.getInstance();
  linkPreviewDataProvider = LinkPreviewDataProvider();
  mediaDataCache = MediaDataCache();
  localCacheManager = CacheManagerBuilder.build();

  if (StringUtil.isNotBlank(settingProvider.network)) {
    var network = settingProvider.network;
    network = network!.trim();
    SocksProxy.initProxy(proxy: network);
  }

  if (StringUtil.isNotBlank(settingProvider.privateKey)) {
    nostr = relayProvider.genNostr(settingProvider.privateKey!);
  }

  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Locale? _locale;
    if (StringUtil.isNotBlank(settingProvider.i18n)) {
      for (var item in S.delegate.supportedLocales) {
        if (item.languageCode == settingProvider.i18n &&
            item.countryCode == settingProvider.i18nCC) {
          _locale = Locale(settingProvider.i18n!, settingProvider.i18nCC);
          break;
        }
      }
    }
    setGetTimeAgoDefaultLocale(_locale);

    var lightTheme = getLightTheme();
    var darkTheme = getDarkTheme();
    ThemeData defaultTheme;
    ThemeData? defaultDarkTheme;
    if (settingProvider.themeStyle == ThemeStyle.LIGHT) {
      defaultTheme = lightTheme;
    } else if (settingProvider.themeStyle == ThemeStyle.DARK) {
      defaultTheme = darkTheme;
    } else {
      defaultTheme = lightTheme;
      defaultDarkTheme = darkTheme;
    }

    return MultiProvider(
      providers: [
        ListenableProvider<SettingProvider>.value(
          value: settingProvider,
        ),
        ListenableProvider<MetadataProvider>.value(
          value: metadataProvider,
        ),
        ListenableProvider<IndexProvider>.value(
          value: indexProvider,
        ),
        ListenableProvider<ContactListProvider>.value(
          value: contactListProvider,
        ),
        ListenableProvider<FollowEventProvider>.value(
          value: followEventProvider,
        ),
        ListenableProvider<FollowNewEventProvider>.value(
          value: followNewEventProvider,
        ),
        ListenableProvider<MentionMeProvider>.value(
          value: mentionMeProvider,
        ),
        ListenableProvider<MentionMeNewProvider>.value(
          value: mentionMeNewProvider,
        ),
        ListenableProvider<DMProvider>.value(
          value: dmProvider,
        ),
        ListenableProvider<EventReactionsProvider>.value(
          value: eventReactionsProvider,
        ),
        ListenableProvider<NoticeProvider>.value(
          value: noticeProvider,
        ),
        ListenableProvider<SingleEventProvider>.value(
          value: singleEventProvider,
        ),
        ListenableProvider<RelayProvider>.value(
          value: relayProvider,
        ),
        ListenableProvider<FilterProvider>.value(
          value: filterProvider,
        ),
        ListenableProvider<LinkPreviewDataProvider>.value(
          value: linkPreviewDataProvider,
        ),
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        // showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        locale: _locale,
        title: Base.APP_NAME,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: defaultTheme,
        darkTheme: defaultDarkTheme,
        initialRoute: RouterPath.INDEX,
        routes: {
          RouterPath.INDEX: (context) => IndexRouter(reload: reload),
          RouterPath.DONATE: (context) => DonateRouter(),
          RouterPath.USER: (context) => UserRouter(),
          RouterPath.USER_CONTACT_LIST: (context) => UserContactListRouter(),
          RouterPath.USER_RELAYS: (context) => UserRelayRouter(),
          RouterPath.DM_DETAIL: (context) => DMDetailRouter(),
          RouterPath.THREAD_DETAIL: (context) => ThreadDetailRouter(),
          RouterPath.EVENT_DETAIL: (context) => EventDetailRouter(),
          RouterPath.TAG_DETAIL: (context) => TagDetailRouter(),
          RouterPath.NOTICES: (context) => NoticeRouter(),
          RouterPath.KEY_BACKUP: (context) => KeyBackupRouter(),
          RouterPath.RELAYS: (context) => RelaysRouter(),
          RouterPath.FILTER: (context) => FilterRouter(),
          RouterPath.PROFILE_EDITOR: (context) => ProfileEditorRouter(),
          RouterPath.SETTING: (context) => SettingRouter(indexReload: reload),
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemTimer.run();
  }

  @override
  void dispose() {
    super.dispose();
    SystemTimer.stopTask();
  }

  ThemeData getLightTheme() {
    Color color500 = const Color(0xff519495);
    if (settingProvider.themeColor != null) {
      color500 = Color(settingProvider.themeColor!);
    }

    MaterialColor themeColor = ColorList.getThemeColor(color500.value);

    Color? mainTextColor;
    Color hintColor = Colors.grey;

    var textTheme = TextTheme(
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
    );
    var titleTextStyle = TextStyle(
      color: Colors.white,
    );

    if (settingProvider.fontFamily != null) {
      textTheme =
          GoogleFonts.getTextTheme(settingProvider.fontFamily!, textTheme);
      titleTextStyle = GoogleFonts.getFont(settingProvider.fontFamily!,
          textStyle: titleTextStyle);
    }

    return ThemeData(
      brightness: Brightness.light,
      platform: TargetPlatform.iOS,
      primarySwatch: themeColor,
      // scaffoldBackgroundColor: Base.SCAFFOLD_BACKGROUND_COLOR,
      // scaffoldBackgroundColor: Colors.grey[100],
      scaffoldBackgroundColor: Colors.grey[100],
      primaryColor: themeColor[500],
      appBarTheme: AppBarTheme(
        // color: Base.APPBAR_COLOR,
        backgroundColor: themeColor[500],
        titleTextStyle: titleTextStyle,
        elevation: 0,
      ),
      dividerColor: Colors.grey,
      cardColor: Colors.white,
      // dividerColor: Colors.grey[200],
      // indicatorColor: ColorsUtil.hexToColor("#818181"),
      textTheme: textTheme,
      hintColor: hintColor,
    );
  }

  ThemeData getDarkTheme() {
    Color color500 = const Color(0xff519495);
    if (settingProvider.themeColor != null) {
      color500 = Color(settingProvider.themeColor!);
    }

    MaterialColor themeColor = ColorList.getThemeColor(color500.value);

    Color? mainTextColor;
    Color? topFontColor = Colors.white;
    Color hintColor = Colors.grey;

    var textTheme = TextTheme(
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
    );
    var titleTextStyle = TextStyle(
      color: topFontColor,
      // color: Colors.black,
    );

    if (settingProvider.fontFamily != null) {
      textTheme =
          GoogleFonts.getTextTheme(settingProvider.fontFamily!, textTheme);
      titleTextStyle = GoogleFonts.getFont(settingProvider.fontFamily!,
          textStyle: titleTextStyle);
    }

    return ThemeData(
      brightness: Brightness.dark,
      platform: TargetPlatform.iOS,
      primarySwatch: themeColor,
      // scaffoldBackgroundColor: Base.SCAFFOLD_BACKGROUND_COLOR,
      scaffoldBackgroundColor: ColorsUtil.hexToColor("#212121"),
      primaryColor: themeColor[500],
      appBarTheme: AppBarTheme(
        // color: Base.APPBAR_COLOR,
        backgroundColor: Colors.grey[800],
        titleTextStyle: titleTextStyle,
        elevation: 0,
      ),
      dividerColor: Colors.grey[200],
      cardColor: Colors.grey[800],
      // indicatorColor: ColorsUtil.hexToColor("#818181"),
      textTheme: textTheme,
      hintColor: hintColor,
    );
  }

  void setGetTimeAgoDefaultLocale(Locale? locale) {
    String? localeName = Intl.defaultLocale;
    if (locale != null) {
      localeName = LocaleUtil.getLocaleKey(locale);
    }

    if (StringUtil.isNotBlank(localeName)) {
      if (GetTimeAgoSupportLocale.containsKey(localeName)) {
        GetTimeAgo.setDefaultLocale(localeName!);
      } else if (localeName == "zh_tw") {
        GetTimeAgo.setDefaultLocale("zh_tr");
      }
    }
  }
}

final Map<String, int> GetTimeAgoSupportLocale = {
  'ar': 1,
  'en': 1,
  'es': 1,
  'fr': 1,
  'hi': 1,
  'pt': 1,
  'br': 1,
  'zh': 1,
  'zh_tr': 1,
  'ja': 1,
  'oc': 1,
  'ko': 1,
  'de': 1,
  'id': 1,
  'tr': 1,
  'ur': 1,
  'vi': 1,
};
