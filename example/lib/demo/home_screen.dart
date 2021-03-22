import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import 'color_picker_screen.dart';

// Just a simple way to leave a trace of what version you built a Flutter
// Web demo with inside the app. You can also show it in the demo,
// like in this example, so people testing it don't have to ask.
const String kFlutterVersion = 'Channel dev 2.1.0-12.1.pre SKIA';
const String kColorPickerVersion = '2.0.0-nullsafety.4';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.themeMode}) : super(key: key);
  final ValueChanged<ThemeMode> themeMode;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isDark;

  @override
  void initState() {
    isDark = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top),
          const Spacer(),
          Text(
            'FlexColorPicker',
            style: Theme.of(context).textTheme.headline4,
          ),

          Text(
            'Full feature demo for v2',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 8,
                elevation: 4,
                color: Colors.blueAccent[200]!,
                isSelected: true,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                color: Colors.blue[100]!,
                hasBorder: true,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 30,
                elevation: 8,
                color: Colors.indigo[600]!,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 30,
                elevation: 9,
                color: Colors.red[800]!,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 0,
                color: Colors.redAccent[100]!,
                hasBorder: true,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 16,
                elevation: 5,
                color: Colors.pink[800]!,
                isSelected: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 4,
                elevation: 1,
                color: Colors.amber[400]!,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 30,
                elevation: 1,
                color: Colors.orange[300]!,
                isSelected: true,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                color: Colors.amber[800]!,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Now includes API tooltips, as\n'
            'an interactive API quick guide.',
          ),
          const SizedBox(height: 40),
          OutlinedButton(
            onPressed: () {
              Navigator.push<Object>(
                context,
                MaterialPageRoute<Object>(
                  builder: (BuildContext context) => const ColorPickerScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Try the color picker',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Theme mode toggle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 270),
            child: SwitchListTile.adaptive(
              title: const Text('Dark mode'),
              subtitle: const Text('Turn OFF for light mode'),
              value: isDark,
              onChanged: (bool value) {
                setState(() {
                  isDark = value;
                  widget.themeMode(isDark ? ThemeMode.dark : ThemeMode.light);
                });
              },
            ),
          ),

          const Spacer(),
          Text(
            'Using flex_color_picker version $kColorPickerVersion',
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            'Built with Flutter $kFlutterVersion',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
