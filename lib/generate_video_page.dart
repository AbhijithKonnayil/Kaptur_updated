import 'package:kaptur_alpha_v1/sreen_constants.dart';
import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'color_calculation.dart';
import 'package:provider/provider.dart';
import 'project_home.dart';

class GenerateVideoPage extends StatefulWidget {
  final List<String> selectedImageUrls;

  const GenerateVideoPage({Key? key, required this.selectedImageUrls})
      : super(key: key);

  @override
  _GenerateVideoPageState createState() => _GenerateVideoPageState();
}

class _GenerateVideoPageState extends State<GenerateVideoPage> {
  int selectedFramerate = 30; // Default framerate

  void onFramerateChanged(int? value) {
    if (value != null) {
      setState(() {
        selectedFramerate = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(index: 4),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 15,
                  ),
                  Text(
                    "Generate Video.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 60 / 360 * ScreenConstants.screenWidth),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Framerate:',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 8),
                        DropdownButton<int>(
                          value: selectedFramerate,
                          items: [24, 30, 60].map((value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          onChanged: onFramerateChanged,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: widget.selectedImageUrls.length,
                      itemBuilder: (context, index) {
                        final imageUrl = widget.selectedImageUrls[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle video generation
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Download'),
                        SizedBox(width: 4),
                        Icon(Icons.play_arrow),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(
                        context); // Navigate back to the previous page
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
