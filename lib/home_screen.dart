import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import './widgets/alert_dialog.dart';
import './widgets/audio.dart';
import './functions/preuzmi_func.dart';
import 'package:provider/provider.dart';
import './providers/preuzimanje.dart';
import './models/AudioModel.dart';
import './models/PermissionModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  PreuzmiFunc func = PreuzmiFunc();
  bool dialog = true;
  
  @override
  void initState() {
    func.provjeriFajlove().then((val) {
      //fajlovi nisu preuzeti, prikazi dialog
      if (!val) {
        showDialog(
            context: context,
            builder: (ctx) {
              return CustomAlert();
            }).then((value) {
          //dialog zatvoren sa NE
          if (value == null) {
            Provider.of<Preuzimanje>(context, listen: false)
                .togglePreuzimanje();
          }

          setState(() => dialog = false);
        });
      }
      //fajlovi vec preuzeti
      else {
        setState(() => dialog = false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task2'),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        elevation: 0,
      ),
      backgroundColor: Colors.indigo[800],
      body: !dialog ?
      ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return Audio(audioModel: Provider.of<AppFunctions>(context, listen:false).audiomodels[index], audioPlayer: audioPlayer,);
        })

          : Container(),
    );
  }
}
