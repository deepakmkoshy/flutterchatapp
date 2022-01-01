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
    if (decList.length > 20) {
      for (int i = 0; i < decList.length; i++) {
        if (i % 2 == 0) {
          decList.removeAt(i);
        }
      }
    }
  }
  return bars;
}
