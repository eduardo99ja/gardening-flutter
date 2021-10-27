import 'package:flutter/material.dart';

class BackLayout extends StatelessWidget {
  final Widget child;
  final Size size;

  BackLayout({required this.child, required this.size});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: child,
        ),
        isFullScreen(
          size,
          Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        )
            ? Container()
            : Container()
      ],
    );
  }
}

bool isFullScreen(Size currentSize, Size fullSize) {
  print("$fullSize == $currentSize");

  if (currentSize.height == fullSize.height && fullSize.width == currentSize.width)
    return true;
  else
    return false;
}
