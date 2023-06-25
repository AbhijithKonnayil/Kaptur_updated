import 'package:flutter/material.dart';
import 'package:kaptur_alpha_v1/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:kaptur_alpha_v1/sreen_constants.dart';
import 'color_calculation.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: 2),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin: EdgeInsets.only(top: 75 / 360 * ScreenConstants.screenWidth),
        child: Column(
          children: [
            Text(
              "Profile.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   "Login to use Cloud Services",
                    //   style: Theme.of(context).textTheme.titleMedium,
                    //   textAlign: TextAlign.center,
                    // ),
                    Container(
                      height: 45 / 360 * ScreenConstants.screenWidth,
                      width: 320 / 360 * ScreenConstants.screenWidth,
                      margin: EdgeInsets.only(
                          top: 10 / 360 * ScreenConstants.screenWidth),
                      child: FilledButton.icon(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(appState.accentColor),
                          overlayColor:
                              MaterialStatePropertyAll(appState.accentColor),
                          foregroundColor:
                              MaterialStatePropertyAll(appState.labelTextColor),
                        ),
                        icon: Image.asset(
                          'assets/icons/google.png',
                          width: 32 / 360 * ScreenConstants.screenWidth,
                          height: 32 / 360 * ScreenConstants.screenWidth,
                        ),
                        label: Text(
                          "Login with Google Account",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 14,
                      child: Text(
                        "OR",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: appState.accentColor),
                      ),
                    ),
                    Container(
                      height: 45 / 360 * ScreenConstants.screenWidth,
                      width: 320 / 360 * ScreenConstants.screenWidth,
                      margin: EdgeInsets.only(
                          top: 10 / 360 * ScreenConstants.screenWidth),
                      child: FilledButton.icon(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(appState.accentColor),
                          overlayColor:
                              MaterialStatePropertyAll(appState.accentColor),
                          foregroundColor:
                              MaterialStatePropertyAll(appState.labelTextColor),
                        ),
                        icon: Image.asset(
                          'assets/icons/apple.png',
                          width: 32,
                          height: 32,
                        ),
                        label: Text(
                          "Login with Apple ID",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
