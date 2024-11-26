import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Add this function to update the widget counter
  void updateWidgetCounter(int counterValue) {
    // Save the counter value to be accessed by the widget
    HomeWidget.saveWidgetData<int>('counter', counterValue);

    // Trigger widget update
    HomeWidget.updateWidget(
      name: 'ExampleAppWidgetProvider', // Ensure this matches your widget provider's class name
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    updateWidgetCounter(_counter); // Update the widget whenever the counter changes
  }

  @override
  void initState() {
    super.initState();
    // Optionally, load the counter value from the widget data when the app starts
    loadCounterFromWidget();
  }

  void loadCounterFromWidget() async {
    int? savedCounter = await HomeWidget.getWidgetData<int>('counter');
    if (savedCounter != null) {
      setState(() {
        _counter = savedCounter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // Floating action button
    );
  }
}
