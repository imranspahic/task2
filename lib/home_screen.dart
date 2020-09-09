import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import './widgets/alert_dialog.dart';
import './widgets/audio.dart';
import './functions/preuzmi_func.dart';
import 'package:provider/provider.dart';
import './providers/preuzimanje.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  PreuzmiFunc func = PreuzmiFunc();
  bool dialog = true;
  // bool preuzetiFajlovi = false;

  @override
  void initState() {
    func.provjeriFajlove().then((val) {
      print('initstate');

      //fajlovi nisu preuzeti, prikazi dialog
      if (!val) {
        showDialog(
            context: context,
            builder: (ctx) {
              return CustomAlert();
            }).then((value) {

              if(value==null){
                Provider.of<Preuzimanje>(context,listen: false).togglePreuzimanje();
              }
          //dialog zatvoren
          setState(() => dialog = false);
        });
      }
      //fajlovi vec preuzeti
      else {
        setState(() {
          dialog = false;
          // preuzetiFajlovi = true;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Task2'),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        elevation: 0,
      ),
      backgroundColor: Colors.indigo[800],
      body: !dialog
          ? SingleChildScrollView(
              child: Column(children: [
                Audio(
                  index: 1,
                  pokreni: 'ikona',
                  audioPlayer: audioPlayer,
                ),
                Audio(
                  index: 2,
                  pokreni: 'ikona',
                  audioPlayer: audioPlayer,
                ),
                Audio(
                  index: 3,
                  pokreni: 'ikona',
                  audioPlayer: audioPlayer,
                ),
                Audio(
                  index: 4,
                  pokreni: 'ikona',
                  audioPlayer: audioPlayer,
                ),
                Audio(
                  index: 5,
                  pokreni: 'ikona',
                  audioPlayer: audioPlayer,
                ),
                Audio(
                  index: 6,
                  pokreni: 'tekst',
                  tekst: 'tekst prvi',
                  audioPlayer: audioPlayer,
                ),
                Audio(
                  index: 7,
                  pokreni: 'tekst',
                  tekst: 'tekst drugi',
                  audioPlayer: audioPlayer,
                ),
                Audio(
                  index: 8,
                  pokreni: 'tekst',
                  tekst: 'tekst treci',
                  audioPlayer: audioPlayer,
                ),
                Audio(
                  index: 9,
                  pokreni: 'slika',
                  audioPlayer: audioPlayer,
                  slika: 'slika_1.jpg',
                ),
                Audio(
                  index: 10,
                  pokreni: 'slika',
                  audioPlayer: audioPlayer,
                  slika: 'slika_2.png',
                ),
              ]),
            )
          : Container(),
    );
  }
}
