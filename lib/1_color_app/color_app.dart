import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue, green, yellow }

final colorService = ColorService();

class ColorService extends ChangeNotifier {
  int currentIndex = 0;
  int redTapCount = 0;
  int blueTapCount = 0;
  int greenTapCount = 0;
  int yellowTapCount = 0;

  void setTab(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void incrementRed() {
    redTapCount++;
    notifyListeners();
  }

  void incrementBlue() {
    blueTapCount++;
    notifyListeners();
  }

  void incrementGreen() {
    greenTapCount++;
    notifyListeners();
  }

  void incrementYellow() {
    yellowTapCount++;
    notifyListeners();
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, _) {
        return Scaffold(
          body: colorService.currentIndex == 0
              ? const ColorTapsScreen()
              : const StatisticsScreen(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: colorService.currentIndex,
            onTap: colorService.setTab,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.tap_and_play),
                label: 'Taps',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Statistics',
              ),
            ],
          ),
        );
      },
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, _) {
          return Column(
            children: [
              ColorTap(type: CardType.red),
              ColorTap(type: CardType.blue),
              ColorTap(type: CardType.green),
              ColorTap(type: CardType.yellow),
            ],
          );
        },
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  Color get backgroundColor => type == CardType.red
      ? Colors.red
      : type == CardType.blue
      ? Colors.blue
      : type == CardType.green
      ? Colors.green
      : Colors.yellow;

  int get tapCount => type == CardType.red
      ? colorService.redTapCount
      : type == CardType.blue
      ? colorService.blueTapCount
      : type == CardType.green
      ? colorService.greenTapCount
      : colorService.yellowTapCount;

  void _tapFunc() {
    if (type == CardType.red) {
      colorService.incrementRed();
    }
    else if (type == CardType.blue) {
      colorService.incrementBlue();
    } else if (type == CardType.green) {
      colorService.incrementGreen();
    } else {
      colorService.incrementYellow();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _tapFunc,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Red Taps: ${colorService.redTapCount}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Blue Taps: ${colorService.blueTapCount}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
