/*import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;

  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  PageController _pagecontroller=PageController();
  int currentindex=0;
  bool play = true;
  bool isstop = true;
  bool islooptap=true;
  bool isshuffletap=false;
 String? totalduration;
 String? currentposition;
    double currentpositioninsecond=0;
   double totaldurationinsecond=0;
  double volume =0.5;
  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    audioPlayer.open(
        Playlist(
          audios: [
            Audio('assets/audios/challa.mp3'),
            Audio('assets/audios/laksh.mp3'),
            Audio('assets/audios/dheeme.mp3'),
            Audio('assets/audios/song.mp3'),
            Audio('assets/audios/yaar.mp3'),
            Audio('assets/audios/yaar2.mp3'),
          ],
        ),

        autoStart: false, showNotification: true);

    audioPlayer.current.listen((event){
      setState((){
        totalduration = event!.audio.duration.toString().split(".")[0].toString();
        totaldurationinsecond = event.audio.duration.inSeconds.toDouble();
        audioPlayer.setVolume(volume);
      });
    });
    audioPlayer.currentPosition.listen((event) {
      setState(() {
      currentposition = event.toString().split(".")[0];
currentpositioninsecond = event.inSeconds.toDouble();

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Audio Player"),
          backgroundColor: Colors.black,
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IndexedStack(
              index: currentindex,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 180,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(5, 8),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(
                                "https://images.desimartini.com/media/main/martini_horizontal_600_300/2019-7/e6052ddf-ce71-4157-87e8-1efc1acba05f.jpg"),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Slider(value: currentpositioninsecond,
                          min: 0,
                          max: totaldurationinsecond,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey.withOpacity(0.5),
                          onChanged: (val){
                        setState(() {
                          currentpositioninsecond=val;
                          audioPlayer.seek(Duration(seconds: val.toInt()));
                        });
                      }),
                      SizedBox(height:10),
                      Text(" $currentposition / $totalduration",style: TextStyle(color: Colors.black,
                      fontSize: 15),),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20,),
                          RotatedBox(quarterTurns: 3,
                            child: Slider(
                              min: 0,
                              max: 1,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              onChanged: (val){
                                setState(() {
                                  volume=val;
                                });
                              },
                              value: volume,
                            ),
                          ),
                          const SizedBox(width: 40,),
                          FloatingActionButton(
                            child:(currentindex==0)?  Icon(CupertinoIcons.backward_end_alt_fill,color: Colors.grey.withOpacity(0.5),): Icon(CupertinoIcons.backward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: -10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              AnimateIcon();
                            },
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: iconController,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: 10));
                              audioPlayer.seekBy(Duration(seconds: 10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_end_alt_fill),
                            onPressed: () {
                              setState(() {
currentindex++;
                                print(currentindex);
audioPlayer.next();
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (isstop)?Container(): Container(
                        child: FloatingActionButton(
                          child: Icon(
                            CupertinoIcons.stop_fill,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            audioPlayer.stop();
                          },
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 180,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(5, 8),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm4bjM8fuZkL0y7nLgpowHwIs9mhU_yBin8Q&usqp=CAU"),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Slider(value: currentpositioninsecond,
                          min: 0,
                          max: totaldurationinsecond,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey.withOpacity(0.5),
                          onChanged: (val){
                            setState(() {
                              currentpositioninsecond=val;
                              audioPlayer.seek(Duration(seconds: val.toInt()));
                            });
                          }),
                      SizedBox(height:10),
                      Text(" $currentposition / $totalduration",style: TextStyle(color: Colors.black,
                          fontSize: 15),),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20,),
                          RotatedBox(quarterTurns: 3,
                            child: Slider(
                              min: 0,
                              max: 1,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              onChanged: (val){
                                setState(() {
                                  volume=val;
                                });
                              },
                              value: volume,
                            ),
                          ),
                          const SizedBox(width: 40,),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                                currentindex--;
                                audioPlayer.previous();
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: -10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              AnimateIcon();
                            },
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: iconController,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: 10));
                              audioPlayer.seekBy(Duration(seconds: 10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                                currentindex++;
                                print(currentindex);
                                audioPlayer.next();

                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (isstop)?Container(): Container(
                        child: FloatingActionButton(
                          child: Icon(
                            CupertinoIcons.stop_fill,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            audioPlayer.stop();
                          },
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 180,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(5, 8),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBUVFBcVFRUYFxcZGhodGxoaGhocHB0aISIZIBwcGiAaICwjIBwrIRocJDUlKC0vMjIyICI4PTgxPCwxMi8BCwsLDw4PHRERHS8pIygzMTExMTEzMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMf/AABEIALcBEwMBIgACEQEDEQH/xAAbAAACAgMBAAAAAAAAAAAAAAAFBgMEAAIHAf/EAEEQAAIBAgQDBgQDBgUDBAMAAAECEQADBBIhMQVBUQYTImFxgTKRobFCwdEUI1Ji4fAzcoKywhUkkgdzg9JDovH/xAAbAQACAwEBAQAAAAAAAAAAAAADBAECBQAGB//EADIRAAICAQMCBAQEBgMAAAAAAAABAhEDEiExBEEiUWFxBRMUMiMzkeEVQoGxwfAkU2L/2gAMAwEAAhEDEQA/AEpTU9omK0W3rUkREVomK2b61iDfrWiTt9atJamuKSZloaeVSgaV4+g0qNWP98qkpySWxqZia3t84iK9tpOnWtmWPWuINhWrLrrHlWuc7xy2qUJI8+tSca4Jou//ABn/AHJV/Dse8nzb8qo2li5/8Z/3JVxD+8Pqfyry/wATX/Ifsj0HQfkr+oM4HYlUI3yifpTN3GlRcK4GvcWnBIlFJg7yBRhkFZXWSaybno+jxaE/UEJZM6e9TZTHnRLDWN60uWYoai5Kxj5cN0gc+CNyGJ2qrxji7YdJyMSQQpjwA6QXPvsN4qTE9p7FpSom438o0+Z/KhJ7X3H8FuwjA6Q0n/y1AA9aaw9PJtNxtFpR026qwY/aXEPlkr4d/APF6/0ii+C7R3Mj5kG4IAGmXQEdSeY9aDvw5rsXFFmyrGJV2ySCAYzaaSPhMSYohhsJZGHNwlwQ8KwAZH1yrIGqsSSYnZT6U7kwQkqpE48mG/Eg/Z4vacOubLldUGbmW2gb14bBzae9IOIvgMRmEqTp4hBHM6TNOfZLifeylx89zxMDG6+HTYagn60pl6PRHVArOGP+Xgv5TEfKtHwRuCSdqJvY1qfC2vCaUUNzpRjT8nRTtIwWq+JwxeJJ0o9YseCoblnSpWKlZDyRlcWithbWUb6UNx2LuBxDMFDaDWIiD6/aiN23VbuARBEjzqkfAzpYVKNJljhtx2WXfMdPbTaIEUN7RYPOpjUmOsCNojWfpVtLeXQaVFxDDtcypmIBImOYroNrJqJjBwW3ImDAuQQ8lTBJmSvPSdBvrWuExAtgtaXMQrBiY5wJGaQCI3inxuCl7TKglgw9SsGRPypMwvBi902DNvVs45gCJiPOPnWrhyKa3KTjjyxlqrV/tUB8PLsAHyzOYg6xuR51ob8AqvhHtMdDNN1zg+GUoglddCZ1EHlzJI09aRsWhW4bY/iA15a7dJppRtmRl6aeJJNcsv8AfA7vcnn4U/SsqUeDwgAx1yz7617UUMfwzMYorbJ86iQ1PbO2leiPGM8CE8tKuWmiKhr1B5f0rij3JLqz61oFPSvUPlz3qJ8YgMTJ8v12rnJLkiMJS2SL1lo1rHE+Z5UOXGiZKN7Qfsas4a+rE5dfXcexrlOL4Z0sU48okyNrUyCB962qE6nb+tWKG6v+8H/tn/clWkbxE/3yocoi4PND90q4jeIj++VeZ+JL8d+yPQfD3+EgxwvEX7lq0qLkRba675jAG/KjuXTWouz9oLhrQO5toR8hVtxWJ16aycnpsWx7hV0NK/bPiXdrkXdtT5Dl9jTVhhoaReM2+9xbTMBggaJFsgRmInVi+gnQb6yBTfRw1JWXjNRk5PsA+H8Ka4ygo7FjAVYBManVoCwNdTtyNH+GWrdtLTZS2rse6ZSrMi/4SoQWe5JOrGIUt8OlRLd7nEspuqo7srbOZXCXAQD3kqcodiSZYMeZG1WMBg7du3fL3ZYZ0tPbGVZe2S5hAc1yMwnxaKYrWSpCWbNKb3ZWTjLvbvXVWbcqUtsyqoZgFBVNDlLlmLA7rAAgkRYvifeO9u5ayGPHbtNm7xxBzO6iA6kKCZ0JMztUtvF3jaTD2QbhtRHgDtyaQHWEAI8MwYgkTIoFx3iWILm3dBt8in/2jQ+2nQc660VhG5BO1xBDczYi3auMVAKgBsoEwc55xG0yRuNRTd2cwmHI721bCHVTEiOoOsHlXPsJfR0CsZI2P4gOk10HsXbiw3XM2vXaKR6nz3NTJijDBqW/qFbi1Lh18LV5cFS2B4TSncXnLwk9pfBUFxdDVxF8IqC4KvWwCMt2UrlrQ1CluiV9NDUVu3pQHDxB45diiLWtbta/eKKupa1r1bf730B/Ku0bHPLz7EmElVfLuCOU+ug30mhK8GFtmvGQzAzqDMxJJPOROlH8FpmJ25nppVPj+KS3bJZTcnQIDBYnl8pPtRcXheoz5TrJqEjiXEbSOBmzMNhEyW2iT8VRNwiwjZ7q5mZhrJjP6dBG9QWeAYm+4e1bW2NwWlV2BgSJJ8634pjAl028QndPlHiBzAnYlQJ5g71pY5toc6fqoTf43bgpX8GmYw/0NZUVziFsE5WBHKSZ96yibGj9ZDzB4XWpVMVohrYjWvQHzJm6vsOdSMABJPrUSculC+K4oyADoD8+tUyT0KwmHF8yVdi42I7xWy+EA6htD/ZqthcOx8TPlXkBuaK8K7LXbwDscgiVHl51Zx3ZG9ZBuiLijcagx5QazpZ9UuTah0uiOyA966BoLdxvPwj7maitvcZgVXIQee/pppWzXrWxtgelRW8UitALZTpB1j0P5VeMmRLGmg5hsZJKsIYcuvmKtrbn1il9j4tDqNQeZHMUfwlwFQwMggU7iyalT5Mfqun0O1wRsALi9cjfda1tP429W/41teP7xfNG+61BbPjb1f8A41h/EVeZ+yNToPykO+Gws2MM6kqVtoInQ6CiRGlC+FI12zbVmyhESFA1Og1JNFssaV57rJKWRtHo8T2J8Kmhrn3F0srduK75Cl0s6k6XMzEiVkGcsFSD+ldDwu1J/bnhwJF0BDOhDMqyyjwnxb6EjTUQK0OhkkkmDyt26Fe7eVLZt3LS3AzlycwBQNqoLkElydSBJjbcUwcHwNm53f7TddAAoQd3cWANvGwgb7gk/wA1D+w3De9Z7lxQTaKrbQjwjSZj5a00tw/EXLkOTlgndgAZMCB4YiNfXensmSm4oClcbsasJgsPZt/u8iW+o29SedKfaIYHGLkFwd4PhuBGIB6FssZaO3OGl8KbWc6Ea8yOk0GwPB79u42ViFEZQSSGH4gwOn3odrng6Fp2mcpvWHsXGt3BDBoPryPpz966l2DBOHZjszaDpAANCu1PZ4XcaoghO5DkroRlkRt5LThwbhyYe0tpJIUbndidyfWqdVONJdxmOdvG4drNrgqVB4K0cVTxHF0Ui2itcfmFiBG+Y8gOZ2FKRi5PYrkkklYcI8Iquy0uN20tklFtyVJBloEjTTT9Ks4btAGIz28o6gz8xAq8oSS3QCE0HMQuleImlem6rqGUggnQipculBfJZS2NLS61rbTxsfKrFoVpYGre1c+xDlyB+LNch1XRCDJ9RHi8onTrFL2G4jcS6neOCs67RrIY+ejH6Uyccci2wUSSRA69aVrltcuum0GJA8jGsV0I7WE+l1wc09x8xqk22yEZipC9JjSuW9v7AOLtSDBXnvGYzPlRa/2ixFlMlsq6qIDOJYHTaDqOlLGF4XextxrjvoGgu5O+5iPXbatDAu4qoyU1Fx3uytcdJPw/Sso5f7KMGPjtHzyRP1rKLpNn6yX/AFr9AEg2qZDUKKZ8oqdTG9ejPnLI8U+VDFAMM+e/bU6zcQeWrCZ86I8VZmQxsP1oY1sWwjHVt/r5betJ55W6NTo4JRs7pbWDtFenjuHVjbLG42xS2pcg9GyiB7mkngF66b1lrdqEvQWh2OVCRBbN1BnSmLi/Argcm2SEYmcvhYHlqAeetZkvDI3I+KJV7R9k7N9Tcso1q7vBDKG8iOvpXMMdYu2nKXLeo5EeL1B3ruXZfgz2rea7de43ViI9tKUf/Ufhy3irKPEsyRvFFjPTzwBnjUtlyjndliwlGhl/CRrH3oxwm/Iy7RM+YO1ARadLndvKuPhPnyohg8RFwFvCTofJhoaaxT0ysz+px64NBx/8S3r+FvyqOz8ber/8akZIuW53ytP0qK0fEfVvslIfEPzX7IjotsS9xzwmLVbdiDJ7pZjloN6Mo0ietBeA8JVLaPMhkQ/MCZo3Gled6t3kZ6THdWyxh2gVFxXCLcQFgJQ5gfv9qlwokxXnF8L3li7b2LIwBnYxp9Yo+DdJMpN1MW+Cuti9dtn8WR56kgg/UU8276m3I6Vxjg3G7ly5kutmKoMp56Hmee/0pnxxvXraW7dzKJ8eupHIact60PFCVS8imSCa28wq/azIHXJbBLQs3RHlnIHhJ6a7UxYfiKsgOhMDYg/UVzdeCWfga4mckaZbpYHnEEb+lGeHcCFhmYXCcyRl2AMjXc6wPrV3VbAnDfdL9Q3cUXcSWj/DQCeXiJkee1EVaqnCraqmYzmf7cvpr71mPxQtW2uH8IJrPzS1ZFRePAudtu0PcL3Vs/vG3I/COnqfpQ/hSM1l7id4zOoH7tQSpH4V8JnfnA1Ok0K4JhRjcXce54lTUjkWOw9P0rpWCwLyLZJCATKgL4Z0SViCN59K0caUFp7i+S5bvg5jgLUEyDmk5pmZ5z0olaxQGnIfT+lOXavgC3/GvgugaOOfk0b1zO9fuWrnd3VAIOh2keRq0mpujoxpWOXBuLZXgagwSBsfMedOqOGUFTIIkGuS4O7JBHXQjkfPyp+4BjNe7YwSJAPI8wPLmPekMsKdoM+A+gry0uh8zWw2NeW/hoDZQqPglufFsG19OlLPEsGMzhZjXKBtEkfKAN/PrTBiwSp1MEwAOp5nr0A2oPxbCsqtcDk3CPFtEAbeg/IVbDqbtcILDJOMr7IULmHcB5jKBqQNQDvr1o/wYg4O2LcQNxpvPinzoRi17y3KgjU5tgJ20A5QKC28ZdwrFrbRrBUiQW/WIM+daGKVhJ52pKbi68xquYkoSuYaHmCd9evnWUA/67eOpZddfhPPWso2sN9XDyZQStmGtQodutTp9a9EfP2D+KqBbJHUEx68/pQG62YTTLjLWdSs+GN+h/OldxGn9xSmZb2afSS8NHXexHFEOEsELmdB3ZHmsgfSDTOuOu3g7KgQKdDmJLdQVy6fM1w/sxxbuLmVmKo+hP8AC34X9ufl6V0fC8NuG4QTcdepdiI8oIk+tZuWNP3N3ptM4800MVrjbuCuUiND60C47di2xnxHY+dFeItasIIhABtSuM19blxgQgU5AeZj4j+VAd3uMKq2EDjOP726HjKdJ82AAJ+YJ96ne8Lihho0gn/MBHyOlULuG0JP8UfST+VWMF4AfLWTt5TT9qkZVO2H8PimZVzhQy6KV2aeuuh0qSyfG3+Z/wDjQlcRmUicp9frRDh7E6tv4vstK9Ur8T9iIxUdkdE4Tjc1q0q7LbUEnmYG1FIoBw20qLaA/FbQ+kgUeXavO9TbyNs2sTejcnwwqcmd+dRWBpXr4lF0J16DU/IVfHfCKze9nIeCYXNxBraL4Q11SOieID5afKjNvFHDXMrgkA+IdR1FXeymHW1fN74i9xnJ6oWMATyyk/OmrtNwBSBdRcy79YHL2rZktXiW6WwB5U5aXs3wUrPabBhJzLPnv8t6F3uLHEPktAhTu3lziqZ7PW2IMEehMUZtWRaUJbWbjaKB1qmqPYnTLuMq2YVQOQH2FJ3b7F5ba251YzHkP6/ame1jRZvNYuMBouVidM2RMwk9SSR71z3/ANSsUO/RByQfUn8qWx4Ws+/qVeS42C+znEXsvc7tgHfLAyZyYBJ0kRoN66Jwfit3EYe5JIuKNwMsydCOlIfYNLdzEOLgBBVcoPkSK6ScfZtF1Z1TwjKPQ01ma1V3Oxxem/8AeRav8PxQJC2+8aYm6ztPmN1j5VX7ScEPdS8BwNIJMHoCdae8LxTwBoJQmAxBHuQdY86W+0t3ODG1Dc6phoRbtNbHOeE4szrIYdOftTtwrHqxRwTKf3B/vrSpc7oLmDgOjAMp0OuxHlrv60SwF9FOfUdSNNf5htPnVs0dSugcNnTOrWb4ZJFTL8PtSnwXi6EZM2h6/hP/ANT9Kac3h9qzZqmRKNFNgxZAB4ZJnz5fnQri1hnBRTGYET1o+DCDWNfqQf1oNYV5GUCSNPrrr9/Spx5HDw+ZMZ1aoVMTYe3bjLlYj+zVG5Y8Ks2XN013O56U1cYw1wrOQNCnMAQWJgmRIGkxpSQ2OZrgLcp08zT2LU1uP4+phFKMvRb8e5pdxcEgudPI17Vr90dSw19KyjUhrV/7QKVamUQI0ry3Wz7iYr0x8xfJFiX/AHZ1jYexIB+lLWPYEL5IoFMOJDsCiAAkHxE6a8hHOlvHYZ7chxr1G3pS2azQ6Okt+SnlmnLDdt8RaBtgBguimYMcgdNYFJy6CPnV7H28twjqE/2rSkknyaUJyi7Q+JZfEMly4xcMqPrsJAP0mmeLdq3+8ZUSIliB8utLXDM5wVsgEQFDRvlVipE8tBQPHcUZrhRszrqBMzGuxO+lJ6LkaLyVFepBiVttcldUBM6bCQAY9SKHY1mNwwC42009gNqKYbBXGLCxbN3NoAupB6ED032prwnZtUGa7ZuAjLoQqBjuRN118Og1AzHMYApqEbEskkjnn4TuBpuIIEiR8qLcNukiT1b7CnLHdncGbfe3r3cZiid3bV3yEiZuLcOZTz3jbeaUXw4tOyK4uKGdcwBXVYBlT8O08/WhdTF6SkZJj1waXVGYjREEeQGlGe8LGBqPKgXZS6l1dQNBt6aT6U02UjTnWR9IpTcpM0PmtRpECM0RIUDcjf0BodxbFBbDi2PG57tI3LN4c3UxqfarfF3hUUc3X6mqvFMGhFsm4bTKyqhGXV28MQwIMyeVMwxxjskDc2+SDh2ECnKBIQKPkI/KnrgbzbyHXLp7H8t/aKWsNaNpkDNmDgiYA8Y15dRm/wDEdaJ4e66Fu7EswKqCYGY/CT5TH1pjC9Mq8wGZal7EfFMCmdu7dVC/Fm+EHorc2/l5Vv2ZwVo3HuBw7pChR+AEb67k9RpvQ/hHELqMbGJttmUSSsvP80DUyTMirXDLN65iP2lWi0oKZSDmddNNdRl311nSmI4sblaW5bLrjjpy2/vYD7X4YtduHnm056ZVpXxfCrd9MtwQ8eC5z/yk82HnuNeRjoXaCyDcMjcz9FpYx1t/FbtopkiSzEZdJDAAakGOYpWdrIycbuCEa5wq/hnW4niCaELvl56c+tOGFxgud3cNwC0y75QWD9JbQe9XMRgTlUnUxBI5nrQ+2rWCWCh1bVlO09fWh5Ja+VuM4ZaXXYYcHaFx+8D3GVdszeEnrCwDHyoN2mxoju13PSh2P7cM02ktG2RpBgD1Ecqk4JhTcPePqfOgZItPcZjLVwB/+jATnUHvOZUnQaQJG4GY6ETpBkaQZ3w7LpKsozLsQY1AnmOlN1xQtwrJWRMzAI1ECBPPaem/Jd43YuNk7tHuKs52VZAGyAHfbXTy1JpqE1KKsUnFxk6RTXFDNntkgfb9KfuynF2uBrb/ABBQwPUbH8q5l+z6yFPtTr2UdQw1gyN9DtBHnJM0t1GNOJeLGriGIIOh0EfOt8FiNDmPIfKvMfaiIEkmhmIumIGnWloSitxluGgh7Q40hNHyk6QI2316VX4RYspbDIA7EeJtDE7jXaqFzDqCS4mpOHi2ri4PCII029x+dMwnaOx43J63XsEP2a0dRbtmf5V/SsqovE7a6KRA20b9KyiWF0x8hQtsd6nVZ1NV0XWKsII8q9Sj55I2RIig/FrWbMdNDr6dft9qNK0+lDOKWiFJ+ENAkamYIgDmxB06QSapl+0P0revYW8PZZ2yCJOgkgAeZJ0A9a6Pw3s4bsXC6MQi6ASFYKAQGjcwD5TQnspgbVzMzsLaWwNFHicGNXufFOYAZVjXKBvqwYXiNu4TIe1ZtsECCFchg3jI/BBHy3k1n1extJ6d2Q4dcRdcYO2EUhTIkfCN4iZOuw11obewMOr4m3eyBnRe7yS7KCT3akyeUsYgHrpVrF40LiMOyXHGZHRiugIBYaREjXQ+Yo1geJ933qXB/wBsbjrduDM1zK6A5UYRlll+vpUxxxiTPNKR7huAWbid5hsQQCUVwWjKWUDu0OzPBYlgTroN6it4/iGFdbV8tFwB2ibmuUoqSBAUZJgdB5zaxfZoKoxuEtnRUezZglgR4hcuCSZj8P8Al1G1L2Ext/EMO/c3clxg2uqmMxO8EA5BAH+2iJJApSbD2DN21hWvIou3YKC2dYQMjpoZLZfEBvqeQr3jONt3e9tYq0MPcD3zbuGQGebQWcp8bEEAnaNdKvYZLn7JdWywS6pBDFo3S5Ouy7QDtWvGhiltXRjbaXkzXDbZF2bLaZDB2XMCI6g9BVZq00SuRL4DijZKXFIyOWXyV+aHpO49xyp1fiXdslzZG015HpSRgbQFvMylrTgLeXmG/DcXodiDRC2rWx+z3Wz2Xg27n1BnkRzHrWXJW9jQQ4cWYMiONiVIqLjuCN+21tSQ0B0/zjUfPahfZu4Wt3cO5lrTHLO+U6r+lMdnkecD5jQ1XuRwingMUcThgw0uCD6XUM/LMNuhohavF1S4vMBh1B3j1B+1ALT/ALPjWTa1iPGvlc/EPf8ASi2AfK9230bOP8tyT/vz/SrlS5xW9nxdsroAizHRtYPrp9aP8MMM6ejeQPMfY0tWjFzTVpAHpA1PkBTJgWCsqzvPqeZNNwduy2dJY1FdkDO0K+P1AP1YUtgfvH/0fXMPypp7SDVT1B+/9aWB/iXPS3/zpXMvGymJ+FFPgt3/ALW2p5B1/wDFmUfYVpeuh46CR8hrVbh1wC2/8ty6PbvGNVr2IyW7Q/E5P1NAkrYZGmK4cjkEAZhrPQab+X9KO8JswoAFAHxWW0z83bKv+Vd/mx//AFo72fx8oo8gKHkXFjGFvdBxOHpc0Zc3tXnG8UmHtZVUAxAHTzopbxACFjoAJNc/xvEO+d3J8JMAmTCjaB1J1j0omOCC4Mcss7fCI7F13ctcBdSD4JgAH+KNtxp51Hd4C4Jaw+WNchaQeuUjUe/TlWXMUpQqAehBkamBJkkjkdN5PWrScRHhGuh9JEQT+e2tMUnyh/LiU/5a/YYeEM5woa6CHUlSG3idPuNfKp2UJsJMSTQy3i2BaQQCviE7ryI89NPSK2ucSVgwIy9B1HKkJYFjnb4fBnOHy34gLiMWGc6actfrUIcOci9DM9J0ij/A+E27ha4V8BMKp8okn3mp+K8KtZi1sd24XQrtPmNjUKaugcOolF0+BV0XQcqyht7FvmMkTOtZRtLGP4jj8mVQK9blXgc+1SqsgEivVo8AzfBWc9xVJCgzJOyqASzewBPtUXaN0/7fKDk7hXWdyzs+dvUlQPRQOVX+E4WyznvzFsCSf9SjXoNZnl6TUHFbC4mzae0YW1cW3qIK2bhAzN/EEuq4ldDnoGVu6H+jitLkb8CxeGtgJiUOUIt6RmE3Mw7tTG+nUgb+0dq7lv4wAZj31s6TH+KwI9PFRm3xnDZ0w92wEtrcAzvoCiJce25jfxMpg/xdaWLuQXsVqTnGkbnMylT6eKTQR2wn3CXWwxt6N31wAghh4rgDLBOoGYkanQR50y8FxVsX7mFuoHu3IYMSpS2oVwXPIiV23225K/BpzYSFRlsZ2Mu4/eByzZgu4BgyfPoav8Zx1vEE3LrpmTK9uyptm2JGWHzTJAzHKP4t9ZrjgnxfiJwNy61sMwKBS7K4UnKWGRvhImBAnWT1pd4ViiAQ5C24lTLEs2mYTEbEETHxD2udsOMftGEUXFLXUYZWtMO6TYnwq2oghc0bmgxxRGJDAKA1tSBd1BlBp1BJldNwI51xzHDDYxXS7aFxFORG8ebIRFwQSDAUg71rxXBYqzbxOTEC9aNq07gsC4zWmXP5AFFI6gjzoJwrDRdZVLLaZGM6FrbW3Ga206E6NHkSeZohjOF2rdu7dsYyVOGtSgMd44LIQZnfu2AXcHyqkuCUyrwW03djKAysviQ+e8HkaK4bCjuzbjMP4Lg5+o0n+YR6VR7Kv4QvkKZL6FYYLPWsh3ZpCdhcWLOLABOoysrfEI2B6+tPFrGKQI5ik/tkilbV9F1VgrHmAdp8piiGBxU21M8qmXCaI5LvaewXsl0+O0RcX23qTDYsP3N4bOMjf6oKz6MMv+o1ut2V1/sUF4KNL+FmChzWz0BOZT7MK5OyGhofEi2+Y81gnnodh6zRThGIJuKzfESPZdgo+etLV3Eh7du5Gsgx0JBBHqDpVnhmIzXbbT4Q4jzM7+g1o+KVDCgp4n5pB3tHih3q2/4beY+7R+VLAc94/wDoH0n86jfH97jMRcPwlYTX8ClQPnqfeq929lN1v4QT8kBoWSVzYrjjUUgPYvfuJn/EZj/5Mx/Oq+NfPiEtjQIgHoTz9tai7wC3bUGSgWR8qg4ZZa7cuvnyCSubnEax9q5LlhPQmxWI7y4Amlq0IB9OfqTrRXstezKPU/el/iuNQDubQhBux3Y9T5Ub7K3FtWjduSqzK6asNIyjnVMkLiGwW50hp7T4xhZFlAczwGI2C9CfOlbihCIECkRoDsdI8QJ99NoI9amtYy5duPcJyoSDlO0D4QY50N43iA6gFiTrPmdBpoNN/nRMcaNnFhlCOnytt+pNcdWMq5K75yIYnc6D5fKvC7aMp1HPnynmTNCMDeuP+7B23jTT22olYyiHYknoYiddBGkb1eqIxzrn9wrgXYjvCSxIyz01mIn4Zg1bdgUDRB1BA5HfXyil13IAh1CkZwAQCIkQf0ongsS2zayByI1HrVpRWSLi+exXLiWWDSq+UHuC8YW0MlyQu6mNp3n3qfH8RFwi3bYM9zQRoF01J9BrUQ4NZe2GOZswkEaH5DmKWeIWWs3cgfLuQ06wZj3isxQ39UYM9UeRjt8EwyAKzEsNyefOsofheP5UVTBgbkmT9KypuZW4CoOVTW68KzWMdeYr2B5NkyZSIYZlOhB2I5ii+Lw124O6tWwkIO6UkAsXdQbt3p/hs8fzA0FwyMWUIMxJ0XqeQ9KYf+mY1Ga4jh7ySNjBJBRQJOsC4pA5QKBlNDo7pkD9pbJVhjMMRcFtyuUfF3pyALyE2lHiPQwKo4fgPe37q21zsdCpeFtKMplnU5HIXKTmlc0DkRVnjXaC8bdx7lpbNy3cOXYlxraSAwl1BN2SOulZgWv28MmEswruQbpDeMs0FV8X4V5xod/UI6UOP4TC28gS4cSxG5lbQnSLaW4LQeeadRypSxWDcmBbCxEqumum+rHNy1/Onq/gbVtSGh7iR+98bi84nPbQiIXTIIknQxGlDOP8Rso7KLNqwrQe6trnZTv4iTlVjp4R03rmcJN1mWUIZToSDzG+vpp8qJ27xUgEaLsrSdDIYCNp1M9YIrfG20uBrobMT8OkEED4Y6gAHnINatDKr9EIPLbkR89Kg4a+CXS99e7ByXEUkwCVfYsIiYBgmJMVccYTElUa0cIVunPezqAWH/41DfF9cvzoDw1c9u2A1xHtOZuAyEQ5Tr1JnQCdhU+JJu27otkG3kZ4ME5c6lg0bXCVaTJB5SINc+DkEuALppy2pvw94lYIpK7L3txTjZuEjSB61jT+5ml2B3GMJmtusaMpn160u8JvTa8xRTjViNe8csfPT0ilvhV6HdP5jUxVxJ7jdgL/AIR50P4jc7nE2r2ynwP6Hn7HX2qLC3cpAqXtCueyevKojszmX8acq3bY2PjT0aSQP9Yb5iqWHx5FvwvBAIJOuXy9elR8NvtdwqsCO8tSuokEaAg+2U+ooPirLvdSDFtd9DBaYMrPl9KLBbtHLJKG8e+wc4HdLO087ZM9fEomJOlecXuRbv6/EwX5i2PtNUuDYlUuuWDf4cAIjNADD+EE9K17QX8toaETcZ4OhgZokHYwy6VVx8ZW9hWfFnvCRPQdT0FNXCOAYh7ahJkhi40VVJjKGY6zuSBPKhnZDhSuVuvrPLoK6ffMWfAQix4UA+pg+9TkmlLSgsIPTqfc59juyT20Jz5nO5Ufu1HmT/SorJa6ysxhdAOgAid/WjF2+ltG7y0Iyj92HkXGX8TQfhkneJ0EUBxHgdVbUm2sqNsxiY6Rp8q5Sfce6FxU1SptMLXLlsk280Iv4tfFtE6GIOs0IuIW06Tr+lWWvQq6MJGwGjeuvnXq3ntsLhgkAwrCRrvodNqs5djXeVxi4x7+fn5gs3e7OdBGgHlrRTAYVrjZyToJLETr0gnffahmIcagBROp8y3ITtTTwG+bi6jMRJOm3X0FROVITcdNspXrOUHIPEZzFgDPkB86lwrDuyskuDOp6n9SKvY9YoUj5WnygiqYpvUg2Ld2uRi4TxUojKRv4l5weY/Og7YE37jZiVeJCnp01rMFiSjBt8pmOvUe4p7fD27hS6IkaqfIj+tB6/VinqXf+5mdbhrJfZnPv+iXB+H6VlP7Wl/iP1rykPqZifyInL1caVsdfSoc3/8AK3Q7a17pHjWi3gAwuKy/EDprHWY84JIoycVctktau3LbE6FrkhiNNReKjcbCfWgdpypkMRylTB10MEgx8qM4m86ADvMw3AD2mgnUyuRSZ/zUHJyaPR/Y/cXePcUvXGCXypyENKiBpqPKTJ2+dEuEXpuNdurozNlGjBGIZQBzgFQYHKPIEPj7QLFEsS3iOYK6TIUAkLmmIJ+LnUYCqwzWZkp4rbMNPxCGAl+VCGzofAnwwzM2dciEoLqx+9IgfhGsHT10jauV9obZFwyCJJOvOefnRyxxZkENeuqFBjMDqARlXLLKToOcfmC4m/jMHMBoCREgeXXUCqtHEPCbzBmhisAGQJiA3LnIkec1Nh1YOZ1JJaOesz6/bao+HaKxA3MTzO36D6161wq0+RG/X+oqVHw2DeTxaUG8AFDWlhpuDJoxVVZJVXYDVoDKSKKXcC1pcjq67mGEG44UrLDmSWgDkFMzyC4HGjLohe4CWWMqhWgAEZgZOg+VHOK8VN0Nfe4zmVV1V1jJAysBEHdlMfnVasIVez0q0TBUlT6gwftTxh9VFcuw+JurcYL8ZbN7MAQSfMEH3pywHHjkyXP3r8zbED0k6GsrNBqRoxdpFvjQA1J9hqfpSNauAX3yg5Z57zAkU54u6WScjWx1aNfQzNJ+KsxdeJiQZPmBUYu6JfYJ2L0uPX9KLY/W3S9gW8S+v6Uw328AFVnyWQG4LiO6vG2fguaf6tY+/wBalxLlSVUycxMTqRO2+0RqKq8WskCRuNR61BiWW4VvE65QIIJE7E6bc/nRY77lJeRe7N4jPimnc2mMejJ+lQds2LeEbx/uYfkKq9msVGMXoUdfsfyr3j14vcuka5Wgf6YB+xqzVTTOVNbhvs5bCoo6U54LEABizKoAkk7+g/SueYHiqJaztp6az6CtMVxN8TFtAbakTv4mHTTbeaVWKUpWxp5IqNB3HcSs372VQe7Q75Se8f8AmaPhHTb2FLXFXIvSd5PzO1HMCLtlIaMoGhgSOg86WeKanMfF4gTPPWjwS1A4TlGSfcI4a+WSCYInf5iPflVZr0jUjbT+/rVK1duTAUwdOuh6/rUoVhJOXTlEjXpH56VZxNaGS+P0IbzEmAfeinBMaRK6ielU7OFkSQfXXz9qs28OgBgkNIiBp850+VVlTVDePp5vxPhjVebMntQcnWpMNnFvVlYbfzD+lVbbEuBPPehxjUitaGTq5A1mRy5008J4uBZysdVOn+U6iZHmR7UoLfLN4zqRB+2nvU9q9l9pFMdVj+bjp9tyueOtbr1GJuIzuD9PyFZS9+2elZWV8pCmj0KJ5V6x2jevcwrHEx969nR86Z5bciI5EH6ztR69Yurinsh7iIptu7z8NsgnWTAk6TtpQS0kkbemwotxK1eW3nuICbotW3fxeG2qKw203PzB6ig5OR/o/tfuDruFz4so4UEG4IU/iTPG2skp9qt8PTMttbmZkZFjIjlpOYKchnM2dUHpry13x+Cdblu4jG4qsGDEbghLnjIETDbTttUWMwmS47pcIt/4inXwpcg98AoEZHCktOkCKDY6VeM8MdLZuLbJVnKA5e7YQsiVBBlpzQZJidRSlcKkRABBMmWnyG246106/jO8w91boZbV2FYlhduLdXLqoYknSIO5GUrXPeKcMe20L405Oi6GdwSAYIOkE1DOILE93MaSdetYEzGPlz15DcelWcNhn7syGUTIBBEjwgnUbAwfaqz6etXi7VC0lpnYw8N4e+QMyqCXAOcyBrHwAhYHOTtrTZwazbY3bKP3guSYRUMEAaKAIUQD1JrnbcYusChdipMlRovlI2I8jpR/hnEcRZQXFItqNAx3EiPCB9hVBg34hgUt3WDqTmIJYMV12jLl10AMAc40ovgEAEW2dR/7In5zUGAxBdiReS4JOisSAeejAGNdPfpRS9btlf3jP6IXX5gGKy8+02jRxO4IH4+/lPjz3R0yqo+pOX1ilTF3ibrSIkDTppTHib1lNLdts3Ukg/XelDE3c11z51GNFpOi/gm8S+tMrn4aVcC+o9f0poVpy1XIty0SvxK3KGld7mUBSJmT6dfyptx5/dudoBPypYFzwqy8ww+oq2IrMo8Nv93iEfpmP0NW0JiTudT6mht0w8+RHzBH50XdI0FHn5lIAq9hmLBF0UkRJAAJ+tPOF7JmV/7q1myxopPT+aeVL+FTK2YoHAUkg/w+ESv8wzU+cKxFhADaSMw1JBk+pOv1oGXK1SQfHjTtsA8Q7JYtQWF+26j/ADA9Nm0+tCj2fxD29cpJJiJ2EQZjcnSK6PiMYO7I3JB+xocnGTClbaqACAI0B0/WhfOaCwxLn/ItYDs85CBpAJiVnRiNCZ9ZrMNw1Fusl0wwYg8vQ+lHMXxa8ysghRBIiAQdCNR5ZhS3xu6XZbkySok+mk1MZ6rTZpdPPTKntff9wzfKW1KE5kOnmvQ0u45wGhQAABsZnqfL0qu+MaIOorwo7I1wQVUgHUSJ8ulTGMkNLLLG92bLe5TFSWmYPMSBrPlVANNX8HfyneAd6NFWwk5a0SiCzMIg/nvpUqPJnrv6jeoMgBkbzB/I+legSCPcfnRVLsxeUuzK968wY+vWsq3+zhtSRrXlA+VEpqiaKakAOm1eVlehPmZNgdbgGsa/Ymm3i+Ea1w9wxV8vcrm1GYKI1HXfXp61lZQMvJo9J9jIsPc7q2bceG8AoHRxovp0JHIedB8JjMtwWmMQW7tyJEAkPbIg+HMpgkaEAidKysoI2QJa7rNctqCilsykkvblZySSO8SADuDsAQJFWuAWFvqotsGcFmbKGWVhpnMRrmK6SRFZWVxyK3F8IbeZXU5onOSCIM76lssawBy2pOvLr/fp+VZWVMOQeXgig8t/KPz8qOWMCF7l3UNJE5oYQZ/CRHTSN6ysrnyTH7S52fw5t3MjCCAZ1mDMgaDpGuu/Lamq4ogjc+dZWVl9X+Z/RGl0/wBgL4nKrqdTSNZksT1k1lZXYeGWnyi7hVIPuPypntvqKysqmQvEjxbSrL1BpbNiFVd9Tz96ysqcRXIDGtjvFHIsB9aOk6n1NZWUXL2KQ7l3gb5sT3Z2a2w9DoZ+lE8JiXVmtlpCsy+S5SQYHTp6VlZSmT7n7Idx/avdljEYsqpaYC7t/Qa7wPelXGcc8MKz7g9NOY/vyr2sq+HHGXJWc2m6Pb3HZIYBveP5v1qj+0l8o+ErtzmsrKKoJPYI5PST31ykDcRofI6x9a0FvpoK9rK41ce8FZqBV3CXgFcQCTA1EwOoNZWVxaXBgHy09qnRoPp/Z+9e1lW7gpcmxtCsrKyrArZ//9k="),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Slider(value: currentpositioninsecond,
                          min: 0,
                          max: totaldurationinsecond,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey.withOpacity(0.5),
                          onChanged: (val){
                            setState(() {
                              currentpositioninsecond=val;
                              audioPlayer.seek(Duration(seconds: val.toInt()));
                            });
                          }),
                      SizedBox(height:10),
                      Text(" $currentposition / $totalduration",style: TextStyle(color: Colors.black,
                          fontSize: 15),),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20,),
                          RotatedBox(quarterTurns: 3,
                            child: Slider(
                              min: 0,
                              max: 1,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              onChanged: (val){
                                setState(() {
                                  volume=val;
                                });
                              },
                              value: volume,
                            ),
                          ),
                          const SizedBox(width: 40,),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                                currentindex--;
                                audioPlayer.previous();
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: -10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              AnimateIcon();
                            },
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: iconController,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: 10));
                              audioPlayer.seekBy(Duration(seconds: 10));
                              audioPlayer.seekBy(Duration(seconds: 10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                                currentindex++;
                                print(currentindex);
                                audioPlayer.next();
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (isstop)?Container(): Container(
                        child: FloatingActionButton(
                          child: Icon(
                            CupertinoIcons.stop_fill,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            audioPlayer.stop();
                          },
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 180,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(5, 8),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7d9DLcWcLJtTbrZTXmSw_WIDfpxXLWojx_w&usqp=CAU"),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Slider(value: currentpositioninsecond,
                          min: 0,
                          max: totaldurationinsecond,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey.withOpacity(0.5),
                          onChanged: (val){
                            setState(() {
                              currentpositioninsecond=val;
                              audioPlayer.seek(Duration(seconds: val.toInt()));
                            });
                          }),
                      SizedBox(height:10),
                      Text(" $currentposition / $totalduration",style: TextStyle(color: Colors.black,
                          fontSize: 15),),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20,),
                          RotatedBox(quarterTurns: 3,
                            child: Slider(
                              min: 0,
                              max: 1,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              onChanged: (val){
                                setState(() {
                                  volume=val;
                                });
                              },
                              value: volume,
                            ),
                          ),
                          const SizedBox(width: 40,),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                                currentindex--;
                                audioPlayer.previous();
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: -10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              AnimateIcon();
                            },
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: iconController,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: 10));
                              audioPlayer.seekBy(Duration(seconds: 10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                                currentindex++;
                                print(currentindex);

                                audioPlayer.next();
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (isstop)?Container(): Container(
                        child: FloatingActionButton(
                          child: Icon(
                            CupertinoIcons.stop_fill,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            audioPlayer.stop();
                          },
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 180,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(5, 8),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBUWFRgVFhUYGRgaGBgYGBgYGBgYGBgYGBgZGRgYGhgcIS4lHB4rHxgYJjgmKy8xNTU1GiQ7QDs0Py40NTEBDAwMEA8QHhISHjErJCs0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0ND80NDQ0NP/AABEIAKgBLAMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAFAAIDBAYBBwj/xABKEAACAAQDAwULCAcJAAMAAAABAgADBBEFEiEGMUETIlFhcRQjMnN1gZGUsbLSJDRCRFJUodEHFTNicpLBFlVkgpOzwvDxQ4Ph/8QAGQEAAwEBAQAAAAAAAAAAAAAAAQIDAAQF/8QAJREAAgICAgIBBQEBAAAAAAAAAAECEQMhEjETUUEEImFxgTIU/9oADAMBAAIRAxEAPwAIlK8+qmSkKhjMnNd2yoFUuzEtY20B4Q5sIP33DvXF+CJtn/n87srvcmxjZp0HYI51FfJ1ObRqDhR+/Yd64vwR0YUfv2HeuL8EYWY5vHZTm8Pwj6E8sjejCP8AHYd62vwxxsHP37DvXF+GMpLMNnXheMRvJKjVfqn/AB2HeuL8ML9Un79h3ri/BGOymGkHpg8I+hfLI2q4R/jsO9cX4Yu02EafPKA9lUp/4x51ypEXaKrI0vAlBVoyyt9m7mYDm+t0XrQ+GIZeANcKKuh1Nh8pFyToBbLAWRMv2wWpJPJLyrqoNjYswut1OVlXUtqRELopTewhK2cRX77WUmUb1FQAbjgbjSJ62YAhlya3D1WwGtWoNt1jzSY89mTHZyxNyd9uPXCmgkZkPaLxeOFS3InLK49B2fgcx9DX4cw6DWKd1yLHJfSKzbOMRlNfhxA3fLBcdhyRnWnt5orTHvv3xeMUuiLk32aobNtYDu/DtP8AGLu/lhDZo6g1+GkH/GLv6fBjIWtDrQaBZpzskfv+G+uL8Mc/skfv+HeuL8MZlhDI1GtmoOyB/vDDfW1+GJJWyzKb934aerutfhjKNHF01gNGTNxTbM2FzXYdoRa1Wpvru8Hoi7NwDeRW0FidCapR/wAYy+GTc2UBbsTzesjTf54uzGUlgWykX5u9d26/T1xCVX0dS/z2E0wA/fsO9cX4InGAH77h/rS/DGWV9YnV4zSJcndGgOAH77h/ra/DDf7PH77h/rY+CAJMImFoPJhz+z5++4f62vwQ4bPH75h/rY+CAEdVoLRuTDx2eP33D/W1+CGf2fP33DvWx8EBSY4BAtegc2g2dnWP13D/AFsfBHDs8w+u4d64vwQMVIgmiBGSbqgqTDBwE/fsO9cX4IjOAH79h3ri/BAJzFZzFVFejOTNO2zr5JjrU0U3k5bzWWVUiY+SWLsQoTX8N4g9sNM7w/jW9yXGX2R+u+Tqv2JGj/R6fk8zxx/25cNxS6F5tkOAD5fO7K73JsY2YvNHYI2mAfP538Nb7k2MpkuB2CJ3Q9WBnlm8JJZvBQyIQp4bmLxI5KxOZcPRIlywvIdRK4kxDOlQQyxG8u8bkZxAk2WYfTSzmgk9PeHSpFjBctCcArg1MjMA5IWzagX51uaD1Xivj9SHIUEgKLWF7ADdviaSbIdCQBfTgeBgDOcliYljjcrZWb4x0PlPl7O3UeeIZszMb316enthzzLDpi/hGFtON7aR1uSSOaMXN0BypjgkMeEei02ywtui9TbNoDqoifkLrBXZ5rKwtzwMEFwNiN0eithSDcIhenA4QkpspHFE88nYKwGkDZ1Cy8I9FnyeqBdfTLbdGjkZpYY/Bg3W0RQZrqQCBTS7R0RlZyyjxZLKmaDnWseG/XiIsJU88F75WbXgcp09Noo2jofUdVoVxsCkw+0oWcAksja7hmRvBcDf0QxBFKVOzNmPUNeiCKLEaodq9oQEK0PtCtGHGEQlEOMNMZqwNHTDM0OvDGgKItEqzIjd7xHCgqKRhjiK7rFlxEZEOKwzsmPnnk2s9iRov0ej5PM8cf8AblwA2XHzzybWeyXGj2CXvEzxzf7cuGAV8AHy+d/DW+5MjMoNB2CNPgPz6d/DW+5MjMo2g7BEGdCWzuWO2jojsKNQ20K0IvDkMEBwCHZYeoiRJd4FhogCR3LGgptmah1zCWbWvqQpPYpNzA6opGQlWUgjeCLEeaFU0HiylMmlEYA+FoR2dMAJsyNFNk3BBgBUyspIi2JollTohRSxAG8kAecx6xgmHqiKoG4C/wDWPNcGUGan8a+2PWaZo2Vj/TrtlxNIdnEclpeOTZHRCF2RThA+o0gmyADUwKr5otvjGWgbPmQFxCbpBCfUIAbtGfr6tDcQYxYspxRSqXvAyYgMTzJmsQkxeOjlyvltFW0QGJHNjEZihEnpzB2mByiAMprWjQUxuinpERmXh0PAhEQ6ONCBGGGMYcTFea8FAbJGcREzxXaZFmVSki8ZtLsEU5aQzNDg8R1Epk7IgSZBTT6FlcXTLbwy0cV4csEwc2ZGlZ5OrPZLjQ7DDvD+NPuS4B7MppWeTqv2JB/Yde8P40+5LgoBR2fPy+d2VvuTYzUo80dg9kaTZ75/O7K33JsZqUdB2CIyOiHZfw+nLuE3A7z0ARoP1bKC5cl+sk37bwEwmqCOCdxGUnoB4+kCNMXBFwRbfe4tHJlck9HTBRa2Y/FaXk3y3uCLg8bdBiCS0XsbqQ7jL4Ki1+kk3NuqKkhIvBvjsjKK5aLUlLxoNl6VWqUDWsCWseJVSQOvUfhFClUACLCTijBlNiCCCN4I4xGUt0U46PTT/wB/OM3tdSK3Jtbnc5SekDKRfsuYryNtFtz053Sr2B67EaRTOKGe+ZuwAbgOgROVxVmKAwq/CMvtFQFGB6Y9KQC0AdpKETUIHhDUdsJgzyU1y6JzjcWYCibK6noYe2N5MxzISVF14dfXGDqZTJvBB32Mb6a6SpaHLclRvF+F7249kerJrslhTdrorTNrHvoht2EQTw3GzM0OnVGXx+cwFihDEKwJLEkEkG+TmpbTid++G7M53ceFa+jalbg7rwslqysXurNXj9cZY80YSvxZ3PhGNltnL72SeAAEef0solrXtfS5F7ddo0DZF8D5SMx5zHzkD2mHvLTcW1/D07oPPQSxJZDcOdc4Fzobi9/ZGam0RU6a36LxS0TUWvgiqKaxuIiEE5dM1rEemKM6UVJEZM0oVsoThEIEWJ4h1OnGKXo51G5UcSma17Qco/AXsigrFT2wXCgBSOKq3piMmdXjUY2hsNaHw0iFJkMwxQnmCLpFd5UFCSRRQaiD8rwRaBfIxYluy6CFnHkUwy4vZJiHgWgMVgjNu2+IjKgwjxQuV8pWV5cWZcIS4eixQmjR7MDSr8n1XsSNDsSneH8afcSM7swfnfk+q9iRpdiG7w/jW9xIX5CB8BHy+d/DW+5MjLy9wHUI1mBA93TtOFb7kyAUmlIUEjgIjKVI6IrZBe28RzP0RJNS8KmkG97QtqrHp2NWW2/KYnlIeAi/IlltLRJNkFeESc9jqJXWotpENTVkjQQpqE8IaJLDhBVAdlamdmaxBvGpw+lZQDaBOGUxz5iI1KHSOb6jI7pGSK8yrK746jFuER1NiYnlzOESauJuwZjWDrMlu1ueq3B6hvHovBGipw8mWT9hPdETTZoGh3HQ9h3xPg8u0tVP0QV/lNh+AEdf00248X8BjFJ2V52HF1yMEZdPCUNu42MWaaiVLf8AnoG4QRMu8RutiI6rdDcVZmts25lowkl7MI2225U2y3jIVEtCgZLXG8AgkHr6IePQskamgsygHWLEyiH2YF7P1IZQejQwdmTARCysaNAWslqoOmsZWua7Ro8VmaRmak6w0SeXoHzxHVvaFMiVULWUecxZvRyxVyJ3bMl+IgxMW1l+yqr5wAD+N4GUErM6qdwYFv4VNz7Pxgk7XJPSSfSbxGT2dM9RobChRwxiBxoYREl45ljGGWjlokyxwpGNRGVjloeRHCIIKGWhR20dtBFaDWzX1vydVeyXGi2H/YP41vcSM9syPnfk+q9iRo9h/wBg/jW9xI1ikeBr8tm9lX7syM+raW6o0GCH5bN7Kv3JkAHppgQPkbLpzrHL/Nujkl0v6dsXt/pEaAnS0EZFIRYwMpmKnWDEqouIlJsaJMtl3CGNzt4hjTfPHZbkndaJjWJKQsbARP3GV0Ii3StliyLM0bkzUCyhG4GH90sNLQaC9UVKylvqAIVtPsDByS3JzRMZluGsPR7CxiN+mAmZpIqPUsTBnCp2hHHf6YFMnQI6J5QBrbm1/hOhHsPmi+JqwXRqkeBe0FK8yUQjlDobg2OmuhiWmqAyhgdDGaxzFXmMZSA5d27U8Lx1RVmc0lZWxxg8oFZgc5RmbQEkbzYaa9UYuXMyE5RYkWPZGrOATTa7oFykNdwMh3gkcYC1uGHMShDrc2YaXHTYxeNIjJze6HYPOKHfod8aV6rm74xjS2WLdNXMAVPmgSje0aOX4Zcr51zAapmRJVTyYqMbw0Y0ic52RgXi3IlaXzAdNyBDaZPCboBipO3iC9gi+KsN4dNBLImotq3Sb7h1RdKRTwenypm4n2CCipEJNWX3JWyoUhjwUSReOvhxMT8iQfE2BgYlRYNU+y1Q4zLLcjpta/ZffFd6JkJVlII0IOhHaI3li+mBYykJcNdItstohcQykZxoquIZEjxGYoSaOQoUcgoRhzZn635PqvYkafYe3c7eMPupGZ2Z+t+T6r2JGi2HPeH8a3uJGYpe2Qw+9bOmE+By1hwu5Ya+YN6Y0zC4sdRuINrW6LbrRmdm5jJWTDc5e/5h0hcze0QUfHZIW4zE20UixPVfdHBk6X7Z2x7f8MbtPQLKnkILKVVgOi+8DquDFCmls3Gw7IuYrUNNcu+86ADgBuA6hF6hwlyoO7qO+By+0ZIqyKA77xaSlMFJVJk8KI6iwEQcm2GgY7kGwAMFcPoWbUm0DkQl92kaSg3Wgt6MWEowBFSspjbQwVDi2+B9XO0MKZIzVSGBgphmHgoGfW+oXcLcLwGr6oBrQewqtV0AuLqLEdm427Idp0atirsOUKWXQgXtvBA6OiMzUva43gxp8UxBUQg+EwIA466X7Iyk0FoMNOxZVY/D6grzb6bhDUBRyVF2N7DS59MRMmWzbxxiRKhS4YtutHoQlyVomnTpjWw+pcMS6KCDdSMx85BGsCarDHTw5/XZAI0WNTZiICiBr+kab4yNRVTnNiB5hFYuy7yRSpo4acfbLdoA9kUpkvKSIMClZU1gNWzIMbbOXI0tlSZDLR0teOMYejnslV7KR9rfEcyUbqTuIuI4i3MGZ1MHppLjervLbqBIZb+mFk+LKwjyRLhg72pPG8EVES0mFnKqh5QtoAZi3/C8S1tC8l8jixtca3BB4g8Y5ZSVs6UTUq6xpsFo1aYoNrXv6NbRlZEy0FqTFMhDXsRHLkTZddHp+WMptxSKUV7DMGy34kEHQ+iJqfa6UV5wN+qxHtjP4/jhnmw0Qbh/U9cTinZCMJKWzJzxrFWZFqedTFWZHdE0is8QkxK0RGKo55CEdht4cIYnIO7MfW/J9V7EjQbE/sG8afcSM9s1uq/J9V7Eg/sO3eH8a3uJGoUfgM492TRfhVfgrwLVyRe8EsElfLJp/dqvxWZAtadQosOA4xxTql/Ttj2/4OoZatNXMdLjsjYiWBGQlIBBqXiLBdbH0xF7Kx0WsWn2RTfW/wDTX+kAptcCQt9TA7G6l2Ym/o4DqgXSTbOCYdYrViyls9CoKUEXO+LM8FdxtA7C626iLNTPzaRBx2EjzuT4RgfilS6i14LyZQtArF5YCkxovZjOM99SdYZ3QRxis0zfEEx464xsWUtF9aniTF5HuIz4MTyqhl3GGljtaJuQYmvYb4GM+vVDXqC2+OIl4fEnHsSSs0FBXsQAdR5rjoiWbUJlIAG8ncN5gAZM5E5Tk35MkhXA0J4/+7opPiB6/wCsdFehVL2WsVrDrr+PTGYnG5i/VTi50BioZcPGkTlcmQKIciXiYSyTE6SbQWzRg2yDJaHiqYIUB5pYNbrAtD3SK7JC9lGnHoKYWMzhjbKvOb/LqB5zaNdJqmqpbK2s1SXQcSOKiM/TYfkQAjnNq3V0DzRJTOyOChKsDcERpYOS/IizVIkL2itPnnpgriQWYpmgZXFuUQDmtrbOvRwuIBtHOoU6Z0c7Wh8ieemLoqNIGjSHh4zgjLI+id3iN2hheGM0FIDkMcxE0PZoYTFESbOCJViIRKsERhzZzdV+T6v2JBvYf9g/jT7kuAezZ0q/J9V7Eg7sN+wfxp9yXGFLeEWFXM/hqfdeAKT1sNRBbC596yYoBtar1sfsTIzdOm6w10jhkvt3+Tuj/p/wNUklWOog01OgXRQIEyHyi7C3aLRI+IpuDA9hiDstQPxaUADAqhpQzgR6zslhaNJLTZSMWa4zKGIXKthqNOJt1x3F5sqmQTGoZVmnLJULkDHO+RHPMsAdDa9wDHbjwylFO+zklmSlVGawykRRuETVEtVOkaXHKtaWRNntSIyylRuYV5wZsrWuosV0JvwMXKhAqsxpZZCyy4sQQSupS5TQ23cIR/SP2b/oXoxIngcRATG624ygxu8PxKnmNTB6NEFVLzyGsjAkJnKOLAq2XXiNN8X9oEpaaS85qVHy7kSWhdyeC6dFyegAmMvo2ndm/wClejxOwhjKI96pcLo5iLMSRJZXUOpEtLFWFwd3QYH7QSKeml8r3FKdFIz5UQMiE2L5cpuo3m2vUY6Fga+RHnT+Dw+0cMe7NRUpmS5aUsh868ozBEskv6LXy6hjoBx14A2r46aGmMkPSyjykxUJEpLS1YheUbTRAzIv+cQ3jfsHlXo8Xli8b3ZTZlCgqJ63U6oh3MODsOjoEehjAqX7vJ/00/KKuDYvJqHnS1TKZLhbMoGZCOZMQfYJVgD+7DRx09iSyX0Z3FJRcEnwQLKo3AdkZCdhw1Ujsj0itxTLOmyFpFcy5SziQyDOpYjKoK+FzTobDri9ha01RKSekpCkxQy3RQbHgRbQjdBlG+gxyUto8UqaAKd0UJ1EI9ureQSpk0/css8qrsHyoAuQXYEZdTbdDMSWnlT6eSaSU3dDsitlQBSiNMOYZehTa0Dg/Y/mXo8OSmh7SY9qo0p5zzFkUchklOZbTHVUUzALsiWRi2UkAtoLnS9jEfdVCi1BnU8qU1MA05TLRuYwujoQOerWsNAbixAMHiwrPFfB4m8qC+zeCZ3M1xdJZ0B+k/Adg3nzR613KvI8t+rpVsufk+98tlte2XJkz/u5rdcRVmMU0qnkT5VOsyRNPN5NACoytMZuTy62VHJG+4tBiqeyc8nJUjB4jT2UnjFPCaDOxY8N0es1LU5SU6SZUxJrIisAtrONG8E3GkXf1dKUHJJl3tcDKqgntA09EV5HPxZ5FMmZKlJaGxALuR0WNl/71QROGyKkHNLyP9tLC/WV3ERttmaikrJfdC08tHzFXUohdWFrXYDUFSrDqYQ/CMQkT59RJlyVAkFFL2Wzls18oA3BkYXPEROSjL9lIylHVnlGJ7MT5V2AExB9JLkgfvJvHmvAJo94bE5C1i0nJAMyM4cKoQstiZV/t5Tmt0W6YhxmXTy50hTRyphnuUzFUGVgpa7XU3FgYTg/Y/M8KLQxn649snTaOXVCmmUcpAwGWdyaGWWa+SWxyjKxyta+mgF7kQSTDaUz2k9ySObLSZm5NNc7OoGXLwyHjxEbgbmfPxaOR6V+lrD5Mpacy5SJmaZmyKq3sq2vYax5rGqg3YokUxFeHKYAGw9s2fnfk6q9kuD2w57w/jT7kuM/s2fnnk6r9iRothl7w/jW9xI3QgYwoDulxbhUe68V6DDwoDZdeyL+BzVNQ+mvf+HQGhyVYt1WjzZv7V+2elBbf6RWq5QZSCICpSqGsBxgjiGIi1lBJMDZTupzMDEtluSqj0/AGBl3G6+7o0GkDNvpLvIlhEZyKmnchFLEKk1WZiBwAEZn9dui2R2UHUgHjaAeNbV1SjmVDg34EflHdh+oSio0zzcmNuTdnov6QJbvh1QktGmO6BURVJYksvDqFz5osTyoSaVWazNTm9xMYXUMFRQ2uYlzoOiPHBtbiB3VM0+cflEg2urhvqZvZcflF/MvRNQZvcKw+bIl0FTybvkp0kTpTKzPIzKoaZKQ6qwIAYDeo42EaaejTagACySkJu6MVd5t15uouVQMP/tjyJNtavjPmDzj8ohm7Z1hNlqZnpH5QfLfwxvG/Z6rsYkySs2kdXyyJjCQ5VgryX56hSdOYSy2voAsaOcoKkMLgggi17gjUW4x4ZJ2nrTvqpv8w/KLH9p6wfWZn8w/KM8yXwHwv2ei/o+ozLpbMkxH5SZpMDBggdhKUZtyhMoAGgiWqw41YqQ/NR0NOoZGzBFBJddRa7sSCBqEQx58mNYiSOfUa8nbQ68r+z4fSsbdkG9ncXqFmM1TMqAFWWFQy3bM05ikskBdLlSB0mGjJy+GJKFbs0WHYjUNQqHlutTpIYlG8LNyfL2t4OXn/hENbRvTVVLOloWQr3LNWWjc2Va8uYwBN8rgC/Q5ixM2iRSQeWBGQkGVMuBMcpL+j9JwVHWI5MxctYIZrEh+aqNmGR8j5gQLWY2ighVxHDXn1tQnfZavSJLE1cyrmzsxUNax0IuOgmDGy81+QWXMk8k8rvTKq5ZZyaK8rhkYWIAJtu4RiK7FawzcyTJ6qk5JBlcm+dmZOUzaC3RpxBve0GlxKovlK1GaxOXISbBgCdOFyB/+QrlXwVWO/lBHGZTNX0hyOURZ+Z1DhVLJZAWXdfWGY3TEVlAyrMYLMml2vMdUVpLqpJNwLsQIGT8Xn5XKcuTLvnAltzGAzZW032sbC+hB3ERE9ZVy7NMmzGRlllXSWwUtMAISwLG9yFB4kgb9IHL8G8W6tBrZmmek5aRMRsnLTJsqaoZg6TDmym1yrqSRY7xa19bCsW2enVndk0LyRmJLl06vdWbkmD55gGqqzAAKdQLkjW0R1mIVYZUBnIxExgXRrEIucgZQelRfcL9Vo7h+Kz1UTprVOQhcgKMVdnIVNwubkgAW1LCCnfwBwpXaNOcVbkM3ITeWy25DLrylvBz+Blv9LNltxgRhmEvTSqCS12dJ7vNKBmRTMlVJaxtogeYFF+qB2MY3OTNdpksgA2dSrWNwCv2tx3X10iKkxGtDhGFQXyhypQ3yEkZugai1jr1Q9fkjf4C1VhM2RUShIXNTTKhXdNfk7gMxdOhHOhG4E30ub6mrfKjMASQrEAAkkgGwAG8xj5WLT2UuoqGU6ZhLbSzFW0te4a4ta+nbGVx7aKt7oMtJk6XlyqUPNYkjNc6dBX8YKjYbNRLwyokvIenBAqJEunqNLck6JdKix+kqh1tbUlQYt4RI5Ctq7S5gkinpllnIxVuSDhlQ/SPPGnE3gJRV1XdVae5Nrtc/hu/7eD0usm6DO3pjcQWUsXw+eaRahBepSaKtECNnzk6ySb/Y73u3LF7GprTJuHusuZl5UzHujAy1MtlGcW5pu1teiJ0q5l/CaOLVzCSMzdEajWSzaFJ06plzEJR5cldQQCV5S+VrbxmXd0iK+ztNUy6ick+7KkqSkqcd81A80jP++oIB6dDx1sGsZRqzRQqK2cP/AJG826BxYeSAP6ZfApf45nupHlRj2OunpULyc9c6a2J3qTpdTvB64wG0ezDyLzEJeT9r6SdAcDh+9uiEpVKmWjG42jMGHCGuIQMMKw/szurPJ1V7EjR7DnvD+Nb3EjM7NnSs8nVfslwf2GfvD+NPuS4KVgJ0xYyJ7uFDWeYLNexBLA7uoxOdrEtpSyr9am3thQo4Eeg4odLxpW1NLT/yt8UWJuMKF+byP5W/OFCicpMCigFiO1SJ9Tpj2o3xQJO1COdcPoyOtJh/5woUdWPohJbCEjHZdvmNIOxH+KOTsbl/caQ9st/ihQoW9lYwVFJtoJf930X+m/xQ1doJf93UX+m/xQoUdCHWKJblbQyz9RpP9N/ii9Q4jyzhJeH0zseAlv6TztBChQq7JZIpLRt6DC6lEQN3MGVVXwHdryz3hi2bUyxcfvX1IicYbNWwVpTBQgDzUZnbk2LyC7KQLoxJFhzr62hQovE45DFopqkKDKmWyXeajGY4luZkrOVIHMdmYWGug03wMq6FqcPeSk7lZU6WzIOTabMmujZp5Dg684ZkuRr1AKFDPo0e0OlvUl895QImrMHNYhQsoyhL1a5BVjzr3ud3CGT6SYZZlIspE5F5ICmYcqO4a92NyRa2/W/DdChRzc2d3iiTs88u0wiTmLmYhKueSdpQlEizDOCo3MBYk9UJWnDVRKR8slS4DuWWQcyKVZgoGa9yNbEjfYhQo3Nm8UfREVmBlyyVsq1GUIxAD1GXMZhck5b5zzbncLRZaTPGo5EOeRZpuVyXNOwKXQvlFwLEAi1yb7rKFFse3s5s0VFKijWUjugKS6c8mGaUCjuZTNMEx5iOzXzlwObpbThcGjJrWM6YeQk98ZWmLebZpkqYXSZfNdbE3yjSFCirSObkyTGqiekl3ZkYtKqpAyh1LGrdXZgtzYoRYC50B1i5g45VnqJ1PJzNlykhmZQktUHOJGnNJ3cTChQUgtsIpVDMe8Sh12a+nn7IvpUC+kpPQfzhQoACYzwPoJ6D+cc7pVRcog8x/OOwowxCs/MdZadejfn0+yOTKkXtyaEcdD+cKFGFKk2enCTKP+Vt+/XWBr41kbKZErLchtG3HqLQoUCcVQYSdgTaCXLlIJsmhpHl254KPnQ9JAYXXr4Rmf1/L/u6i/kf447CjmjJ7LyXQm2iGSYiUdLLMyU8lnlo6uEcWYAlz0D0Qa2HHeH8afclwoUURM//2Q=="),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Slider(value: currentpositioninsecond,
                          min: 0,
                          max: totaldurationinsecond,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey.withOpacity(0.5),
                          onChanged: (val){
                            setState(() {
                              currentpositioninsecond=val;
                              audioPlayer.seek(Duration(seconds: val.toInt()));
                            });
                          }),
                      SizedBox(height:10),
                      Text(" $currentposition / $totalduration",style: TextStyle(color: Colors.black,
                          fontSize: 15),),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20,),
                          RotatedBox(quarterTurns: 3,
                            child: Slider(
                              min: 0,
                              max: 1,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              onChanged: (val){
                                setState(() {
                                  volume=val;
                                });
                              },
                              value: volume,
                            ),
                          ),
                          const SizedBox(width: 40,),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                                currentindex--;
                                audioPlayer.previous();
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: -10));
                              audioPlayer.seekBy(Duration(seconds: -10));

                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              AnimateIcon();
                            },
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: iconController,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: 10));
                              audioPlayer.seekBy(Duration(seconds: 10));
                              audioPlayer.seekBy(Duration(seconds: 10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                                currentindex++;
                                audioPlayer.next();
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (isstop)?Container(): Container(
                        child: FloatingActionButton(
                          child: Icon(
                            CupertinoIcons.stop_fill,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            audioPlayer.stop();
                          },
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 180,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(5, 8),
                              spreadRadius: 5,
                              blurRadius: 5,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "data:image/jpeg;base64,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"),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Slider(value: currentpositioninsecond,
                          min: 0,
                          max: totaldurationinsecond,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey.withOpacity(0.5),
                          onChanged: (val){
                            setState(() {
                              currentpositioninsecond=val;
                              audioPlayer.seek(Duration(seconds: val.toInt()));
                            });
                          }),
                      SizedBox(height:10),
                      Text(" $currentposition / $totalduration",style: TextStyle(color: Colors.black,
                          fontSize: 15),),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20,),
                          RotatedBox(quarterTurns: 3,
                            child: Slider(
                              min: 0,
                              max: 1,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              onChanged: (val){
                                setState(() {
                                  volume=val;
                                });
                              },
                              value: volume,
                            ),
                          ),
                          const SizedBox(width: 40,),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                                currentindex--;
                                print(currentindex);

                                audioPlayer.previous();
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.backward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: -10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              AnimateIcon();
                            },
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: iconController,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: Icon(CupertinoIcons.forward_fill),
                            onPressed: () {
                              audioPlayer.seekBy(Duration(seconds: 10));
                              audioPlayer.seekBy(Duration(seconds: 10));
                            },
                            backgroundColor: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            child: (currentindex==5)?Icon(CupertinoIcons.forward_end_alt_fill,color: Colors.grey.withOpacity(0.5),)
    :Icon(CupertinoIcons.forward_end_alt_fill),
                            onPressed: () {
                              setState(() {
                              });
                            },
                            backgroundColor: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (isstop)?Container(): Container(
                        child: FloatingActionButton(
                          child: Icon(
                            CupertinoIcons.stop_fill,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            audioPlayer.stop();
                          },
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                   backgroundColor: Colors.black,
                    onPressed: (){
                  setState(() {
                    print("fdxgd");
                    audioPlayer.setLoopMode(LoopMode.playlist);
                    islooptap!=islooptap;
                  });
                },child: (islooptap=true)?Icon(Icons.loop):Icon(Icons.loop,color: Colors.grey.withOpacity(0.5),)),
                const SizedBox(width: 20,),
                FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: (){
                  setState(() {
                    print("fdxgd");
                    audioPlayer.toggleShuffle();
                    isshuffletap!=isshuffletap;
                  });
                },child: (isshuffletap=true)?Icon(Icons.shuffle):Icon(Icons.shuffle,color: Colors.grey.withOpacity(0.5),)),
              ],
            ),
            const SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: (){
                  setState(() {
                    volume+=0.1;
                    audioPlayer.setVolume(volume);
                  });
                },child: Icon(Icons.volume_up),),
                const SizedBox(width: 20,),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: (){
                  setState(() {
                    volume-=0.1;
                    audioPlayer.setVolume(volume);

                  });
                },child: Icon(Icons.volume_down),),
                const SizedBox(width: 20,),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: (){
                  setState(() {
                   volume=0;
                   audioPlayer.setVolume(volume);

                  });
                },child: Icon(Icons.volume_off),),
              ],
            ),
          ],
        ),


        );
  }

  void AnimateIcon() {
    setState(() {
      isAnimated = !isAnimated;

      if (isAnimated) {
setState(() {
  iconController.forward();
  audioPlayer.play();
  isstop =false;
});

      } else {
        iconController.reverse();
        audioPlayer.pause();
        isstop=true;
      }
    });
  }

  @override
  void dispose() {
    iconController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}

*/
