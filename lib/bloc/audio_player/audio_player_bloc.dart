import 'dart:math';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

enum AudioPlayerEvent { play, pause }

enum AudioPlayerState { initial, playing, paused, error }

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String _audioUrl =
      'https://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3';

  final List<double> _frequencies = List.filled(40, 0.0, growable: true);
  StreamSubscription<Duration>? _positionSubscription;

  AudioPlayerBloc() : super(AudioPlayerState.initial) {
    on<AudioPlayerEvent>(_onEventReceived);
  }

  Future<void> _onEventReceived(
      AudioPlayerEvent event, Emitter<AudioPlayerState> emit) async {
    if (event == AudioPlayerEvent.play) {
      await _playAudio(emit);
    } else if (event == AudioPlayerEvent.pause) {
      await _pauseAudio(emit);
    }
  }

// Play audio event
  Future<void> _playAudio(Emitter<AudioPlayerState> emit) async {
    try {
      await _audioPlayer.setUrl(_audioUrl);
      await _audioPlayer.play();
      emit(AudioPlayerState.playing);
      _startAudioEqualizer();
    } catch (e) {
      emit(AudioPlayerState.error);
    }
  }

// Pause audio event
  Future<void> _pauseAudio(Emitter<AudioPlayerState> emit) async {
    await _audioPlayer.pause();
    emit(AudioPlayerState.paused);
  }

  void _startAudioEqualizer() {
    final random = Random();
    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      for (int i = 0; i < _frequencies.length; i++) {
        _frequencies[i] = random.nextDouble();
      }
    });
  }

  List<double> get frequencies => _frequencies;

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    _positionSubscription?.cancel();
    return super.close();
  }
}
