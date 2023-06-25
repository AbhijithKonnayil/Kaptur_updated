import 'package:kaptur_alpha_v1/sreen_constants.dart';
import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'color_calculation.dart';
import 'package:provider/provider.dart';
import 'generate_video_page.dart';

class CombinedWidget extends StatefulWidget {
  const CombinedWidget({Key? key}) : super(key: key);

  @override
  _CombinedWidgetState createState() => _CombinedWidgetState();
}

class _CombinedWidgetState extends State<CombinedWidget> {
  List<String> selectedImageUrls = [];
  List<String> imageUrls = [
    'https://images.unsplash.com/photo-1560807707-8cc77767d783',
    'https://images.unsplash.com/photo-1560807707-8cc77767d783',
    'https://images.pexels.com/photos/17152018/pexels-photo-17152018/free-photo-of-thangaraj-best-photography-photos.jpeg,'
        'https://images.unsplash.com/photo-1560807707-8cc77767d783',
    'https://images.unsplash.com/photo-1560807707-8cc77767d783',
    'https://images.unsplash.com/photo-1560807707-8cc77767d783',
    'https://images.unsplash.com/photo-1560807707-8cc77767d783',
    'https://images.unsplash.com/photo-1560807707-8cc77767d783',
    'https://images.unsplash.com/photo-1560807707-8cc77767d783',
    //'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1780&q=80',
  ];

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
    List<String> selectedImageUrls = [];
    List<int> selectedImageIndices = [];

    for (int i = 0; i < imageUrls.length; i++) {
      if (selectedImageUrls.contains(imageUrls[i])) {
        selectedImageIndices.add(i);
      }
    }

    selectedImageUrls = selectedImageIndices
        .map((index) {
          return imageUrls[index];
        })
        .toList()
        .cast<String>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenerateVideoPage(
          selectedImageUrls: selectedImageUrls,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    appState.loadColorsFromSharedPreferences();

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(index: 4),
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
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 60 / 360 * ScreenConstants.screenWidth,
                    ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: imageUrls.length + 1, // Add 1 for the camera icon
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return IconButton(
                        onPressed: () {
                          // Handle camera icon click
                        },
                        icon: Icon(Icons.camera),
                      );
                    }
                    final imageUrl = imageUrls[
                        index - 1]; // Subtract 1 to account for the camera icon
                    final isSelected = selectedImageUrls.contains(imageUrl);

                    return GestureDetector(
                      onTap: () {
                        toggleImageSelection(imageUrl);
                      },
                      child: Stack(
                        children: [
                          Image.network(imageUrl),
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
                  padding: EdgeInsets.only(
                    right: 19.0 / 360 * ScreenConstants.screenWidth,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.3 / 360 * ScreenConstants.screenWidth,
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          appState.accentColor,
                        ),
                      ),
                      onPressed: () {
                        onGenerateButtonPressed(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Generate'),
                          SizedBox(width: 1),
                          Icon(Icons.play_arrow),
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
