import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,
      child: Image.asset("assets/images/friendship.png"),
    );
  }
}
