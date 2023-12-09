import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const Spacer(),
        const Spacer(),
        const Spacer(),
        const Spacer(),
        SizedBox(
          height: h * 0.50,
          width: w,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Lottie.asset(
              item.lottie,
              fit: BoxFit.cover,
            ),
            // child: Placeholder(
            //   color: Colors.black,
            // ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.10,
                // child: const Placeholder(),
                child: Text(
                  item.title,
                  textScaleFactor: 2.5,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      letterSpacing: 1.5,
                      wordSpacing: 7),
                ),
              ),
              SizedBox(height: h * 0.03),
              SizedBox(
                  height: h * 0.12,
                  // child: const Placeholder(),
                  child: Text(
                    item.description,
                    textScaleFactor: 1.1,
                    style: TextStyle(
                      height: 1.2,
                      wordSpacing: 5,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
