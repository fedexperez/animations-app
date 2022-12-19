import 'package:animations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlideshowScreen extends StatelessWidget {
  const SlideshowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Slideshow(
              slides: [
                SvgPicture.asset('assets/images/svgs/slide-1.svg'),
                SvgPicture.asset('assets/images/svgs/slide-2.svg'),
                SvgPicture.asset('assets/images/svgs/slide-2.svg'),
                SvgPicture.asset('assets/images/svgs/slide-2.svg'),
                const Icon(Icons.mail)
              ],
            ),
          ),
          Expanded(
            child: Slideshow(
              dotsOnTop: true,
              activePageDotSize: 28,
              slides: [
                SvgPicture.asset('assets/images/svgs/slide-1.svg'),
                SvgPicture.asset('assets/images/svgs/slide-2.svg'),
                SvgPicture.asset('assets/images/svgs/slide-2.svg'),
                SvgPicture.asset('assets/images/svgs/slide-2.svg'),
                const Icon(Icons.mail)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
