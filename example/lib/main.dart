import 'package:flutter/material.dart';
import 'package:flutter_page_stepper/flutter_page_stepper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'FlutterPageStepper Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const FlutterPageStepperExample(),
      );
}

class FlutterPageStepperExample extends StatefulWidget {
  const FlutterPageStepperExample({super.key});

  @override
  State<FlutterPageStepperExample> createState() =>
      _FlutterPageStepperExampleState();
}

class _FlutterPageStepperExampleState extends State<FlutterPageStepperExample> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FlutterPageStepper(
          headingVerticalPadding: 30,
          stepperLength: 3,
          currentIndex: currentPage,
          activeColor: Colors.brown,
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          children: [
            StepperPage(
              content: 1,
              onNext: () {
                moveToNext();
              },
            ),
            StepperPage(
              content: 2,
              onPrevious: () {
                moveToPrevious();
              },
              onNext: () {
                moveToNext();
              },
            ),
            StepperPage(
              content: 3,
              nextButtonTitle: "Submit",
              onPrevious: () {
                moveToPrevious();
              },
              onNext: () {},
            ),
          ],
        ),
      ),
    );
  }

  moveToNext() {
    if (currentPage < 3) {
      setState(() {
        currentPage++;
      });
    }
  }

  moveToPrevious() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }
}

class StepperPage extends StatelessWidget {
  final int content;
  final Function()? onPrevious;
  final Function() onNext;
  final String? nextButtonTitle;
  const StepperPage(
      {super.key,
      required this.content,
      this.onPrevious,
      required this.onNext,
      this.nextButtonTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          "Page: $content",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            onPrevious != null
                ? MaterialButton(
                    onPressed: onPrevious,
                    child: const Text(
                      "Previous",
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox(),
            MaterialButton(
              onPressed: onNext,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  nextButtonTitle ?? "Next",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
