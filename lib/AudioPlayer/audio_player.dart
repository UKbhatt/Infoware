import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form/AudioPlayer/statemangement/Audio.dart';
import 'package:form/AudioPlayer/statemangement/audio_event.dart';
import 'package:form/AudioPlayer/statemangement/audio_state.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<AudioBloc>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 241, 241),
      appBar: AppBar(
        title: const Text(
          'Audio Player',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[400],
      ),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.5, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.linear,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<Playing?>(
                  stream: audioBloc.currentAudio,
                  builder: (context, snapshotAudio) {
                    final total =
                        snapshotAudio.data?.audio.duration ?? Duration.zero;
                    return StreamBuilder<Duration>(
                      stream: audioBloc.currentPosition,
                      builder: (context, snapshotPosition) {
                        final current = snapshotPosition.data ?? Duration.zero;
                        final totalSeconds = total.inSeconds > 0
                            ? total.inSeconds.toDouble()
                            : 1.0;

                        return Column(
                          children: [
                            Slider(
                              value: current.inSeconds
                                  .clamp(0, total.inSeconds)
                                  .toDouble(),
                              max: totalSeconds,
                              onChanged: (value) {
                                audioBloc
                                    .seek(Duration(seconds: value.toInt()));
                              },
                              activeColor: Colors.deepPurple,
                              inactiveColor: Colors.deepPurple.shade100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_formatDuration(current),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                                Text(_formatDuration(total),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
                BlocBuilder<AudioBloc, AudioState>(
                  builder: (context, state) {
                    IconData icon = Icons.play_circle_fill;
                    VoidCallback? onPressed;

                    if (state is AudioPlaying) {
                      icon = Icons.pause_circle_filled;
                      onPressed =
                          () => context.read<AudioBloc>().add(PauseAudio());
                    } else if (state is AudioPaused) {
                      icon = Icons.play_circle_fill;
                      onPressed =
                          () => context.read<AudioBloc>().add(ResumeAudio());
                    } else {
                      onPressed =
                          () => context.read<AudioBloc>().add(PlayAudio());
                    }
                    return IconButton(
                      icon: Icon(icon),
                      iconSize: 80,
                      color: Colors.deepPurple,
                      onPressed: onPressed,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
