import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';

class TraditionalSongPage extends StatefulWidget {
  const TraditionalSongPage();

  @override
  _TraditionalSongPage createState() => _TraditionalSongPage();
}

class _TraditionalSongPage extends State<TraditionalSongPage> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('sounds/ca_khuc_truyen_thong.mp3'));
      await player.resume();
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ca khúc truyền thống',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/guest/ca_khuc_truyen_thong.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: PlayerWidget(player: player),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Lời bài hát'),
                        content: SingleChildScrollView(
                          child: Text(
                            'Ta cũng bên nhau về nơi đây Đại học Thủ Dầu Một tay cũng trong tay sát vai nhau dĩu nhau ta tiên bước.\n'
                            'Bao năm tháng sách đèn ta ra sức luyện rèn để thành người đi gieo ánh sáng.\n'
                            'Mang tri thức con người ta ra sức xây đời để cuộc đời bay vào tươi lai sáng tươi.\n'
                            'Bình Dương hôm nay đang chờ đoàn ta hăng say nơi đây.\n'
                            'Việt Nam quê hương đang chờ đàn chim tung bay muôn phương.\n',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Hiển thị lời bài hát'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Button background color
                  foregroundColor: Colors.white, // Text color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 8, // Adds shadow for a raised effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// The PlayerWidget remains the same with a few style changes:
class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const PlayerWidget({required this.player, super.key});

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get player => widget.player;

  @override
  void initState() {
    super.initState();
    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() => _duration = value),
        );
    player.getCurrentPosition().then(
          (value) => setState(() => _position = value),
        );
    _initStreams();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: _isPlaying ? null : _play,
              iconSize: 48.0,
              icon: const Icon(Icons.play_arrow),
              color: color,
            ),
            IconButton(
              onPressed: _isPlaying ? _pause : null,
              iconSize: 48.0,
              icon: const Icon(Icons.pause),
              color: color,
            ),
            IconButton(
              onPressed: _isPlaying || _isPaused ? _stop : null,
              iconSize: 48.0,
              icon: const Icon(Icons.stop),
              color: color,
            ),
          ],
        ),
        Slider(
          onChanged: (value) {
            final duration = _duration;
            if (duration == null) return;
            final position = value * duration.inMilliseconds;
            player.seek(Duration(milliseconds: position.round()));
          },
          value: (_position != null &&
                  _duration != null &&
                  _position!.inMilliseconds > 0 &&
                  _position!.inMilliseconds < _duration!.inMilliseconds)
              ? _position!.inMilliseconds / _duration!.inMilliseconds
              : 0.0,
        ),
        Text(
          _position != null
              ? '$_positionText / $_durationText'
              : _duration != null
                  ? _durationText
                  : '',
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });
    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );
    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });
    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() => _playerState = state);
    });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }
}
