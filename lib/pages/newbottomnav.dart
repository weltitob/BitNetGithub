import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomBar extends StatefulWidget {
  final Widget child;
  final int currentPage;
  final TabController tabController;
  final List<Color> colors;
  final Color unselectedColor;
  final Color barColor;
  final double end;
  final double start;
  const BottomBar({
    required this.child,
    required this.currentPage,
    required this.tabController,
    required this.colors,
    required this.unselectedColor,
    required this.barColor,
    required this.end,
    required this.start,
    Key? key,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  ScrollController scrollBottomBarController = ScrollController();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late int currentPage;
  bool isScrollingDown = false;
  bool isOnTop = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, widget.end),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    _controller.forward();
  }


  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }


  @override
  void dispose() {
    scrollBottomBarController.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: widget.start,
          child: SlideTransition(
            position: _offsetAnimation,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Material(
                    color: widget.barColor,
                    child: TabBar(
                      indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      controller: widget.tabController,
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: widget.currentPage == 0
                                  ? widget.colors[0]
                                  : widget.currentPage == 1
                                  ? widget.colors[1]
                                  : widget.currentPage == 2
                                  ? widget.colors[2]
                                  : widget.currentPage == 3
                                  ? widget.colors[3]
                                  : widget.currentPage == 4
                                  ? widget.colors[4]
                                  : widget.unselectedColor,
                              width: 4),
                          insets: EdgeInsets.fromLTRB(16, 0, 16, 8)),
                      tabs: [
                        SizedBox(
                          height: 55,
                          width: 40,
                          child: Center(
                              child: Icon(
                                Icons.home,
                                color: widget.currentPage == 0
                                    ? widget.colors[0]
                                    : widget.unselectedColor,
                              )),
                        ),
                        SizedBox(
                          height: 55,
                          width: 40,
                          child: Center(
                              child: Icon(
                                Icons.search,
                                color: widget.currentPage == 1
                                    ? widget.colors[1]
                                    : widget.unselectedColor,
                              )),
                        ),
                        SizedBox(
                          height: 55,
                          width: 40,
                          child: Center(
                              child: Icon(
                                Icons.add,
                                color: widget.currentPage == 2
                                    ? widget.colors[2]
                                    : widget.unselectedColor,
                              )),
                        ),
                        SizedBox(
                          height: 55,
                          width: 40,
                          child: Center(
                              child: Icon(
                                Icons.favorite,
                                color: widget.currentPage == 3
                                    ? widget.colors[3]
                                    : widget.unselectedColor,
                              )),
                        ),
                        SizedBox(
                          height: 55,
                          width: 40,
                          child: Center(
                              child: Icon(
                                Icons.settings,
                                color: widget.currentPage == 4
                                    ? widget.colors[4]
                                    : widget.unselectedColor,
                              )),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}