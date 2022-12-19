import 'package:animations/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final void Function() onPressed;
  final IconData icon;

  PinterestButton({required this.onPressed, required this.icon});
}

class PinterestMenu extends StatelessWidget {
  const PinterestMenu(
      {super.key,
      required this.show,
      this.backgroundColor = Colors.white,
      this.activeColor = Colors.red,
      this.inactiveColor = Colors.grey,
      required this.buttons});
  final bool show;

  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  final List<PinterestButton> buttons;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => _PinterestModel()),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: (show) ? 1 : 0,
        child: Builder(
          builder: (context) {
            Provider.of<_PinterestModel>(context).backgroundColor =
                backgroundColor;
            Provider.of<_PinterestModel>(context).activeColor = activeColor;
            Provider.of<_PinterestModel>(context).inactiveColor = inactiveColor;

            return _PinterestMenuBackground(
              child: _MenuItems(menuItems: buttons),
            );
          },
        ),
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  const _PinterestMenuBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        Provider.of<_PinterestModel>(context).backgroundColor;

    return Container(
      width: 250,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black38, blurRadius: 8, spreadRadius: -5)
        ],
        color: backgroundColor,
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  const _MenuItems({required this.menuItems});

  final List<PinterestButton> menuItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          menuItems.length,
          (index) => _PinterestMenuButton(
                index: index,
                item: menuItems[index],
              )),
    );
  }
}

class _PinterestMenuButton extends StatefulWidget {
  const _PinterestMenuButton({required this.index, required this.item});

  final int index;
  final PinterestButton item;

  @override
  State<_PinterestMenuButton> createState() => _PinterestMenuButtonState();
}

class _PinterestMenuButtonState extends State<_PinterestMenuButton> {
  @override
  Widget build(BuildContext context) {
    final selectedItem = Provider.of<_PinterestModel>(context)._selectedItem;
    final activeColor = Provider.of<_PinterestModel>(context).activeColor;
    final inactiveColor = Provider.of<_PinterestModel>(context).inactiveColor;

    return ChangeNotifierProvider(
      create: (context) => MenuModel(),
      child: IconButton(
        icon: Icon(
          widget.item.icon,
          size: 25,
          color: (selectedItem == widget.index) ? activeColor : inactiveColor,
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: (!Provider.of<MenuModel>(context).getShow)
            ? null
            : () {
                Provider.of<_PinterestModel>(context, listen: false)
                    .setSelectedItem = widget.index;
                return widget.item.onPressed();
              },
      ),
    );
  }
}

class _PinterestModel with ChangeNotifier {
  int _selectedItem = 0;

  Color backgroundColor = Colors.white;
  Color activeColor = Colors.red.shade600;
  Color inactiveColor = Colors.grey.shade600;

  int get getSelectedItem => _selectedItem;

  set setSelectedItem(int selectedItem) {
    _selectedItem = selectedItem;
    notifyListeners();
  }
}
