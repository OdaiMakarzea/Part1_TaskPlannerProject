
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'inbox.dart';
import 'mydrawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inbox',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.white24
      ),
      home: InboxPage()//const MyHomePage(title: 'Inbox tasks'), //InboxPage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),
      ),
      drawer: MyDrawer(),
      body: SlidingUpPanel(
        defaultPanelState: PanelState.CLOSED,
        isDraggable: true,
        panelSnapping: true,
        parallaxEnabled: true,
        onPanelSlide: null,
        slideDirection: SlideDirection.UP,
        parallaxOffset: 1.0,
        footer: null,
        collapsed: null,
        minHeight: 0,
        controller: _pc,
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
        body: ListView(
          children: [
              Container(
                color: Colors.white12,
                child: Card(
                  elevation: 10.0,
                  child: Text("Go to Jim"),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pc.open();
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
