import 'package:flutter/material.dart';
import 'package:kaptur_alpha_v1/next_page.dart';
import 'package:kaptur_alpha_v1/your_project.dart';
import 'package:provider/provider.dart';
import 'profile.dart';
import 'settings.dart';
import 'home_page.dart';
import 'routes.dart';
import 'sreen_constants.dart';
import 'color_calculation.dart';
import 'create_project.dart';
import 'CameraModule.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = AppState();
  print("restarting the app");
  await appState.loadColorsFromSharedPreferences();
  runApp(Kaptur(appState: appState));
  // appState.loadColorsFromSharedPreferences().then((_) {
  //   runApp(Kaptur(appState: appState));
  // });
}

class Kaptur extends StatelessWidget {
  final AppState appState;
  final UniqueKey key = UniqueKey();
  Kaptur({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    print("rebuilding the app");
    final Size screenSize = MediaQuery.of(context).size;
    ScreenConstants.screenWidth = screenSize.width;
    ScreenConstants.screenHeight = screenSize.height;

    return ChangeNotifierProvider.value(
      key: key,
      value: appState,
      child: Consumer<AppState>(builder: (context, appState, _) {
        return MaterialApp(
          title: "Kaptur",
          theme: appState.theme,
          home: HomeScreen(),
          routes: {
            home: (context) => HomeScreen(),
            settings: (context) => Settings(),
            profile: (context) => Profile(),
            createProject: (context) => CreateProject(),
            yourProjects: (context) => YourProjects(),
            nextPage: (context) => NextCreate(),
            camera: (context) => CameraModule(),
          },
        );
      }),
    );
  }
}
