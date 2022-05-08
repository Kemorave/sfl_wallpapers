/* import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

void main() {
  runApp(const MyApp());
}

class MyItem {
  MyItem(this.name, this.url);
  final String name;

  final String url;
}

class HomeController extends GetxController {
  var items = List<MyItem>.empty(growable: true).obs;
  var last = 10.obs;
  void addItems(int n) {
    for (var i = 0; i < n; i++) {
      last++;
      items
          .add(MyItem("Image $last", "https://picsum.photos/id/$last/200/300"));
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        appBarTheme: const AppBarTheme(
            elevation: 0, color: Color.fromARGB(255, 159, 0, 207)
            // This removes the shadow from all App Bars.
            ),
      ),
      home: const Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final HomeController c = Get.put(HomeController());
    bool _pinned = true;
    bool _snap = false;
    bool _floating = true;
    return Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
        // appBar: AppBar(
        //   //Obx(() => Text("Clicks: ${c.last}")
        //   title: Obx(() => Text("Clicks: ${c.last}")),
        // ),

        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 160.0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                title: Obx(
                  () => Container(
                    padding: const EdgeInsets.only(top: 35),
                    constraints: const BoxConstraints.expand(),
                    alignment: Alignment.center,
                    color: Color.fromARGB(108, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_rounded,
                            color: Color.fromARGB(255, 129, 129, 129),
                          ),
                        ),
                        Text(
                          "${c.last} images",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                background: Image.network(
                  "https://picsum.photos/id/19/400/300",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            /* ,
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Center(
                  child: Text('Scroll to see the SliverAppBar in effect.'),
                ),
              ),
            ) */

            Obx(() {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 280,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var i = c.items[index];
                    return GFCard(
                      elevation: 5,
                      padding: EdgeInsets.zero,
                      boxFit: BoxFit.cover,
                      titlePosition: GFPosition.start,
                      showOverlayImage: true,
                      imageOverlay: NetworkImage(i.url),
                      content: GFListTile(
                        enabled: true,
                        onTap: () => {Get.to(Other(i.url))},
                        icon: const Icon(
                          Icons.zoom_in_map_sharp,
                          color: Colors.white,
                        ),
                        color: const Color.fromARGB(64, 0, 0, 0),
                        title: Text(
                          i.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                        padding: const EdgeInsets.all(5),
                      ),
                    );
                  },
                  childCount: c.items.length,
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 174, 0, 255),
            child: const Icon(Icons.add),
            onPressed: () => c.addItems(5000)));
  }
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  Other(this.url, {Key? key}) : super(key: key);
  final HomeController c = Get.find();
  final String url;
  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(
        body: SizedBox.expand(
      child: Image.network(
        url.replaceAll("200", "700").replaceAll("300", "1500"),
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : Text(
                    "${((loadingProgress.cumulativeBytesLoaded) / 100 * (loadingProgress.expectedTotalBytes ?? 0))}",
                    style: TextStyle(fontSize: 50),
                  ),
        fit: BoxFit.cover,
      ),
    ));
  }
}
/* 
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0.obs();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
 */  */