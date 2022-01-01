import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../services/random_string.dart';

class AudioProvider extends ChangeNotifier {
// TMP utils to be moved to other folder
  late FlutterSoundRecorder _mRecorder;
  bool _mRecorderIsInited = false;
  late String _mPath;
  late FlutterSoundPlayer _mPlayer;
  bool _mPlayerIsInited = false;
  bool _mplaybackReady = true;
  String dur = "0:00";
  String tmpUrl = "www";

  List<double> decibelList = [];

  //getters
  bool get isPlaying => _mPlayer.isPlaying;
  bool get isRecStopped => _mRecorder.isStopped;
  String get mPath => _mPath;
  String get durat => dur;
  String get tUrl => tmpUrl;

  Future<void> openTheRecorder() async {
    await _mRecorder.openAudioSession();
    _mRecorderIsInited = true;
  }

  void initRec() {
    _mPlayer = FlutterSoundPlayer();
    _mRecorder = FlutterSoundRecorder();
    _mPlayer.openAudioSession().then((value) {
      _mPlayerIsInited = true;
      notifyListeners();
    });
    openTheRecorder().then((value) {
      _mRecorderIsInited = true; //reduntant

      _mRecorder.setSubscriptionDuration(const Duration(milliseconds: 300));
      _mRecorder.onProgress!.listen((e) {
        decibelList.add(e.decibels!);
        print('&&&&&&&&&&&&&&\t   DB level ${e.decibels}');
      });
      notifyListeners();
    });
  }

  // Get Duration of audio file

  Future<void> duration() async {
    await flutterSoundHelper.duration(_mPath).then((value) {
      if (value != null) {
        int sec = value.inSeconds;
        if (sec < 10) {
          dur = "0:0$sec";
        } else {
          dur = "0:$sec";
        }
      }
      notifyListeners();
    });
  }

  void dispRec() {
    _mPlayer.closeAudioSession();
    stopRecorder();
    _mRecorder.closeAudioSession();
    if (_mPath != null) {
      var outputFile = File(_mPath);
      if (outputFile.existsSync()) {
        outputFile.delete();
      }
    }
  }

  Future<void> stopPlayer() async {
    await _mPlayer.stopPlayer();
    notifyListeners();
  }

  // Future<void> getAudioDetails(){
  //   flutterSoundHelper.
  // }

  Future<void> record() async {
    decibelList.clear();
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

    notifyListeners();
  }

  Future<void> play(String url) async {
    tmpUrl = url;
    print(url);

    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder.isStopped &&
        _mPlayer.isStopped);

    await _mPlayer.startPlayer(
        fromURI: url,
        codec: Codec.aacADTS,
        whenFinished: () {
          stopPlayer();
        });
  }

  Future<void> stopRecorder() async {
    await _mRecorder.stopRecorder();
    await duration();
    notifyListeners();
    print(
        "############\n##################\n\nAudio file created at " + _mPath);
    _mplaybackReady = true;
  }
}
