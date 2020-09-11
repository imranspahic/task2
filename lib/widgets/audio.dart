import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:task2/widgets/alert_dialog.dart';
import '../providers/preuzimanje.dart';
import '../models/AudioModel.dart';
import '../models/PermissionModel.dart';

class Audio extends StatefulWidget {

  final AudioModel audioModel;

  // final int index;
  // final String pokreni;
  // final String tekst;
  // final String slika;
  final AudioPlayer audioPlayer;

  Audio({
    // this.index,
    // this.pokreni,
    // this.tekst,
    this.audioModel,
    this.audioPlayer,
    // this.slika,
  });

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  Future imgFuture;
  String url = '';
  bool check;
  bool isinit;
  List<ImageModel> list;


  Future<dynamic> getImage() async {
    final imgRef = FirebaseStorage.instance.ref().child(widget.audioModel.slika);
    url = await imgRef.getDownloadURL();
    return url;
  }

  void playAudio() async {
    if(!Provider.of<Preuzimanje>(context, listen: false).preuzeto) {
      showDialog(context: context, builder: (ctx) {
        return CustomAlert();
      }).then((value)  {
        if(value!=null) {
          Provider.of<Preuzimanje>(context, listen: false).togglePreuzimanje();
        }
      });
      return;
    }
    Directory dir = await path.getExternalStorageDirectory();
    String audioPath = '${dir.path}/audio/${widget.audioModel.id}.mp3';

    if (widget.audioPlayer.state == AudioPlayerState.PLAYING) {
      await widget.audioPlayer.stop();
    }
    await widget.audioPlayer.play(audioPath, isLocal: true);
    setState(() {});
  }

  void stopAudio() async {
    await widget.audioPlayer.stop();
    setState(() {});
  }

  void pauseAudio() async {
    await widget.audioPlayer.pause();
    setState(() {});
  }

  void resumeAudio() async {
    await widget.audioPlayer.resume();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isinit = true;
    PermissionModel().requestPermission().then((value) => PermissionModel()
        .checkPermissionStatus()
        .then((value) => check = value));
  }

    @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();

    if (isinit == true) {
      final prov = Provider.of<AppFunctions>(context);
      prov.processDocuments(false);
      list = prov.updatedImageModels;
      isinit = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    final imageModels = Provider.of<AppFunctions>(context).imageModels;
    return Card(
      elevation: 10,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListTile(
              leading: CircleAvatar(
                child: Text(widget.audioModel.id.toString()),
              ),
              title: Text('Audio ${widget.audioModel.id}'),
              trailing: widget.audioModel.pokreni == 'ikona'
                  ? widget.audioPlayer.state != AudioPlayerState.PLAYING
                      ? IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: playAudio,
                        )
                      : IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: stopAudio,
                        )
                  : widget.audioModel.pokreni == 'tekst'
                      ? InkWell(
                          child: Text(widget.audioPlayer.state !=
                                      AudioPlayerState.PLAYING &&
                                  widget.audioPlayer.state !=
                                      AudioPlayerState.PAUSED
                              ? widget.audioModel.tekst
                              : widget.audioPlayer.state ==
                                      AudioPlayerState.PAUSED
                                  ? 'Pauzirano'
                                  : 'Pauziraj'),
                          onTap: widget.audioPlayer.state !=
                                  AudioPlayerState.PLAYING
                              ? playAudio
                              : widget.audioPlayer.state ==
                                      AudioPlayerState.PAUSED
                                  ? resumeAudio
                                  : pauseAudio,
                        )
                      : 
                      ///slika prikaz
                      /////
                      /////
                      /////
                      ///
                      GestureDetector(
                          onTap: () => playAudio(),
                          child: Container(
                            width: 100,
                            height: 50,

                          
                            child: FutureBuilder(
                                future: getImage(),
                                builder: (ctx, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Image.network(url);
                                  } else {
                                    return Container();
                                  }
                                }),

                            
                          ),
                        )
                        )),
    );
  }
}
