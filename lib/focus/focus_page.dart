import 'package:flutter/material.dart';
import 'package:timer_flutter/timer_flutter.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  late TimerFController _timerController;

  @override
  void initState() {
    super.initState();
    _timerController = TimerFController(
      duration: const Duration(seconds: 60),
      timeFormate: "MM:SS",
      listeningDelay: const Duration(milliseconds: 100),
      statusListener: (status) {
        // if (status == TimerStatus.ended) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Timer Finished!')),
        //   );
        // }
      },
    );
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Flutter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // StreamBuilder listening to time updates
            StreamBuilder<String>(
              stream: _timerController.controller.stream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? '00:00',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _timerController.resume(),
                  child: const Text('Start'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _timerController.pause(),
                  child: const Text('Pause'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _timerController.reset(),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}