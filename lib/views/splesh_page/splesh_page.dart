

import 'package:flutter/material.dart';

class spleshScreen extends StatelessWidget {
  const spleshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: 500,
      decoration: BoxDecoration(

        image: DecorationImage(

            fit: BoxFit.cover,

            image: AssetImage('assets/images/sp2.png'))
      ),
    );
  }
}
