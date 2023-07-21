import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:kaptur_alpha_v1/routes.dart';
import 'package:provider/provider.dart';
import 'emoji_getter.dart';
import 'color_calculation.dart';
import 'next_page.dart';
import 'sreen_constants.dart';
import 'sql_helper.dart';

class CreateProject extends StatefulWidget {
  CreateProject({Key? key}) : super(key: key);

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  int i = 0;

  FocusNode _projectNameFocusNode = FocusNode();

  int selectedEmojiIndex = 0;

  bool isLandscapeSelected = true;

  List<String> emojiList = [];

  final TextEditingController _projectNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getEmojiList();
  }

  Future<void> _saveProjectName(String projectName) async {
    await SQLHelper.instance.saveProjectName(projectName);
  }

  Future<void> getEmojiList() async {
    emojiList = await GetEmojis.loadRandomStrings();
  }

  AnimatedEmojiData getEmojiFromName(String name) {
    // Find the matching enum value based on the name
    return AnimatedEmojis.values.firstWhere(
      (emoji) => emoji.toString() == name,
      orElse: () => AnimatedEmojis.smileCat,
    );
  }

  Widget buildEmoji(String emoji, int index, AppState appState) {
    bool isSelected = index == selectedEmojiIndex;
    String currentEmoji = emojiList[i];
    final AnimatedEmojiData selectedEmoji = getEmojiFromName(currentEmoji);

    return Container(
      width: 50 / 360 * ScreenConstants.screenWidth,
      height: 50 / 360 * ScreenConstants.screenWidth,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: null,
        border: isSelected ? Border.all(color: appState.accentColor, width: 4, strokeAlign: BorderSide.strokeAlignOutside) : null,
      ),
      child: Material(
        shape: const CircleBorder(),
        child: InkWell(
          splashColor: appState.labelColor,
          customBorder: const CircleBorder(),
          onTap: () {
            setState(() {
              selectedEmojiIndex = index;
            });
          },
          child: Align(
              alignment: Alignment.center,
              child: AnimatedEmoji(
                selectedEmoji,
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    appState.loadColorsFromSharedPreferences();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 60 / 360 * ScreenConstants.screenWidth,
              bottom: 25 / 360 * ScreenConstants.screenWidth,
            ),
            child: Text(
              "Create new Project.",
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 24 / 360 * ScreenConstants.screenWidth),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Project Icon",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 50 / 360 * ScreenConstants.screenWidth,
                  margin: EdgeInsets.only(top: 10 / 360 * ScreenConstants.screenWidth, left: 10 / 360 * ScreenConstants.screenWidth, right: 24 / 360 * ScreenConstants.screenWidth),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      for (i = 0; i < emojiList.length ~/ 2; i++) buildEmoji(emojiList[i], (i), appState),
                    ]),
                  )),
              Container(
                  width: double.infinity,
                  height: 50 / 360 * ScreenConstants.screenWidth,
                  margin: EdgeInsets.only(top: 10 / 360 * ScreenConstants.screenWidth, left: 10 / 360 * ScreenConstants.screenWidth, right: 24 / 360 * ScreenConstants.screenWidth),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      for (i; i < emojiList.length; i++) buildEmoji(emojiList[i], (i), appState),
                    ]),
                  )),
              Container(
                margin: EdgeInsets.only(
                  left: 24 / 360 * ScreenConstants.screenWidth,
                  top: 25 / 360 * ScreenConstants.screenWidth,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Project Name",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 25 / 360 * ScreenConstants.screenWidth,
                  vertical: 10 / 360 * ScreenConstants.screenWidth,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  focusNode: _projectNameFocusNode,
                  controller: _projectNameController,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10 / 360 * ScreenConstants.screenWidth,
                      )),

                  // Rest of your TextFormField configuration
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30 / 360 * ScreenConstants.screenWidth,
                  left: 24 / 360 * ScreenConstants.screenWidth,
                  bottom: 14 / 360 * ScreenConstants.screenWidth,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Video Orientation",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            left: 24 / 360 * ScreenConstants.screenWidth,
                          ),
                          alignment: Alignment.centerLeft,
                          width: 160 / 360 * ScreenConstants.screenWidth,
                          height: 110 / 360 * ScreenConstants.screenWidth,
                          decoration: BoxDecoration(
                            color: null,
                            borderRadius: BorderRadius.circular(10 / 360 * ScreenConstants.screenWidth),
                            border: isLandscapeSelected
                                ? Border.all(
                                    color: appState.accentColor,
                                    width: 4,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                  )
                                : null,
                          ),
                          child: Material(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              shadowColor: appState.accentColor,
                              elevation: 5 / 360 * ScreenConstants.screenWidth,
                              child: InkWell(
                                  splashColor: appState.labelColor,
                                  customBorder: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isLandscapeSelected = true;
                                    });
                                  }))),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10 / 360 * ScreenConstants.screenWidth,
                          left: 20 / 360 * ScreenConstants.screenWidth,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Landscape",
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            left: 48 / 360 * ScreenConstants.screenWidth,
                            right: 24 / 360 * ScreenConstants.screenWidth,
                          ),
                          alignment: Alignment.centerLeft,
                          width: 90 / 360 * ScreenConstants.screenWidth,
                          height: 110 / 360 * ScreenConstants.screenWidth,
                          decoration: BoxDecoration(
                            color: null,
                            borderRadius: BorderRadius.circular(10 / 360 * ScreenConstants.screenWidth),
                            border: !isLandscapeSelected ? Border.all(color: appState.accentColor, width: 4, strokeAlign: BorderSide.strokeAlignCenter) : null,
                          ),
                          child: Material(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              shadowColor: appState.accentColor,
                              elevation: 5 / 360 * ScreenConstants.screenWidth,
                              child: InkWell(
                                  splashColor: appState.labelColor,
                                  customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                  onTap: () {
                                    setState(() {
                                      isLandscapeSelected = false;
                                    });
                                  }))),
                      Container(
                        margin: EdgeInsets.only(top: 10 / 360 * ScreenConstants.screenWidth, left: 25 / 360 * ScreenConstants.screenWidth),
                        alignment: Alignment.center,
                        child: Text(
                          "Portrait",
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  alignment: Alignment.center,
                  height: 40 / 360 * ScreenConstants.screenWidth,
                  width: 110 / 360 * ScreenConstants.screenWidth,
                  margin: EdgeInsets.only(right: 24 / 360 * ScreenConstants.screenWidth, top: 10 / 360 * ScreenConstants.screenWidth),
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(appState.accentColor),
                        foregroundColor: MaterialStatePropertyAll(appState.labelTextColor),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, nextPage);
                      },
                      icon: Image.asset(
                        "assets/icons/next_page.png",
                        width: 24 / 360 * ScreenConstants.screenWidth,
                        height: 24 / 360 * ScreenConstants.screenWidth,
                        color: appState.labelTextColor,
                        fit: BoxFit.contain,
                      ),
                      label: Text("Next")),
                ),
              )
            ],
          )
        ]));
  }
}
