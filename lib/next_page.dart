import 'dart:ui';
import 'package:flutter/material.dart';
import 'repeat_option.dart';
import 'package:kaptur_alpha_v1/sreen_constants.dart';
import 'package:kaptur_alpha_v1/project_home.dart';
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
  bool isExpanded = true;
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
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 60 / 360 * ScreenConstants.screenWidth,
                bottom: 25 / 360 * ScreenConstants.screenWidth,
              ),
              child: Text(
                "Create new Project.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                left: 24 / 360 * ScreenConstants.screenWidth,
              ),
              child: Text(
                "Notification Time",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 10 / 360 * ScreenConstants.screenWidth,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 24 / 360 * ScreenConstants.screenWidth,
              ),
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () => _selectTime(context),
                style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                    Size(130 / 360 * ScreenConstants.screenWidth, 40 / 360 * ScreenConstants.screenWidth),
                  ),
                  textStyle: MaterialStatePropertyAll(
                    Theme.of(context).textTheme.titleMedium,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    appState.labelColor,
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    appState.labelTextColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10 / 360 * ScreenConstants.screenWidth,
                      ),
                    ),
                  ),
                ),
                child: Text(
                  selectedTime.format(context),
                  style: const TextStyle(color: Colors.black),
                ),
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
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 10 / 360 * ScreenConstants.screenWidth,
            ),
            SizedBox(
              width: double.infinity,
              height: 40 / 360 * ScreenConstants.screenWidth,
              child: Container(
                margin: const EdgeInsets.only(left: 24, right: 24),
                child: SizedBox(
                  height: 40 / 360 * ScreenConstants.screenWidth,
                  width: 200 / 360 * ScreenConstants.screenWidth,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      textStyle: MaterialStatePropertyAll(
                        Theme.of(context).textTheme.titleMedium,
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        appState.labelColor,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        appState.labelTextColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10 / 360 * ScreenConstants.screenWidth,
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
              width: double.infinity,
              height: 20 / 360 * ScreenConstants.screenWidth,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 24.0 / 360 * ScreenConstants.screenWidth,
                right: 24.0 / 360 * ScreenConstants.screenWidth,
              ),
              child: ExpansionPanelList(
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return (Text("Expanded Options"));
                    },
                    body: RepeatButtons(
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
                  ),
                ],
              ),
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
    );
  }
}
