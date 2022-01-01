import 'package:audio_wave/audio_wave.dart';
import 'package:chatapp/constants/palette.dart';

List<AudioWaveBar> waves(List<double> decibelList) {
  List<AudioWaveBar> bars = [];
  List<double> decList = decibelList;

  for (var dec in decList) {
    dec = dec - 20;
    if (!(dec.isNegative)) {
      bars.add(AudioWaveBar(height: dec, color: Palette.secondaryColor));
    } else {
      bars.add(AudioWaveBar(height: 0, color: Palette.secondaryColor));
    }
    if (decList.length > 30) {
      for (int i = 0; i < decList.length; i++) {
        if (i % 2 == 0) {
          decList.removeAt(i);
        }
      }
    }
  }
  return bars;
}

double findWidth(List<double> decibelList) {
  int len = decibelList.length;
  if (len < 6) {
    return 60.0;
  } else if (len < 12) {
    return 100.0;
  } else if (len < 18) {
    return 120.0;
  } else if (len < 26) {
    return 160.0;
  } else {
    return 180.0;
  }
}
