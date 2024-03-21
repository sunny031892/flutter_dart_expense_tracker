import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final PageController _pageController = PageController(initialPage: 0);

  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          _buildParallaxPage(
            text: 'Press Add button at the upper-right corner to track a new expense.',
            buttonText: 'Next',
            onPressed: () {
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            pageController: _pageController,
            pageIndex: 0,
            iconData: Icons.add,
          ),
          _buildParallaxPage(
            text: 'Swipe a tracked expense left or right to delete it.',
            buttonText: 'Done',
            onPressed: () {
              Navigator.pop(context);
            },
            pageController: _pageController,
            pageIndex: 1,
            iconData: Icons.touch_app,
          ),
        ],
      ),
    );
  }

  Widget _buildParallaxPage({
    required String text,
    required String buttonText,
    required VoidCallback onPressed,
    required PageController pageController,
    required int pageIndex,
    IconData? iconData,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double pageOffset = 1.0;
        if (pageController.position.haveDimensions) {
          pageOffset = pageController.page! - pageIndex;
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconData != null)
                Transform.translate(
                  offset: Offset(-pageOffset, 0),
                  child: Opacity(
                    opacity: (1 - pageOffset.abs()).clamp(0.0, 1.0),
                    child: Icon(
                      iconData,
                      size: screenWidth * 0.15,
                      color: Colors.white,
                    ),
                  ),
                ),
              SizedBox(height: 48), 
              Transform.translate(
                offset: Offset(-pageOffset * screenWidth * 0.5, 0),
                child: Opacity(
                  opacity: (1 - pageOffset.abs()).clamp(0.0, 1.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Transform.translate(
                offset: Offset(-pageOffset * screenWidth * 1, 0),
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
