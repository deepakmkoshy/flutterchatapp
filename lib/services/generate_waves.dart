import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';

List<AudioWaveBar> waves(List<double> decibelList, Color color) {
  List<AudioWaveBar> bars = [];
  List<double> decList = List.from(decibelList);

  if (decList.length >= 32 && decList.length < 46) {
    int len = decList.length;
    int c = 0;
    bool tmp = false;
    for (int i = 0; i < len; i++) {
      if (tmp) {
        decList.removeAt(c);
        c++;
        tmp = !tmp;
      } else {
        tmp = !tmp;
      }
    }
  }
  for (var dec in decList) {
    dec = dec - 20;
    if (!(dec.isNegative)) {
      bars.add(AudioWaveBar(height: dec, color: color));
    } else {
      bars.add(AudioWaveBar(height: 2, color: color));
    }
  }
  return bars;
}

double findWidth(List<double> decibelList) {
  int len = decibelList.length;
  if (len < 6) {
    return 60.0;
  } else if (len < 12) {
    return 90.0;
  } else if (len < 18) {
    return 120.0;
  } else if (len < 26) {
    return 160.0;
  } else {
    return 200.0;
  }
}
