import 'package:bloc/bloc.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'audio_event.dart';
import 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  AudioBloc() : super(AudioInitial()) {
    on<PlayAudio>((event, emit) async {
      await _assetsAudioPlayer.open(
        Audio("assets/audio/sample1.mp3"),
        autoStart: true,
      );
      emit(AudioPlaying());
    });

    on<PauseAudio>((event, emit) async {
      await _assetsAudioPlayer.pause();
      emit(AudioPaused());
    });

    on<ResumeAudio>((event, emit) async {
      await _assetsAudioPlayer.play();
      emit(AudioPlaying());
    });
  }

  Stream<Duration> get currentPosition => _assetsAudioPlayer.currentPosition;
  Stream<Playing?> get currentAudio => _assetsAudioPlayer.current;

  Future<void> seek(Duration position) async {
    await _assetsAudioPlayer.seek(position);
  }

  @override
  Future<void> close() {
    _assetsAudioPlayer.dispose();
    return super.close();
  }
}
