import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Tosser',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Coin Tosser'),
    );
  }
}

const TextStyle uniformStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
class CheckableTask extends StatefulWidget{
  const CheckableTask({super.key, required this.title, this.style=uniformStyle});
  final String title;
  final TextStyle style;

  @override
  CheckBoxState createState() => CheckBoxState();
}

class CheckBoxState extends State<CheckableTask>{
  Icon checkBox = const Icon(Icons.check_box_outline_blank_outlined);
  @override
  Widget build(BuildContext context) {
    Row content = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        '${widget.title}:',
        style: widget.style,
      ),
      FloatingActionButton(
        onPressed: _flipCheckBox,
        tooltip: 'Check',
        child: checkBox,
      ),
    ]);
    return content;
  }

  void _flipCheckBox() {
    // This call to setState tells the Flutter framework that something has
    // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
    // bool coinState = _random.nextBool();
    setState(() {
      bool isUnchecked = (checkBox == const Icon(Icons.check_box_outline_blank_outlined));
      IconData newIcon = isUnchecked
          ? Icons.check_box_outlined
          : Icons.check_box_outline_blank_outlined;
      checkBox = Icon(newIcon);
    });
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  IconData _outcome = Icons.question_mark;
  IconData _attempt = Icons.not_interested_outlined;
  final Random _random = Random(9527);
  late Column mainColumn;
  late Center mainBody;
  late List<Column> taskList;
  late Row countRow;
  late Row outcomeRow;

  @override
  void initState() {
    super.initState();
    // Initialize _counter here
    countRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'Count:',
        style: uniformStyle,
      ),
      Text(
        '$_counter',
        style: uniformStyle,
      )
    ]);
    outcomeRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'Outcome:',
        style: uniformStyle,
      ),
      Icon(_outcome)
    ]);
    taskList = <Column>[
      Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [countRow]),
      Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [outcomeRow]),
    ];
    mainColumn =
        Column(mainAxisAlignment: MainAxisAlignment.center, children: taskList);
  }

  void _incrementCounter() {
      _counter++;
      countRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Count:',
          style: uniformStyle,
        ),
        Text(
          '$_counter',
          style: uniformStyle,
        )
      ]);
      setState(() {
      });
  }

  void _tossCoin() {
    // This call to setState tells the Flutter framework that something has
    // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
    // bool coinState = _random.nextBool();
    bool outcome = _random.nextBool();
    _outcome = outcome
        ? Icons.turn_sharp_right_rounded
        : Icons.turn_sharp_left_rounded;
    outcomeRow = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'Outcome:',
        style: uniformStyle,
      ),
      Icon(_outcome)
    ]);
    _incrementCounter();
  }

  void _addTask(String input) {
    setState(() {
      Column newTask = Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CheckableTask(title: input)
          ]);
      taskList.add(newTask);
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations'),
          content: const Text('You have commit a task'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the pop-up window
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    taskList[0] =
      Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [countRow]);
    taskList[1] =
      Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [outcomeRow]);
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: taskList),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _tossCoin,
              tooltip: 'Toss',
              child: const Icon(Icons.currency_bitcoin),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _attempt = Icons.done;
                });
              },
              tooltip: 'Mark',
              child: Icon(_attempt),
            ),
            // This trailing comma makes auto-formatting nicer for build methods.
          ],
        ),
        bottomSheet: TextField(
          decoration: const InputDecoration(
            hintText: 'Enter your text...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: _addTask,
        ));
  }
}
