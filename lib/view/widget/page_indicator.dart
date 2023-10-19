import 'package:flutter/material.dart';

enum IndicatorType { CIRCLE, LINE, DIAMOND }

class PageIndicator extends StatelessWidget {
  final int? currentIndex;
  final int? pageCount;
  final Color? activeDotColor;
  final Color? inactiveDotColor;
  final IndicatorType? type;
  final VoidCallback? onTap;

  PageIndicator({
    this.currentIndex,
    this.pageCount,
    this.activeDotColor,
    this.onTap,
    this.inactiveDotColor,
    this.type,
  });

  _indicator(bool isActive) {
    return GestureDetector(
      onTap: this.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: buildIndicatorShape(type, isActive),
      ),
    );
  }

  _buildPageIndicators() {
    List<Widget> indicatorList = [];
    for (int i = 0; i < pageCount!; i++) {
      indicatorList
          .add(i <= currentIndex! ? _indicator(true) : _indicator(false));
    }
    return indicatorList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildPageIndicators(),
      ),
    );
  }

  Widget buildIndicatorShape(type, isActive) {
    double scaleFactor = isActive ? 1.2 : 1.0;
    double angle = 0.0;
    return Transform.scale(
      scale: scaleFactor,
      child: Transform.rotate(
        angle: angle,
        child: AnimatedContainer(
          height: 4.8,
          width: isActive ? 20 : 20,
          duration: Duration(milliseconds: 300),
          decoration: decoration(isActive, type),
        ),
      ),
    );
  }

  BoxDecoration decoration(bool isActive, type) {
    return BoxDecoration(
        color: isActive ? activeDotColor : inactiveDotColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              .02,
            ),
            offset: Offset(0.0, 2.0),
            blurRadius: 2.0,
          )
        ],
        borderRadius: BorderRadius.circular(10));
  }
}
