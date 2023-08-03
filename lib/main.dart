import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexofarm/screens/auth/create_acct.dart';
import 'package:rexofarm/screens/home.dart';
import 'package:rexofarm/screens/onboarding/onboarding_page.dart';
import 'package:rexofarm/services/storage/secure_storage.dart';
import 'package:rexofarm/services/storage/storage_service.dart';
import 'package:rexofarm/theme.dart';
import 'package:rexofarm/view_models/auth_view_model.dart';
import 'package:rexofarm/view_models/kyc_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    FutureBuilder<bool>(
      future: StorageServiceImpl().showOnBoarding(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RexoFarmApp(showOnBoarding: snapshot.data!);
        } else {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'RexoFarm',
            home: Scaffold(),
          );
        }
      },
    ),
  );
}

class RexoFarmApp extends StatelessWidget {
  final bool showOnBoarding;

  const RexoFarmApp({
    super.key,
    required this.showOnBoarding,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => KycViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RexoFarm',
        theme: RexoFarmAppTheme.light(),
        home: showOnBoarding
            ? const OnBoardingScreen()
            : FutureBuilder<String?>(
                future: SecureStorage().getActiveUserToken(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    String? token = snapshot.data;
                    print(token);
                    if (token == null) {
                      return const CreateAccountPage();
                    } else {
                      return Home(token: token);
                    }
                  } else {
                    return const MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'RexoFarm',
                      home: Scaffold(),
                    );
                  }
                },
              ),
      ),
    );
  }
}
