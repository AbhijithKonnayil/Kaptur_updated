import 'package:flutter/material.dart';
import 'package:kaptur_alpha_v1/sreen_constants.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'color_calculation.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  const BottomNavBar({super.key, required this.index});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedItemPosition = 1;

  @override
  void initState() {
    super.initState();
    _selectedItemPosition = widget.index;
  }

  final int currentIndex = 0;
  final SnakeShape snakeShape = SnakeShape.circle;
  final SnakeBarBehaviour behaviour = SnakeBarBehaviour.pinned;
  final ShapeBorder shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)));

  final ValueChanged<int> onTap = ((value) => {});

  @override
  Widget build(BuildContext context) {
    double width = 36;
    final appState = Provider.of<AppState>(context);
    return SnakeNavigationBar.color(
        backgroundColor: appState.labelColor,
        behaviour: behaviour,
        snakeShape: SnakeShape.circle,
        padding: EdgeInsets.symmetric(horizontal: 20 / 360 * ScreenConstants.screenWidth, vertical: 20 / 360 * ScreenConstants.screenWidth),
        shape: shape,
        snakeViewColor: _selectedItemPosition <= 2 ? appState.accentColor : null,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedItemPosition,
        onTap: (index) {
          switch (index) {
            case 0:
              setState(() => _selectedItemPosition = index);
              Navigator.pushNamed(context, settings);
              break;
            case 1:
              setState(() => _selectedItemPosition = index);
              Navigator.pushNamed(context, home);
              break;
            case 2:
              setState(() => _selectedItemPosition = index);
              Navigator.pushNamed(context, profile);
              break;
            default:
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: _selectedItemPosition == 0
                ? Image.asset(
                    "assets/icons/settings_filled.png",
                    width: width,
                    height: width,
                  )
                : Image.asset(
                    "assets/icons/settings.png",
                    width: width,
                    height: width,
                  ),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: _selectedItemPosition == 1
                ? Image.asset(
                    "assets/icons/home_filled.png",
                    width: width,
                    height: width,
                  )
                : Image.asset(
                    "assets/icons/home.png",
                    width: width,
                    height: width,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedItemPosition == 2
                ? Image.asset(
                    "assets/icons/profile_cat_filled.png",
                    width: width,
                    height: width,
                  )
                : Image.asset(
                    "assets/icons/profile_cat.png",
                    width: width,
                    height: width,
                  ),
            label: 'Profile',
          ),
        ]);
  }
}
