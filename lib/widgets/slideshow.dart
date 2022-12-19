import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  const Slideshow({
    Key? key,
    required this.slides,
    this.dotsOnTop = false,
    this.dotPrimaryColor = Colors.pink,
    this.dotSecondaryColor = Colors.lightBlue,
    this.activePageDotSize = 15,
    this.inactivePageDotSize = 10,
  }) : super(key: key);

  final List<Widget> slides;
  final bool dotsOnTop;
  final Color dotPrimaryColor;
  final Color dotSecondaryColor;
  final int activePageDotSize;
  final int inactivePageDotSize;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Builder(
              builder: (context) {
                Provider.of<_SlideshowModel>(context).setDotPrimaryColor =
                    dotPrimaryColor;
                Provider.of<_SlideshowModel>(context).setDotSecondaryColor =
                    dotSecondaryColor;
                Provider.of<_SlideshowModel>(context).setActivePageDotSize =
                    activePageDotSize;
                Provider.of<_SlideshowModel>(context).setInactivePageDotSize =
                    inactivePageDotSize;

                return Column(
                  children: [
                    if (dotsOnTop) _Dots(totalDots: slides.length),
                    _Slides(widgetSlides: slides),
                    if (!dotsOnTop) _Dots(totalDots: slides.length),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.totalDots});

  final int totalDots;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalDots, (index) => _Dot(index: index))),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final slideShowModel = Provider.of<_SlideshowModel>(context);

    var widthAndHeigth = (slideShowModel.getCurrentPage >= index - 0.5 &&
            slideShowModel.getCurrentPage <= index + 0.5)
        ? slideShowModel.getactivePageDotSize.toDouble()
        : slideShowModel.getInactivePageDotSize.toDouble();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widthAndHeigth,
      height: widthAndHeigth,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (slideShowModel.getCurrentPage >= index - 0.5 &&
                slideShowModel.getCurrentPage <= index + 0.5)
            ? slideShowModel.getDotPrimaryColor
            : slideShowModel.getDotSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({required this.widgetSlides});

  final List<Widget> widgetSlides;

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    pageViewController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).setCurrentPage =
          pageViewController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PageView(
      controller: pageViewController,
      children: widget.widgetSlides.map((slide) {
        return _Slide(child: slide);
      }).toList(),
    ));
  }
}

class _Slide extends StatelessWidget {
  const _Slide({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        child: child);
  }
}

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _dotPrimaryColor = Colors.black;
  Color _dotSecondaryColor = Colors.grey;
  int _activePageDotSize = 15;
  int _inactivePageDotSize = 10;

  double get getCurrentPage => _currentPage;
  Color get getDotPrimaryColor => _dotPrimaryColor;
  Color get getDotSecondaryColor => _dotSecondaryColor;
  int get getactivePageDotSize => _activePageDotSize;
  int get getInactivePageDotSize => _inactivePageDotSize;

  set setCurrentPage(double currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  set setDotPrimaryColor(Color primaryColor) {
    _dotPrimaryColor = primaryColor;
  }

  set setDotSecondaryColor(Color secondaryColor) {
    _dotSecondaryColor = secondaryColor;
  }

  set setActivePageDotSize(int activeSize) {
    _activePageDotSize = activeSize;
  }

  set setInactivePageDotSize(int inactiveSize) {
    _inactivePageDotSize = inactiveSize;
  }
}
