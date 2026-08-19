import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo/intro/start_screen.dart';

class OnboadingScreen extends StatefulWidget {
  const OnboadingScreen({super.key});

  @override
  State<OnboadingScreen> createState() => _OnboadingScreenState();
}

class _OnboadingScreenState extends State<OnboadingScreen> {
  final CarouselSliderController controller = CarouselSliderController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    late double h = MediaQuery.of(context).size.height;
    late double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Container(
            width: w * 1,
            height: h * 1,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.black),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: onboardingData.length,
                    options: CarouselOptions(
                      height: h * 1,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      final item = onboardingData[index];

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/start');
                                  },
                                  child: Text(
                                    'SKIP',
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            height: h * 0.3,
                            width: w * 0.5,
                            // color: Colors.red,
                            child: Image.asset(item.image, fit: BoxFit.contain),
                          ),

                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: w * 0.08,
                            ),
                          ),

                          Text(
                            item.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: w * 0.04,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 25,
                                    ),
                                    shape: RoundedRectangleBorder(),
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    controller.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Text(
                                    "Back",
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 23,
                                    ),
                                    shape: RoundedRectangleBorder(),
                                    backgroundColor: Color(0xff8875FF),
                                  ),
                                  onPressed: () {
                                    if (currentIndex <
                                        onboardingData.length - 1) {
                                      controller.nextPage(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      Navigator.pushNamed(context, '/start');
                                    }
                                  },
                                  child: Text(
                                    currentIndex == onboardingData.length - 1
                                        ? "Get Started"
                                        : "Next",
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingModel> onboardingData = [
  OnBoardingModel(
    image: "assets/images/Group 182.png",
    title: "Manage your tasks",
    description:
        'You can easily manage all of your daily \ntasks in DoMe for free',
  ),
  OnBoardingModel(
    image: "assets/images/Frame 162.png",
    title: "Create daily routine",
    description:
        'In Uptodo  you can create your\n personalized routine to stay productive',
  ),
  OnBoardingModel(
    image: "assets/images/Frame 161.png",
    title: "Orgonaize your tasks",
    description:
        'You can organize your daily tasks by\n adding your tasks into separate categories',
  ),
];
