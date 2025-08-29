import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pstb/app/app_module.dart';
import 'package:pstb/app/modules/landing/landing_page.dart';
import 'package:pstb/widgets/theme_data_widget.dart';
import 'app_store.dart';
import 'modules/booking_v2/cubit/create_request_cubit.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppWidgetState();
}

class AppWidgetState extends State<AppWidget> {
  final AppStore _appStore = Modular.get<AppStore>();
  @override
  void initState() {
    super.initState();
    _appStore.getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateRequestCubit(),
        )
      ],
      child: MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Bệnh Viện Phụ Sản Thái Bình',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _appStore.language,
        supportedLocales: const [
          Locale('en', ''),
          Locale('vi', ''),
        ],
        theme: Modular.get<ThemeDataWidget>().themeDataCustom(),
        home: GlobalContextWrapper(child: const LandingPage()),
      ).modular(),
    );
  }
}

class GlobalContextWrapper extends StatelessWidget {
  final Widget child;

  const GlobalContextWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final contextService = Modular.get<GlobalContextService>();
      contextService.setContext(context);
    });

    return child;
  }
}
