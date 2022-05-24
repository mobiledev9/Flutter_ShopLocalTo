import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/blocs/contactUs/bloc.dart';
import 'package:shoplocalto/blocs/signUp/bloc.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/main_navigation.dart';
import 'package:shoplocalto/screens/page1/page1.dart';
import 'package:shoplocalto/screens/screen.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/blocs/resetPassword/bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Routes route = Routes();

  ApplicationBloc _applicationBloc;
  LanguageBloc _languageBloc;
  ThemeBloc _themeBloc;
  AuthBloc _authBloc;
  LoginBloc _loginBloc;
  SearchBloc _searchBloc;
  SignUpBloc _signUpBloc;
  UpdateBloc _updateBloc;
  ResetBloc _resetBloc;
  ContactBloc _contactUsBloc;
  ChatBloc _chatBloc;
  WishListBloc _wishListBloc;
  SocialLoginBloc _socialLoginBloc;
  SocialglLoginBloc _socialglLogin;

  @override
  void initState() {
    ///Bloc business logic
    _languageBloc = LanguageBloc();
    _themeBloc = ThemeBloc();
    _authBloc = AuthBloc();
    _loginBloc = LoginBloc(authBloc: _authBloc);
    _signUpBloc = SignUpBloc(authBloc: _authBloc);
    _updateBloc = UpdateBloc(authBloc: _authBloc);
    _resetBloc = ResetBloc(authBloc: _authBloc);
    _contactUsBloc = ContactBloc(authBloc: _authBloc);
    _applicationBloc = ApplicationBloc(
      authBloc: _authBloc,
      themeBloc: _themeBloc,
      languageBloc: _languageBloc,
    );
    _searchBloc = SearchBloc();
    _chatBloc = ChatBloc(authBloc: _authBloc);
    _wishListBloc = WishListBloc(authBloc: _authBloc);
    _socialLoginBloc = SocialLoginBloc(authBloc: _authBloc);
    _socialglLogin = SocialglLoginBloc(authBloc: _authBloc);
    super.initState();
  }

  @override
  void dispose() {
    _applicationBloc.close();
    _languageBloc.close();
    _themeBloc.close();
    _authBloc.close();
    _loginBloc.close();
    _signUpBloc.close();
    _searchBloc.close();
    _updateBloc.close();
    _resetBloc.close();
    _contactUsBloc.close();
    _chatBloc.close();
    _wishListBloc.close();
    _socialLoginBloc.close();
    _socialglLogin.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (context) => _applicationBloc,
        ),
        BlocProvider<LanguageBloc>(
          create: (context) => _languageBloc,
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => _themeBloc,
        ),
        BlocProvider<AuthBloc>(
          create: (context) => _authBloc,
        ),
        BlocProvider<LoginBloc>(
          create: (context) => _loginBloc,
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => _signUpBloc,
        ),
        BlocProvider<UpdateBloc>(
          create: (context) => _updateBloc,
        ),
        BlocProvider<ResetBloc>(
          create: (context) => _resetBloc,
        ),
        BlocProvider<SearchBloc>(
          create: (context) => _searchBloc,
        ),
         BlocProvider<ContactBloc>(
          create: (context) => _contactUsBloc,
        ),
        BlocProvider<ChatBloc>(
          create: (context) => _chatBloc,
        ),
         BlocProvider<WishListBloc>(
          create: (context) => _wishListBloc,
        ),
         BlocProvider<SocialLoginBloc>(
          create: (context) => _socialLoginBloc,
        ),
          BlocProvider<SocialglLoginBloc>(
          create: (context) => _socialglLogin,
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, lang) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, theme) {
              return BlocBuilder<AuthBloc, AuthenticationState>(
                  builder: (context, auth) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  onGenerateRoute: route.generateRoute,
                  locale: AppLanguage.defaultLanguage,
                  localizationsDelegates: [
                    Translate.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: AppLanguage.supportLanguage,
                  home: BlocBuilder<ApplicationBloc, ApplicationState>(
                    builder: (context, app) {
                      print('mmmmmmmmmmmmmmmmmmmmlogincheck.............$app');
                      if (app is ApplicationSetupCompleted) {
                        return auth is AuthenticationSuccess
                            ? MainNavigation()
                            : auth is AuthenticationBeginCheck
                                ? Center(
                                    child: CircularProgressIndicator(
                                        backgroundColor: Colors.black,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.blue[800])),
                                  )
                                :   Page1();
                      }
                      if (app is ApplicationIntroView) {
                        return IntroPreview();
                      }
                      return SplashScreen();
                    },
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}
