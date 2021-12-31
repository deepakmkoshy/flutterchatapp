import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

class Audiooo extends StatefulWidget {
  const Audiooo({Key? key}) : super(key: key);

  @override
  State<Audiooo> createState() => _AudioooState();
}

class _AudioooState extends State<Audiooo> {
  // Obtain mic permission from user
  Future<void> getPermissions() async {
    var statusMic = await Permission.microphone.request();

    // Asking again for permission
    if (statusMic == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kindly allow mic access for sending voice messages'),
        ),
      );
      getPermissions();
    }
  }

  @override
  void initState() {
    getPermissions();
    initRec();
    super.initState();
  }

// TMP utils to be moved to other folder
  late FlutterSoundRecorder _mRecorder;
  bool _mRecorderIsInited = false;
  late String _mPath;
  late FlutterSoundPlayer _mPlayer;
  bool _mPlayerIsInited = false;
  bool _mplaybackReady = true;
  String dur = "0:00";
  String tmpUrl = "www";

  Future<void> openTheRecorder() async {
    await _mRecorder.openAudioSession();
    _mRecorderIsInited = true;
  }

  void initRec() {
    _mPlayer = FlutterSoundPlayer();
    _mRecorder = FlutterSoundRecorder();
    _mPlayer.openAudioSession().then((value) {
      _mPlayerIsInited = true;
      //   notifyListeners();
    });
    openTheRecorder().then((value) {
      _mRecorderIsInited = true; //reduntant
    });
  }

  void dispRec() {
    _mPlayer.closeAudioSession();
    stopRecorder();
    _mRecorder.closeAudioSession();
    // _mRecorder = null;
    if (_mPath != null) {
      var outputFile = File(_mPath);
      if (outputFile.existsSync()) {
        outputFile.delete();
      }
    }
  }

  Future<void> stopPlayer() async {
    await _mPlayer.stopPlayer();
  }

  // Future<void> getAudioDetails(){
  //   flutterSoundHelper.
  // }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  Future<void> record() async {
    var tempDir = await getApplicationDocumentsDirectory();
    String newFilePath = p.join(tempDir.path, getRandString(10));
    _mPath = '$newFilePath.aac';
    var outputFile = File(_mPath);
    if (outputFile.existsSync()) {
      await outputFile.delete();
    }

    assert(_mRecorderIsInited && _mPlayer.isStopped);
    await _mRecorder.startRecorder(
      toFile: _mPath,
      codec: Codec.aacADTS,
    );
    // notifyListeners();
  }

  void play(String url) async {
    tmpUrl = _mPath;
    print(url);

    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder.isStopped &&
        _mPlayer.isStopped);

    await _mPlayer.startPlayer(
        fromURI: _mPath,
        codec: Codec.aacADTS,
        whenFinished: () {
          print('Finished PLaying');
          isPlaying = false;
          setState(() {});
        });
  }

  Future<void> stopRecorder() async {
    await _mRecorder.stopRecorder();
    print(
        "############\n##################\n\nAudio file created at " + _mPath);
    //_mplaybackReady = true;
  }

// var for build
  bool isRecording = false;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {
                    if (!isRecording) {
                      record();
                      isRecording = true;
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.mic),
                ),
                IconButton(
                  onPressed: () {
                    if (isRecording) {
                      stopRecorder();
                      isRecording = false;
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.stop),
                ),
                SizedBox(width: 10),
                Text(isRecording
                    ? 'Recording in progress...'
                    : 'Recording Stopped')
              ],
            ),
            IconButton(
              onPressed: () {
                play(_mPath);
                isPlaying = true;
                setState(() {});
              },
              icon: Icon(Icons.play_arrow),
            ),
            Text(isPlaying ? 'Audio is playing...' : 'Not playing!')
          ],
        ),
      ),
    );
  }
}
