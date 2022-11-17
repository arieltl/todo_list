import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SectionSideBar extends StatefulWidget {
  const SectionSideBar({super.key});

  @override
  State<SectionSideBar> createState() => _SectionSideBarState();
}

class _SectionSideBarState extends State<SectionSideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ]),
    );
  }
}
