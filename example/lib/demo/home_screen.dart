import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import 'app_const.dart';
import 'color_picker_screen.dart';
import 'picker_toggle_buttons/theme_mode_switch.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            App.appName,
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            'Features demo for v2',
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
              padding: const EdgeInsets.all(7),
              child: Text(
                'Try the color picker',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Theme mode toggle
          const ThemeModeSwitch(),
          const Spacer(),
          Text(
            'Using flex_color_picker version ${App.version}',
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            'Built with Flutter ${App.flutterVersion}',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
