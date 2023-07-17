import 'package:kaptur_alpha_v1/routes.dart';
import 'package:kaptur_alpha_v1/sreen_constants.dart';
import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'CameraModule.dart';
import 'color_calculation.dart';
import 'package:provider/provider.dart';
import 'generate_video_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'generate_video_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'generate_video_page.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
  ].request();

  if (statuses[Permission.camera] != PermissionStatus.granted || statuses[Permission.microphone] != PermissionStatus.granted) {
    showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Required'),
          content: Text('Camera and microphone permissions are required to use this app'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK.'),
            )
          ],
        );
      },
      context: navigatorKey.currentContext!,
    );
    return;
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class CombinedWidget extends StatefulWidget {
  const CombinedWidget({Key? key}) : super(key: key);

  @override
  _CombinedWidgetState createState() => _CombinedWidgetState();
}

class _CombinedWidgetState extends State<CombinedWidget> {
  List<String> selectedImageUrls = [];
  List<File> capturedImages = [];

  void toggleImageSelection(String imageUrl) {
    setState(() {
      if (selectedImageUrls.contains(imageUrl)) {
        selectedImageUrls.remove(imageUrl);
      } else {
        selectedImageUrls.add(imageUrl);
      }
    });
  }

  void onGenerateButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenerateVideoPage(
          selectedImageUrls: selectedImageUrls,
          capturedImages: capturedImages,
          selectedImages: [],
          videoPath: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                "My New Project.",
                textAlign: TextAlign.center,
                style: GoogleFonts.gloock(
                  fontSize: 60 / 360 * ScreenConstants.screenWidth,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: capturedImages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return IconButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          XFile? image = await showDialog<XFile>(
                              context: context,
                              builder: (c) {
                                return CameraModule();
                              });
                          print(image?.path);
                          // final XFile? img = await _picker.pickImage(source: ImageSource.camera);
                          // Navigator.pushNamed(context, camera);
                          if (image != null) {
                            setState(() {
                              capturedImages.add(File(image.path));
                            });
                          }
                        },
                        icon: Icon(Icons.camera),
                      );
                    }

                    final imageFile = capturedImages[index - 1];
                    final isSelected = selectedImageUrls.contains(imageFile.path);

                    return GestureDetector(
                      onTap: () {
                        toggleImageSelection(imageFile.path);
                      },
                      child: Stack(
                        children: [
                          Image.file(imageFile),
                          if (isSelected)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: selectedImageUrls.map((imageUrl) {
                  return Chip(
                    label: Text(imageUrl),
                    onDeleted: () {
                      toggleImageSelection(imageUrl);
                    },
                  );
                }).toList(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      onGenerateButtonPressed(context);
                    },
                    icon: Icon(Icons.play_arrow),
                    label: Text('Generate'),
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
