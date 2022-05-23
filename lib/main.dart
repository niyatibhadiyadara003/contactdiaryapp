import 'dart:async';
import 'musicplayer.dart';
//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AddContactpage.dart';
import 'EditPage.dart';
import 'card.dart';
import 'detailpage.dart';
import 'modals/modal.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
/*await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
  DeviceOrientation.portraitUp,
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
  DeviceOrientation.portraitDown,
]);*/
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isDark = false;
final ThemeData lighttheme = ThemeData(
  primaryColor: Colors.green,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
final ThemeData darktheme = ThemeData(
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
    iconTheme: IconThemeData(color: Colors.white),
  ),
);

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (val) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lighttheme,
      darkTheme: darktheme,
      themeMode: (isDark == true) ? ThemeMode.dark : ThemeMode.light,
      routes: {
        "/": (context) => HomePage(),
        "addcontactpage": (context) => const AddContactPage(),
        "detailpage": (context) => const DetailPage(),
        "editpage": (context) => const EditPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("addcontactpage");
        },
      ),
      appBar: AppBar(
        title: const Text("Contact"),
        leading: null,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (isDark == true) {
                  isDark = false;
                } else {
                  isDark = true;
                }
                print(isDark);
              });
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor:
                  Theme.of(context).appBarTheme.titleTextStyle!.color,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: (contact.isEmpty)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/open-cardboard-box.png",
                        height: 200),
                    const SizedBox(height: 20),
                    const Text(
                      "You have not contacts yet",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: contact.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("detailpage", arguments: contact[i]);
                      },
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundImage: (contact[i].image != null)
                            ? FileImage(contact[i].image!)
                            : null,
                      ),
                      title: Text(
                          "${contact[i].firstname} ${contact[i].lastname}"),
                      subtitle: Text("+91 ${contact[i].phone}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.call,
                            color: Colors.green, size: 33),
                        onPressed: () async {
                          String url = "tel:+91${contact[i].phone}";

                          await canLaunch(url);

                          await launch(url);
                        },
                      ),
                    );
                  },
                )),
    );
  }
}
