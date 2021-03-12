import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:YOURDRS_FlutterAPP/blocs/dictation_screen/audio_dictation_event.dart';
import 'package:YOURDRS_FlutterAPP/blocs/dictation_screen/audio_dictation_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';


class AudioDictationBloc extends Bloc<AudioDictationEvent, AudioDictationState> {
  FlutterAudioRecorder _recorder;
  Timer _timer;
  var finalPath;
  AudioDictationBloc() : super(AudioDictationState.initial());

  @override
  Stream<AudioDictationState> mapEventToState(AudioDictationEvent event,) async* {
    if (event is InitRecord) {
      yield* _init();
    }
    else if (event is TimerTicked) {
      print('TimerTicked ${event.recording.status}');
      yield state.copyWith(
        current: event.recording,
        currentStatus: event.recording.status,
        duration: event.recording.duration,
      );
    }
    else if (event is StartRecord) {
      yield* _start();
    }
    else if (event is PauseRecord) {
      yield* _pause();
    }
    else if (event is ResumeRecord) {
      yield* _resume();
    }
    else if (event is StopRecord) {
      yield* _stop();

      print('path: ${state.current.path}');
      List<int> fileBytes = await File(state.current.path).readAsBytes();

      String base64String = base64Encode(fileBytes);
      final fileString = 'data:audio/mp4;base64,$base64String';
      print(fileString.toString());
      print('file length: ${fileString.length}');
      yield* _init();
    }
    else if (event is DeleteRecord) {
      yield* _reset();
    }
  }

  /// initializing the recorder
  Stream<AudioDictationState> _init() async* {
    try {
      yield state.copyWith(
          viewVisible: false, currentStatus: null, current: null);
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/Your_DRS_Recorder_';
        Directory appDocDirectory;
        if (Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }
        /// can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().microsecondsSinceEpoch.toString() + ".mp4";
        /// .wav <---> AudioFormat.WAV
        /// .mp4 .m4a .aac <---> AudioFormat.AAC
        /// AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.AAC);
        await _recorder.initialized;
        /// after initialization
        var current = await _recorder.current(channel: 0);
        print('${current.status}');
        /// should be "Initialized", if all working fine
        yield state.copyWith(
          current: current,
          currentStatus: current.status,
        );
      } else {
        yield state.copyWith(
            errorMsg: 'You must accept permissions'
        );
      }
    } catch (e) {
      print(e);
      yield state.copyWith(
          errorMsg: e.toString()
      );
    }
  }

  /// start the recording
  Stream<AudioDictationState> _start() async* {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      yield state.copyWith(
        viewVisible: true,
        current: recording,
        currentStatus: recording.status,
      );
      const tick = const Duration(milliseconds: 50);
      _timer = Timer.periodic(tick, (Timer t) async {
        if (state.currentStatus == RecordingStatus.Stopped || state.currentStatus == RecordingStatus.Paused) {
          t.cancel();
        }
        var current = await _recorder.current(channel: 0);
        add(TimerTicked(current));
      });
    } catch (e) {
      print(e);
      yield state.copyWith(
          viewVisible: false,
          errorMsg: e.toString()
      );
    }
  }

  /// reset the timer and delete file
  Stream<AudioDictationState> _reset() async* {
    try {
      _timer?.cancel();
      await _recorder.stop();
      var recording = await _recorder.current(channel: 0);
      print('${recording.status}');
      yield state.copyWith(
        viewVisible: false,
        current: recording,
        currentStatus: recording.status,
      );
      var result = await _recorder.stop();
      var res = await File(result.path).delete();
      print("Deleted $res");
      add(InitRecord());
    } catch (e) {
      print(e);
      yield state.copyWith(
          errorMsg: e.toString()
      );
    }
  }

  /// resume the recording
  Stream<AudioDictationState> _resume() async* {
    try {
      await _recorder.resume();
      var recording = await _recorder.current(channel: 0);
      yield state.copyWith(
          viewVisible: true,
          currentStatus: recording.status,
          current: recording);
      const tick = const Duration(milliseconds: 50);
      _timer = Timer.periodic(tick, (Timer t) async {
        if (state.currentStatus == RecordingStatus.Stopped /*|| state.currentStatus == RecordingStatus.Paused*/) {
          t.cancel();
        }
        var current = await _recorder.current(channel: 0);
        add(TimerTicked(current));
      });
    } catch (e) {
      print(e);
      yield state.copyWith(viewVisible: false, errorMsg: e.toString());
    }
  }

  /// pause the recording
  Stream<AudioDictationState> _pause() async* {
    _timer.cancel();
    await _recorder.pause();
    var recording = await _recorder.current(channel: 0);

    yield state.copyWith(
        viewVisible: false,
        currentStatus: recording.status,
        current: recording);
  }

  /// stop the recording
  Stream<AudioDictationState> _stop() async* {
    _timer?.cancel();
    var result = await _recorder.stop();
    print("Stop recording: ${result.duration} ${result.path}");

    finalPath=result.path;
    yield state.copyWith(
      viewVisible: false,
      current: result,
      currentStatus: result.status,
    );
  }
}

