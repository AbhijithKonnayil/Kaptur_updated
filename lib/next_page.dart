import 'dart:ui';
import 'package:flutter/material.dart';
//import 'package:kaptur_alpha_v1/create_project.dart';
import 'repeat_option.dart';
import 'package:kaptur_alpha_v1/sreen_constants.dart';
import 'package:kaptur_alpha_v1/project_home.dart';
//appstate
import 'color_calculation.dart';
import 'package:provider/provider.dart';
import 'package:kaptur_alpha_v1/navigation_bar.dart';

class NextCreate extends StatefulWidget {
  const NextCreate({Key? key}) : super(key: key);

  @override
  State<NextCreate> createState() => _NextCreateState();
}

class _NextCreateState extends State<NextCreate> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedSound = 'Default';
  String selectedRepeatOption = ''; // Declare and initialize the variable
  TimeOfDay selectedCustomTime = TimeOfDay.now(); // Declare and initialize the variable

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> _selectSound(BuildContext context) async {
    final List<String> soundOptions = [
      'Default',
      'Sound 1',
      'Sound 2',
      'Sound 3'
    ]; // Replace with your sound options
    final String? pickedSound = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: soundOptions.map((sound) {
            return ListTile(
              title: Text(sound),
              onTap: () {
                print("nextpage pop 1");
                Navigator.pop(context, sound);
              },
            );
          }).toList(),
        );
      },
    );

    if (pickedSound != null && pickedSound != selectedSound) {
      setState(() {
        selectedSound = pickedSound;
      });
    }
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
              Text(
                "Create new Project.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 60.0 / 360 * ScreenConstants.screenWidth,
                    ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 40,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 24 / 360 * ScreenConstants.screenWidth,
                ),
                child: Text(
                  "Notification Time",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 10 / 360 * ScreenConstants.screenWidth,
              ),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    appState.accentColor,
                  ),
                  overlayColor: MaterialStateProperty.all<Color>(
                    appState.accentColor,
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    appState.labelTextColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8 / 360 * ScreenConstants.screenWidth,
                      ),
                    ),
                  ),
                ),
                child: Text(
                  selectedTime.format(context),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 20 / 360 * ScreenConstants.screenWidth,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 24 / 360 * ScreenConstants.screenWidth,
                ),
                child: Text(
                  "Notification Sound",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 10 / 360 * ScreenConstants.screenWidth,
              ),
              SizedBox(
                width: double.infinity,
                height: 40 / 360 * ScreenConstants.screenWidth,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 15.0 / 360 * ScreenConstants.screenWidth,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 24),
                      child: SizedBox(
                        height: 40 / 360 * ScreenConstants.screenWidth,
                        child: FractionallySizedBox(
                          widthFactor: 0.3 / 360 * ScreenConstants.screenWidth,
                          // heightFactor: 0.9,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                appState.accentColor,
                              ),
                              overlayColor: MaterialStateProperty.all<Color>(
                                appState.accentColor,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                appState.labelTextColor,
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    8 / 360 * ScreenConstants.screenWidth,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () => _selectSound(context),
                            child: Text(
                              selectedSound,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40 / 360 * ScreenConstants.screenWidth,
                      child: FractionallySizedBox(
                        widthFactor: 0.1 / 360 * ScreenConstants.screenWidth,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              appState.accentColor,
                            ),
                            overlayColor: MaterialStateProperty.all<Color>(
                              appState.accentColor,
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              appState.labelTextColor,
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8 / 360 * ScreenConstants.screenWidth,
                                ),
                              ),
                            ),
                          ),
                          child: const Text(
                            '+',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 20 / 360 * ScreenConstants.screenWidth,
              ),
              RepeatButtons(
                selectedRepeatOption: selectedRepeatOption,
                selectedCustomTime: selectedCustomTime,
                onRepeatOptionChanged: (option) {
                  setState(() {
                    selectedRepeatOption = option;
                  });
                },
                onCustomTimeChanged: (time) {
                  setState(() {
                    selectedCustomTime = time;
                  });
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 20 / 360 * ScreenConstants.screenWidth,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 16.0 / 360 * ScreenConstants.screenWidth,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.3 / 360 * ScreenConstants.screenWidth,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          appState.accentColor,
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(
                          appState.accentColor,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          appState.labelTextColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CombinedWidget(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Finish '),
                          SizedBox(width: 1),
                          Icon(Icons.check),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.0 / 360 * ScreenConstants.screenWidth,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.4 / 360 * ScreenConstants.screenWidth,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          appState.accentColor,
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(
                          appState.accentColor,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          appState.labelTextColor,
                        ),
                      ),
                      onPressed: () {
                        print("nextpage pop 2");

                        Navigator.pop(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 1),
                          Text('Back'),
                        ],
                      ),
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
