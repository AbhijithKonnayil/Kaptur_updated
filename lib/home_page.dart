import 'package:flutter/material.dart';
import 'package:kaptur_alpha_v1/create_project.dart';
import 'package:provider/provider.dart';
import 'carousel.dart';
import 'navigation_bar.dart';
import 'routes.dart';
import 'color_calculation.dart';
import 'package:kaptur_alpha_v1/your_project.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    appState.loadColorsFromSharedPreferences;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        index: 1,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          transform: Matrix4.translationValues(0, 70, 0),
          child: Column(
            children: [
              Text("Kaptur.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(
                width: double.infinity,
                height: 48,
              ),
              Container(width: double.infinity, margin: const EdgeInsets.only(left: 24), child: Text("Your Projects.", textAlign: TextAlign.start, style: Theme.of(context).textTheme.titleLarge)),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              const SizedBox(height: 200, child: CarouselBuilder()),
              const SizedBox(
                width: double.infinity,
                height: 30,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 24),
                child: Text("Quick Actions.", textAlign: TextAlign.start, style: Theme.of(context).textTheme.titleLarge),
              ),
              Expanded(
                  child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 40, childAspectRatio: 133 / 31),
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 24),
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, createProject);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(appState.accentColor),
                      overlayColor: MaterialStatePropertyAll(appState.accentColor),
                      foregroundColor: MaterialStatePropertyAll(appState.labelTextColor),
                    ),
                    icon: const Icon(Icons.add_circle_outline_sharp),
                    label: Text("New Project", style: Theme.of(context).textTheme.labelLarge),
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, yourProjects);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(appState.accentColor),
                      overlayColor: MaterialStatePropertyAll(appState.accentColor),
                      foregroundColor: MaterialStatePropertyAll(appState.labelTextColor),
                    ),
                    icon: const Icon(Icons.folder_outlined),
                    label: Text("Projects", style: Theme.of(context).textTheme.labelLarge),
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, settings);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(appState.accentColor),
                      overlayColor: MaterialStatePropertyAll(appState.accentColor),
                      foregroundColor: MaterialStatePropertyAll(appState.labelTextColor),
                    ),
                    icon: const Icon(Icons.settings_outlined),
                    label: Text("Settings", style: Theme.of(context).textTheme.labelLarge),
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, profile);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(appState.accentColor),
                      overlayColor: MaterialStatePropertyAll(appState.accentColor),
                      foregroundColor: MaterialStatePropertyAll(appState.labelTextColor),
                    ),
                    icon: const Icon(Icons.person_outline_rounded),
                    label: Text("Profile", style: Theme.of(context).textTheme.labelLarge),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
