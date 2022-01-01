import 'package:audio_wave/audio_wave.dart';
import 'package:chatapp/constants/palette.dart';

List<AudioWaveBar> waves(List<double> decibelList) {
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
      bars.add(AudioWaveBar(height: dec, color: Palette.secondaryColor));
    } else {
      bars.add(AudioWaveBar(height: 0, color: Palette.secondaryColor));
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
