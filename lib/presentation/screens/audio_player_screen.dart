import 'package:flutter/material.dart';
import 'package:audio_player/bloc/audio_player/audio_player_bloc.dart';
import 'package:audio_player/presentation/widgets/painter_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Audio Player')),
      ),
      body: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          // listen for frequency updates
          final frequencies = context.watch<AudioPlayerBloc>().frequencies;

          final bool isPlaying = state == AudioPlayerState.playing;
          final IconData icon = isPlaying ? Icons.pause : Icons.play_arrow;
          onPressed() {
            if (isPlaying) {
              context.read<AudioPlayerBloc>().add(AudioPlayerEvent.pause);
            } else {
              context.read<AudioPlayerBloc>().add(AudioPlayerEvent.play);
            }
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF6A5ACD),
              Color(0xFF4682B4),
              Color(0xFF4682B4),
            ])),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 13),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  Color(0xFF6A5ACD),
                                  Color(0xFF4682B4),
                                ])),
                            child: IconButton(
                              icon: Icon(
                                icon,
                                color: Colors.white,
                              ),
                              iconSize: 38.0,
                              onPressed: onPressed,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 7.5,
                          width: MediaQuery.of(context).size.width / 2,
                          child: CustomPaint(
                            size: Size.zero,
                            painter: PainterWidget(frequencies),
                            child: const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
