import 'package:flutter/material.dart';

class FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageViewer({
    Key? key,
    required this.images,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _FullScreenImageViewerState createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  void _goToPage(int index) {
    if (index >= 0 && index < widget.images.length) {
      _pageController.jumpToPage(index);
      setState(() => currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Images avec swipe
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  child: Image.network(
                    widget.images[index],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),

          // Bouton fermer
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Flèche gauche
          if (currentIndex > 0)
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 40),
                onPressed: () => _goToPage(currentIndex - 1),
              ),
            ),

          // Flèche droite
          if (currentIndex < widget.images.length - 1)
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 40),
                onPressed: () => _goToPage(currentIndex + 1),
              ),
            ),
        ],
      ),
    );
  }
}
