# Flutter chat with Reactive voice animation

This was a fun weekend project with the mission to implement reactive voice waveform for voice chats, similar to the one found in Instagram chats.

It was a bit tough to figure this out since I couldn't find any good resources on how to implement it.

In the end, I got it done by subscribing to a stream subscription provided by the [flutter sound](https://pub.dev/packages/flutter_sound) package which has the decibel count at specific intervals. Converted this data into a wave animation with the help of [Audio Wave](https://pub.dev/packages/audio_wave).

Screenshots:


I will be posting a more in depth article soon, on how to implement this in your flutter project.
