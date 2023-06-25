import 'package:flutter/material.dart';
import 'package:kaptur_alpha_v1/sreen_constants.dart';
//appstate
import 'color_calculation.dart';
import 'package:provider/provider.dart';

const List<String> options = <String>['Day', 'Week'];

class RepeatButtons extends StatefulWidget {
  const RepeatButtons(
      {super.key,
      required Null Function(TimeOfDay value) onCustomTimeChanged,
      required String selectedRepeatOption,
      required TimeOfDay selectedCustomTime,
      required Null Function(String value) onRepeatOptionChanged});

  @override
  State<RepeatButtons> createState() => _RepeatButtonsState();
}

class _RepeatButtonsState extends State<RepeatButtons> {
  String optionsDropdownValue = options.first;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    appState.loadColorsFromSharedPreferences;

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 40 / 360 * ScreenConstants.screenWidth,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 15.0 / 360 * ScreenConstants.screenWidth,
          children: [
            Container(
                margin: EdgeInsets.only(
                    left: 24 / 360 * ScreenConstants.screenWidth),
                child: Text("Repeat every",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge)),
            SizedBox(
              height: 40 / 360 * ScreenConstants.screenWidth,
              child: FractionallySizedBox(
                widthFactor: 0.2 / 360 * ScreenConstants.screenWidth,
                // heightFactor: 0.9,
                child: FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(appState.accentColor),
                      overlayColor:
                          MaterialStatePropertyAll(appState.accentColor),
                      foregroundColor:
                          MaterialStatePropertyAll(appState.labelTextColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            8 / 360 * ScreenConstants.screenWidth)),
                        // side: BorderSide(color: Colors.red)
                      ))),
                  onPressed: () {},
                  child: const Text(
                    '00:00',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 40 / 360 * ScreenConstants.screenWidth,
                child: FractionallySizedBox(
                    widthFactor: 0.2 / 360 * ScreenConstants.screenWidth,
                    child: Container(
                      padding:
                          EdgeInsets.all(6 / 360 * ScreenConstants.screenWidth),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            8 / 360 * ScreenConstants.screenWidth)),
                        color: appState.accentColor,
                      ),
                      child: DropdownButton<String>(
                        value: optionsDropdownValue,
                        isExpanded: true,
                        elevation: 16,
                        iconEnabledColor: Colors.black,
                        // dropdownColor: MaterialStatePropertyAll(appState.accentColor),
                        style: const TextStyle(color: Colors.black),
                        underline: SizedBox(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            optionsDropdownValue = value!;
                          });
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )

                    // FilledButton(
                    //   onPressed: () {},
                    //   style: ButtonStyle(
                    //       backgroundColor:
                    //           MaterialStatePropertyAll(appState.accentColor),
                    //       overlayColor:
                    //           MaterialStatePropertyAll(appState.accentColor),
                    //       foregroundColor:
                    //           MaterialStatePropertyAll(appState.labelTextColor),
                    //       shape:
                    //           MaterialStateProperty.all<RoundedRectangleBorder>(
                    //               const RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(8)),
                    //         // side: BorderSide(color: Colors.red)
                    //       ))),
                    //   child: const Text(
                    //     'Daily',
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                    )),
          ],
        ),
      ),
    );
  }
}
