import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'color_calculation.dart';
import 'next_page.dart';
import 'sreen_constants.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  bool isLandscapeSelected = true;
  bool isPortraitSelected = false;
  final TextEditingController _projectNameController = TextEditingController();

  Future<void> _saveProjectName(String projectName) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'projects_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE projects(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
        );
      },
      version: 1,
    );

    final Database db = await database;
    await db.insert(
      'projects',
      {'name': projectName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    appState.loadColorsFromSharedPreferences();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Text(
                "Create new Project.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 60 / 360 * ScreenConstants.screenWidth,
                    ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 48,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: 24 / 360 * ScreenConstants.screenWidth,
                  ),
                  child: Text(
                    "Project Name",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  right: 24 / 360 * ScreenConstants.screenWidth,
                  left: 24 / 360 * ScreenConstants.screenWidth,
                ),
                child: TextField(
                  controller: _projectNameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Project Name',
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 24 / 360 * ScreenConstants.screenWidth,
                ),
                child: Text(
                  "Video Orientation",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SizedBox(
                height: 145 / 360 * ScreenConstants.screenWidth,
                child: Wrap(
                  spacing: 15.0 / 360 * ScreenConstants.screenWidth,
                  children: [
                    SizedBox(
                      height: 145 / 360 * ScreenConstants.screenWidth,
                      child: FractionallySizedBox(
                        widthFactor: 0.5 / 360 * ScreenConstants.screenWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: isLandscapeSelected
                                ? appState.accentColor
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8 / 360 * ScreenConstants.screenWidth,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isLandscapeSelected = true;
                              isPortraitSelected = false;
                            });
                          },
                          child: const Text(
                            'Landscape',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 145 / 360 * ScreenConstants.screenWidth,
                      child: FractionallySizedBox(
                        widthFactor: 0.3 / 360 * ScreenConstants.screenWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: isPortraitSelected
                                ? appState.accentColor
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8 / 360 * ScreenConstants.screenWidth,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isLandscapeSelected = false;
                              isPortraitSelected = true;
                            });
                          },
                          child: const Text(
                            'Portrait',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: FractionallySizedBox(
                    widthFactor: 0.3 / 360 * ScreenConstants.screenWidth,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: appState.accentColor,
                      ),
                      onPressed: () async {
                        final String projectName =
                            _projectNameController.text.trim();
                        await _saveProjectName(projectName);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NextCreate(),
                          ),
                        );
                      },
                      // Show an error message or validation
                      // when the project name is empty.
                      /*showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content:
                                  const Text('Please enter a project name.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },*/
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Next'),
                    ),
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
