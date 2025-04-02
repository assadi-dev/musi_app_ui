import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  final String title;
  final String artist;
  final String imageUrl;

  const PlayerScreen({
    Key? key,
    required this.title,
    required this.artist,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool isPlaying = false;
  double currentPosition = 0.51; // Starting position at 0:51
  double maxDuration = 4.0; // Total duration 4:00 minutes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Expanded(
                child: _buildAlbumArt(),
              ),
              _buildSongInfo(),
              _buildProgressBar(),
              _buildControls(),
              _buildBottomOptions(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Row(
            children: [
              Text(
                'Highlight',
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Lyrics',
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.circle,
                size: 4,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 16),
              Text(
                'Video',
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumArt() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 350,
        margin: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSongInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.artist,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 2,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.grey[800],
            thumbColor: Colors.white,
            overlayColor: Colors.white.withOpacity(0.2),
          ),
          child: Slider(
            value: currentPosition,
            min: 0,
            max: maxDuration,
            onChanged: (value) {
              setState(() {
                currentPosition = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0:${(currentPosition * 60).toInt().toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
              Text(
                '-3:${((maxDuration - currentPosition) * 60).toInt().toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            Icons.shuffle,
            color: Colors.yellow[700],
            size: 24,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.skip_previous,
            color: Colors.white,
            size: 36,
          ),
          onPressed: () {},
        ),
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.black,
              size: 36,
            ),
            onPressed: () {
              setState(() {
                isPlaying = !isPlaying;
              });
            },
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.skip_next,
            color: Colors.white,
            size: 36,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.repeat,
            color: Colors.yellow[700],
            size: 24,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBottomOptions() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.equalizer,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(
              'Equalizer Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.queue_music,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(
              'Queue List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}