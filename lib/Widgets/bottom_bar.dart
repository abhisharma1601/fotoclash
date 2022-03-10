import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Screens/Chats/chat_home.dart';
import 'package:fotoclash/Screens/Join-createContest/screen1.dart';
import 'package:fotoclash/Screens/profile.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;
  const BottomNavBar(
      {required this.index, required this.onChangedTab, Key? key})
      : super(key: key);

  @override
  _BottomNavBar createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    const placeholder = Opacity(
      opacity: 0,
      child: IconButton(icon: Icon(Icons.no_cell), onPressed: null),
    );
    Size size = MediaQuery.of(context).size;
    double height = 56;
    const primaryColor = Colors.orange;
    const secondaryColor = Colors.white;
    const backgroundColor = Color(0xFF263238);

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, height + 6),
            painter: BottomNavCurvePainter(backgroundColor: backgroundColor),
          ),
          Center(
            heightFactor: 0.6,
            child: Container(
                // height: MediaQuery.of(context).size.height*56/812,
                // width: MediaQuery.of(context).size.width*56/375,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(166, 203, 255, 1),
                      Color.fromRGBO(77, 123, 216, 1),
                      Color.fromRGBO(175, 47, 32, 1),
                      Color.fromRGBO(244, 157, 99, 1),
                    ])),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 50,
                )),
          ),
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTabItem(
                    index: 0,
                    icon: const Icon(
                      CupertinoIcons.home,
                      size: 30,
                    )),
                buildTabItem(
                    index: 1,
                    icon: const Icon(
                      CupertinoIcons.compass,
                      size: 30,
                    )),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => ContestS()));
                    },
                    child: placeholder),
                buildTabItem(
                    index: 2,
                    icon: const Icon(
                      CupertinoIcons.chat_bubble,
                      size: 30,
                    )),
                buildTabItem(
                    index: 3,
                    icon: const Icon(
                      CupertinoIcons.person_fill,
                      size: 30,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({
    required int index,
    required Icon icon,
  }) {
    final isSelected = index == widget.index;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconTheme(
          data: IconThemeData(
            color: isSelected ? Colors.red : Colors.white,
          ),
          child: IconButton(
            icon: icon,
            onPressed: () => widget.onChangedTab(index),
          ),
        ),
      ],
    );
  }
}

class BottomNavCurvePainter extends CustomPainter {
  BottomNavCurvePainter(
      {this.backgroundColor = Colors.white, this.insetRadius = 38});

  Color backgroundColor;
  double insetRadius;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);

    double insetCurveBeginnningX = size.width / 2 - insetRadius;
    double insetCurveEndX = size.width / 2 + insetRadius;
    double transitionToInsetCurveWidth = size.width * .05;
    path.quadraticBezierTo(size.width * 0.20, 0,
        insetCurveBeginnningX - transitionToInsetCurveWidth, 0);
    path.quadraticBezierTo(
        insetCurveBeginnningX, 0, insetCurveBeginnningX, insetRadius / 2);

    path.arcToPoint(Offset(insetCurveEndX, insetRadius / 2),
        radius: const Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(
        insetCurveEndX, 0, insetCurveEndX + transitionToInsetCurveWidth, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height + 56);
    path.lineTo(0, size.height + 56);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
