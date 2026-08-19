import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'focus_provider.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FocusProvider>(
      builder: (context, focusProvider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Text('Focus Mode',style: GoogleFonts.lato(
            ),),
            centerTitle: true,
          ),
          body:
          SingleChildScrollView(
            child: Column(
              children: [
                //-------------------------Circular Counter-------------------------------------->
                SizedBox(
                  height: 250,
                  child: CircularCountDownTimer(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    controller: focusProvider.countDownController,
                    duration: focusProvider.totalDuration,
                    fillColor: Color.fromRGBO(134, 135, 231, 1),
                    isTimerTextShown: true,
                    ringColor: Color.fromRGBO(85, 85, 85, 1),
                    strokeWidth: 15.0,
                    isReverse: true,
                    isReverseAnimation: true,
                    autoStart: false,
                    strokeCap: StrokeCap.round,
                    textStyle: TextStyle(
                      fontSize: 33.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textFormat: CountdownTextFormat.MM_SS,
                    onStart: (){},
                    onComplete: (){
                      focusProvider.onTimerComplete();
                    },
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  'While your focus mode is on, all of your\n notifications will be off',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color.fromRGBO(255, 255, 255, 0.87),
                  ),
                ),
                SizedBox(height: 20),
                //--------------------------------------Start Focusing----------------------------------->
                GestureDetector(
                  onTap: (){
                    if(focusProvider.isFocusing){
                      focusProvider.stopFocusing();
                    }else{
                      focusProvider.startFocusing();
                    }
                  },
                  child: Container(
                    height: 48,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(134, 135, 231, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        focusProvider.isFocusing ? 'Stop Focusing' : 'Start Focusing',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                //----------------Overview Section----------------------------------------------->
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFFDE),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Color(0x36FFFFFF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'This Week',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.87),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color.fromRGBO(255, 255, 255, 0.87),
                                size: 17,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                WeeklyOverviewGraph(),
                SizedBox(height: 10),


                Text('Applications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffFFFFDE),
                  ), textAlign:TextAlign.start,
                ),
                SizedBox(height: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUsageTile(
                      image: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/1280px-Instagram_logo_2022.svg.png?utm_source=simple.wikipedia.org&utm_campaign=index&utm_content=thumbnail',
                      width: 20,),
                      appName: 'Instagram',
                      usageText: 'You spent 4h on Instagram today',
                    ),
                    AppUsageTile(
                      image: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/1280px-Logo_of_Twitter.svg.png?utm_source=en.wikipedia.org&utm_campaign=index&utm_content=thumbnail',
                          width: 20),
                      appName: 'Twitter',
                      usageText: 'You spent 3h on Twitter today',
                        ),
                    AppUsageTile(
                      image: Image.network('https://z-m-static.xx.fbcdn.net/rsrc.php/yt/r/DUiOg0mJTjz.webp',
                          width: 20),
                      appName: 'Facebook',
                      usageText: 'You spent 1h on Facebbok today',
                    ),
                    AppUsageTile(
                      image: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/1280px-Telegram_logo.svg.png',
                          width: 20),
                      appName: 'Telegram',
                      usageText: 'You spent 30m on Telegram today',
                    ),
                    AppUsageTile(
                      image: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Gmail_icon_%282020%29.svg/250px-Gmail_icon_%282020%29.svg.png?utm_source=en.wikipedia.org&utm_campaign=parser&utm_content=thumbnail',
                      width: 20,),
                      appName: 'Gmail',
                      usageText: 'You spent 45m on Gmail today',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WeeklyOverviewGraph extends StatelessWidget {
  const WeeklyOverviewGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BarData> data = [
      BarData(
        day: 'SUN',
        hours: 2.5,
        label: '2h30m',
        isHighlighted: false,
        isToday: true,
      ),
      BarData(
        day: 'MON',
        hours: 3.5,
        label: '3h30m',
        isHighlighted: false,
        isToday: false,
      ),
      BarData(
        day: 'TUE',
        hours: 5.0,
        label: '5H',
        isHighlighted: false,
        isToday: false,
      ),
      BarData(
        day: 'WED',
        hours: 3.0,
        label: '3h',
        isHighlighted: false,
        isToday: false,
      ),
      BarData(
        day: 'THU',
        hours: 4.0,
        label: '4h',
        isHighlighted: false,
        isToday: false,
      ),
      BarData(
        day: 'FRI',
        hours: 4.5,
        label: '4h30m',
        isHighlighted: true,
        isToday: false,
      ),
      BarData(
        day: 'SAT',
        hours: 2.0,
        label: '2h',
        isHighlighted: false,
        isToday: true,
      ),
    ];

    const double maxHours = 6.0;
    const double graphHeight = 180.0;
    const double barWidth = 28.0;

    // Y-axis labels
    final List<String> yLabels = ['6h', '5h', '4h', '3h', '2h', '1h'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          // Graph area: Y-axis + Bars
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Y-Axis Labels
              SizedBox(
                height: graphHeight + 20, // +20 for a bit of top padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: yLabels
                      .map(
                        (label) => Text(
                      label,
                      style:  TextStyle(
                        color: Color(0xffFFFFDE),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
               SizedBox(width: 8),
              // Bars + Day labels
              Expanded(
                child: Column(
                  children: [
                    // Bar chart
                    SizedBox(
                      height: graphHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: data.map((bar) {
                          final double barHeight =
                              (bar.hours / maxHours) * graphHeight;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Value label above bar
                              Text(
                                bar.label,
                                style: TextStyle(
                                  color: Color(0xffFFFFDE),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                               SizedBox(height: 4),
                              // Bar
                              Container(
                                width: barWidth,
                                height: barHeight,
                                decoration: BoxDecoration(
                                  color: bar.isHighlighted
                                      ? Color(0xff8687E7)
                                      :Color(0xffA5A5A5),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                     SizedBox(height: 8),
                    // Day labels row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: data.map((bar) {
                        return SizedBox(
                          width: barWidth,
                          child: Center(
                            child: Text(
                              bar.day,
                              style: TextStyle(
                                color: bar.isToday
                                    ?  CupertinoColors.destructiveRed
                                    :  Color(0xffFFFFDE),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BarData {
  final String day;
  final double hours;
  final String label;
  final bool isHighlighted;
  final bool isToday;

  const BarData({
    required this.day,
    required this.hours,
    required this.label,
    required this.isHighlighted,
    required this.isToday,
  });
}

//-------------------------------application section Tile:---------------------


class AppUsageTile extends StatelessWidget {
  final Widget image;
  final String appName;
  final String usageText;

  const AppUsageTile({
    super.key,
    required this.image,
    required this.appName,
    required this.usageText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(76, 76, 76, 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            // Left: Icon + Text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(
                  children: [
                    image,
                     SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appName,
                          style:  TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                         SizedBox(height: 3),
                        Text(
                          usageText,
                          style:  TextStyle(
                            color: Color.fromRGBO(255, 255, 225, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Divider
            Container(
              width: 2,
              height: 50,
              color: const Color.fromRGBO(151, 151, 151, 1),
            ),
            // Right: Warning icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.error_outline,
                color: Color.fromRGBO(255, 255, 255, 0.87),
                size: 21.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}