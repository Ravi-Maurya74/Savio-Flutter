import 'package:flutter/material.dart';
import 'package:savio/constants/decorations.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(26, 172, 172, 172),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              title,
              style: titleStyle,
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
