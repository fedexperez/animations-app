import 'dart:math';

import 'package:animations/models/models.dart';
import 'package:animations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestScreen extends StatelessWidget {
  const PinterestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuModel(),
      child: Scaffold(
        body: SafeArea(
            bottom: false,
            child: Stack(
              children: const [
                PinterestGrid(tiles: []),
                _PinterestMenuLocation()
              ],
            )),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  const _PinterestMenuLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final menuProvider = Provider.of<MenuModel>(context);

    return Positioned(
      bottom: size.height * 0.05,
      child: SizedBox(
        width: size.width,
        child: Align(
            alignment: Alignment.center,
            child: PinterestMenu(
              show: menuProvider.getShow,
              backgroundColor: const Color.fromARGB(255, 192, 222, 247),
              buttons: [
                PinterestButton(
                    onPressed: () => print('icono presioando'),
                    icon: Icons.brush),
                PinterestButton(
                    onPressed: () => print('icono 2 presioando'),
                    icon: Icons.search),
                PinterestButton(
                    onPressed: () => print('icono 3'),
                    icon: Icons.notifications),
                PinterestButton(
                    onPressed: () => print('icono 4'),
                    icon: Icons.supervised_user_circle),
              ],
            )),
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  const PinterestGrid({
    super.key,
    required this.tiles,
    this.crossAxisElements = 4,
  });

  final List<Widget> tiles;
  final int crossAxisElements;

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(15, (index) => index);
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0);
  double lastScroll = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.addListener(() {
          if (scrollController.offset.isNegative) {
            Provider.of<MenuModel>(context, listen: false).setShow = true;
          } else if (scrollController.offset > lastScroll + 0.1) {
            Provider.of<MenuModel>(context, listen: false).setShow = false;
          } else {
            Provider.of<MenuModel>(context, listen: false).setShow = true;
          }
          lastScroll = scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   controller: scrollController,
    //   itemCount: items.length,
    //   itemBuilder: (context, index) {
    //     return StaggeredGrid.count(
    //       crossAxisCount: widget.crossAxisElements,
    //       crossAxisSpacing: 4,
    //       mainAxisSpacing: 4,
    //       children: List.generate(
    //           1,
    //           (index) => StaggeredGridTile.count(
    //                 crossAxisCellCount: 2,
    //                 mainAxisCellCount: index.isEven ? 2 : 3,
    //                 child: PinterestTile(index: index),
    //               )),
    //     );
    //   },
    // );

    return ListView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      children: [
        StaggeredGrid.count(
          crossAxisCount: widget.crossAxisElements,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: List.generate(
              items.length,
              (index) => StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: index.isEven ? 2 : 3,
                    child: PinterestTile(index: index),
                  )),
        )
      ],
    );
  }

  int randomSize() => Random.secure().nextInt(widget.crossAxisElements) + 1;
}

class PinterestTile extends StatelessWidget {
  const PinterestTile({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.teal, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),
    );
  }
}
