import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';

class AppGuideDialog extends StatefulWidget {
  final double maxWidth;
  final double containerHeight;
  final int bottomItemCount;

  const AppGuideDialog({Key? key, this.maxWidth = 320, this.containerHeight = 150, this.bottomItemCount = 5}) : super(key: key);

  @override
  State<AppGuideDialog> createState() => _AppGuideDialogState();
}

class _AppGuideDialogState extends State<AppGuideDialog> with SingleTickerProviderStateMixin {
  final BottomBarController ctrl = Get.find();
  final CarouselController _carouselController = CarouselController();
  late final AnimationController _enterCtrl;
  late final Animation<Offset> _offsetAnim;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    // Animation d'entrée (slide up + scale)
    _enterCtrl = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _offsetAnim = Tween<Offset>(begin: Offset(0, 0.15), end: Offset.zero).animate(CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOut));
    _scaleAnim = Tween<double>(begin: 0.92, end: 1.0).animate(CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutBack));

    // start/stop selon visibilité
    ever<bool>(ctrl.showGuide, (visible) {
      if (visible) {
        _enterCtrl.forward(from: 0);
      } else {
        _enterCtrl.reverse();
      }
    });

    // sync carousel when index changed
    ever<int>(ctrl.currentSlideIndex, (idx) {
      if (mounted) {
        _carouselController.animateToPage(idx as int, duration: Duration(milliseconds: 350), curve: Curves.ease);
      }
    });

    ever<int>(ctrl.selectedIndex, (val) {
      // reset carousel position when changing tab
      if (mounted) _carouselController.jumpToPage(0);
    });
  }

  @override
  void dispose() {
    _enterCtrl.dispose();
    super.dispose();
  }

  double _calcLeftForContainer(BuildContext ctx, int index, double containerW, int itemCount) {
    final w = MediaQuery.of(ctx).size.width;
    final itemWidth = w / itemCount;
    final rtl = Directionality.of(ctx) == TextDirection.rtl;
    double center;
    if (!rtl) {
      center = itemWidth * index + itemWidth / 2 - containerW / 2;
    } else {
      center = w - (itemWidth * index + itemWidth / 2) - containerW / 2;
    }
    final minLeft = 8.0;
    final maxLeft = w - containerW - 8.0;
    return center.clamp(minLeft, maxLeft);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!ctrl.showGuide.value) return const SizedBox.shrink();

      final slides = ctrl.guideSlides[ctrl.selectedIndex.value];
      final containerW = widget.maxWidth.clamp(180.0, MediaQuery.of(context).size.width * 0.9);
      final left = _calcLeftForContainer(context, ctrl.selectedIndex.value, containerW, widget.bottomItemCount);
      final bottomPad = MediaQuery.of(context).padding.bottom;
      final baseBottom = 90.0 + bottomPad + 8.0; // ajuste selon la taille de ton bottom bar

      return Positioned(
        left: left,
        bottom: baseBottom,
        child: SlideTransition(
          position: _offsetAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: containerW,
                height: widget.containerHeight,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [ BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0,4)) ],
                ),
                child: Column(
                  children: [
                    // header (close)
                    Row(
                      children: [
                        Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () => ctrl.closeGuide(),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                            child: Icon(Icons.close, color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),

                    // carousel content
                    Expanded(
                      child: CarouselSlider.builder(
                        carouselController: _carouselController,
                        itemCount: slides.length,
                        itemBuilder: (context, idx, realIdx) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(slides[idx], textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14)),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          viewportFraction: 1.0,
                          initialPage: ctrl.currentSlideIndex.value,
                          onPageChanged: (index, reason) {
                            ctrl.currentSlideIndex.value = index;
                          },
                        ),
                      ),
                    ),

                    // indicator + next button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(slides.length, (i) {
                            final active = ctrl.currentSlideIndex.value == i;
                            return AnimatedContainer(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              width: active ? 10 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: active ? Colors.white : Colors.white30,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              duration: Duration(milliseconds: 250),
                            );
                          }),
                        ),
                        ElevatedButton(
                          onPressed: () => ctrl.nextGuideAction(),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          child: Text('التالي', style: TextStyle(color: Colors.black87)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}


