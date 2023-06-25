import 'package:kaptur_alpha_v1/sreen_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_calculation.dart';
import 'navigation_bar.dart';
//import 'create_project.dart';

class YourProjects extends StatefulWidget {
  const YourProjects({Key? key}) : super(key: key);

  @override
  State<YourProjects> createState() => _YourProjectsState();
}

class _YourProjectsState extends State<YourProjects> {
  List<Project> projects = []; // List to store created projects

  void addProject(Project project) {
    setState(() {
      projects.add(project);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    appState.loadColorsFromSharedPreferences();

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        index: 4,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 15,
              ),
              Text(
                "Your Projects.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 60 / 360 * ScreenConstants.screenWidth,
                    ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 15,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return Container(
                        height: 60 / 360 * ScreenConstants.screenWidth,
                        width: 320 / 360 * ScreenConstants.screenWidth,
                        margin: EdgeInsets.only(
                          top: 10 / 360 * ScreenConstants.screenWidth,
                        ),
                        child: FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(appState.accentColor),
                            overlayColor:
                                MaterialStateProperty.all(appState.accentColor),
                            foregroundColor: MaterialStateProperty.all(
                                appState.labelTextColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    project.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/icons/pen.png',
                                width: 32 / 360 * ScreenConstants.screenWidth,
                                height: 32 / 360 * ScreenConstants.screenWidth,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Project {
  final String name;

  Project(this.name);
}
