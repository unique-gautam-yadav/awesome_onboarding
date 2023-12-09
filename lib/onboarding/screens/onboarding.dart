import 'dart:math';

import 'package:flutter/material.dart';
import '../data/data.dart';
import '../custom/custom_bg.dart';
import '../widgets/item_card.dart';
import '../widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Color> myColors = [
    Colors.indigoAccent.shade100,
    Colors.teal.shade100,
    Colors.blueGrey.shade200,
    Colors.greenAccent.shade200
  ];

  late PageController pageController;
  late int selectedIndex;
  late double pageValue;

  @override
  void initState() {
    selectedIndex = 0;
    pageValue = 0.0;
    pageController =
        PageController(initialPage: selectedIndex, viewportFraction: 1.0)
          ..addListener(() {
            setState(() {
              pageValue = pageController.page!;
            });
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: myColors[selectedIndex].withOpacity(0.4),
        child: Stack(
          alignment: Alignment.topLeft,
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            pageValue < 1.001
                ? Positioned(
                    left: 320 - (pageValue * 300),
                    top: 450 - (pageValue * 400),
                    child: blackBall(20 + pageValue * 20),
                  )
                : pageValue < 1.003
                    ?

                    /// big ball in top left
                    Positioned(
                        left: 20,
                        top: 50,
                        child: blackBall(40),
                      )
                    :

                    /// small ball in right
                    Positioned(
                        left: 20 + ((pageValue - 1) * 300),
                        top: 50 + ((pageValue - 1) * 100),
                        child: blackBall(40 - ((pageValue - 1) * 10)),
                      ),

            // THE BACKGROUND TUBE SHAPE IN GREEN COLOR
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              left: pageValue * -w,
              top: 0,
              child: Container(
                height: h,
                width: w * 3,
                decoration: const BoxDecoration(),
                child: CustomPaint(
                  painter: OnBoardingBackground(),
                ),
              ),
            ),

            // BALL TWO BLACK but it will go above the green background tube from page 1 to 2
            // then it will dissappear
            pageValue < 1.001

                /// small ball in center left
                ? Positioned(
                    left: 320 - (pageValue * 300),
                    top: 450 - (pageValue * 400),
                    child: blackBall(20 + pageValue * 20),
                  )
                : const SizedBox.shrink(),

            /// tube in first page center left
            // pageValue < 1.001 ?
            Positioned(
              left: -35,
              top: 350,
              child: AbsorbPointer(
                child: Transform.rotate(
                    angle: -1 * pi * pageValue,
                    alignment: Alignment.center,
                    child: ClipPath(
                      clipper: TubePath(),
                      child: AnimatedContainer(
                        height: 100,
                        width: 100,
                        alignment: Alignment.topRight,
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: myColors[selectedIndex],
                          // border: Border.all(color: Colors.red, width: 3),
                        ),
                      ),
                    )),
              ),
            ),

            /// tube in first page center-top-right
            Positioned(
              right: -15,
              top: 200,
              child: AbsorbPointer(
                child: Transform.rotate(
                    angle: -0.7 * pi * pageValue,
                    alignment: Alignment.center,
                    child: ClipPath(
                      clipper: TubePath(),
                      child: AnimatedContainer(
                        height: 100,
                        width: 100,
                        alignment: Alignment.topRight,
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: myColors[selectedIndex],
                          // border: Border.all(color: Colors.red, width: 3),
                        ),
                      ),
                    )),
              ),
            ),

            // BALL ONE BLACK
            // // page one , big ball in top left
            pageValue < 1.001

                /// big ball in top left
                ? Positioned(
                    left: 20 + (pageValue * 300),
                    top: 50 + (pageValue * 400),
                    child: blackBall(40 - pageValue * 20),
                  )
                : pageValue < 1.003

                    /// small ball in center right
                    ? Positioned(
                        left: 20 + (1.001 * 300),
                        top: 50 + (1.001 * 400),
                        child: blackBall(40 - 1.001 * 20),
                      )

                    /// big ball in center left
                    : Positioned(
                        left: 320 - (-(1 - pageValue) * 350),
                        top: 50 + (1.001 * 400) + ((1 - pageValue) * -175),
                        child: blackBall(
                            40 - (1.001 * 20) + ((pageValue - 1) * 30)),
                      ),

            // BIG WHITE-GREY BALL
            // /// page one , big ball in center left
            pageValue < 1.001
                ? Positioned(
                    left: 20 + (pageValue * 140),
                    top: 450 + (pageValue * 200),
                    child: greyBall(100 - pageValue * 20),
                  )
                : Positioned(
                    left: 160 + ((pageValue - 1) * 150),
                    top: 650 - ((pageValue - 1) * 230),
                    child: greyBall(100 + pageValue * 20),
                  ),

            // THE ROTATING TRIANGLE IN TOP
            /// page one , triangle top center
            pageValue < 1.001
                ? Positioned(
                    top: -30,
                    left: w / 1.8 - (pageValue * 175),
                    height: 100,
                    width: 100,
                    child: Transform.rotate(
                      alignment: Alignment.center,
                      angle: pi / 3 * pageValue + 0.9,
                      child: ClipPath(
                        clipper: TrianglePath(),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          color: myColors[selectedIndex + 1].withOpacity(0.8),
                        ),
                      ),
                    ))
                : Positioned(
                    top: -30,
                    left: w / 1.8 - (pageValue * 175),
                    height: 100,
                    width: 100,
                    child: Transform.rotate(
                      alignment: Alignment.center,
                      angle: pi / 3 * pageValue + 0.9,
                      child: ClipPath(
                        clipper: TrianglePath(),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          color: myColors[selectedIndex + 1].withOpacity(0.9),
                        ),
                      ),
                    )),

            Positioned(
                bottom: -40,
                left: w * 0.15,
                height: 100,
                width: 100,
                child: Transform.rotate(
                  alignment: Alignment.center,
                  angle: pi / 3 * pageValue + 0.9,
                  child: AnimatedContainer(
                    height: 200,
                    width: 200,
                    duration: const Duration(milliseconds: 300),
                    color: myColors[selectedIndex + 1].withOpacity(0.9),
                  ),
                )),
            Positioned(
              bottom: -60,
              left: w * 0.45,
              height: 150,
              width: 100,
              child: Transform.rotate(
                alignment: Alignment.center,
                angle: pi / 2 * pageValue + 0.2,
                child: AnimatedContainer(
                  height: 200,
                  width: 200,
                  duration: const Duration(milliseconds: 300),
                  color: myColors[selectedIndex].withOpacity(0.9),
                ),
              ),
            ),
            Positioned(
              height: h * 0.85,
              width: w,
              child: Center(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: ItemCard(
                        item: items[index],
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              // height: h * 0.15,
              width: w,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: pageValue >= 1.8 ? 0 : 1,
                      duration: const Duration(milliseconds: 400),
                      child: InkWell(
                        onTap: () {
                          pageController.animateToPage(2,
                              duration: Duration(
                                  milliseconds:
                                      selectedIndex == 0 ? 1500 : 600),
                              curve: Curves.easeIn);
                        },
                        onLongPress: () {
                          // context.go(AppRoutes.homeRoute.path);
                        },
                        child: const Text(
                          "Skip",
                          textScaleFactor: 1.7,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (pageValue < 2.0) {
                          pageController.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.ease);
                        } else {
                          // context.go(AppRoutes.authRoute.path);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: AnimatedCrossFade(
                          duration: const Duration(milliseconds: 500),
                          // height: 50,
                          crossFadeState: pageValue < 2.0
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: const Center(
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          secondChild: const Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
