import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app.dart';
import '../../utils/theme.dart';
import '../color_picker/color_picker_screen.dart';
import '../color_picker/picker_toggle_buttons/theme_mode_switch.dart';
import 'reset_settings_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    // Use annotated region to style the status bar when there is no
    // AppBar and also style system navigation bar.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.overlayStyle(isLight),
      child: Scaffold(
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColorIndicator(
                  height: 60,
                  width: 60,
                  borderRadius: 8,
                  elevation: 4,
                  color: Colors.blueAccent[200]!,
                  isSelected: true,
                ),
                const SizedBox(width: 16),
                ColorIndicator(
                  height: 60,
                  width: 60,
                  color: Colors.blue[100]!,
                  hasBorder: true,
                ),
                const SizedBox(width: 16),
                ColorIndicator(
                  height: 60,
                  width: 60,
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
                  height: 60,
                  width: 60,
                  borderRadius: 30,
                  elevation: 9,
                  color: Colors.red[800]!,
                ),
                const SizedBox(width: 16),
                ColorIndicator(
                  height: 60,
                  width: 60,
                  borderRadius: 0,
                  color: Colors.redAccent[100]!,
                  hasBorder: true,
                ),
                const SizedBox(width: 16),
                ColorIndicator(
                  height: 60,
                  width: 60,
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
                  height: 60,
                  width: 60,
                  borderRadius: 4,
                  elevation: 1,
                  color: Colors.amber[400]!,
                ),
                const SizedBox(width: 16),
                ColorIndicator(
                  height: 60,
                  width: 60,
                  borderRadius: 30,
                  elevation: 1,
                  color: Colors.orange[300]!,
                  isSelected: true,
                ),
                const SizedBox(width: 16),
                ColorIndicator(
                  height: 60,
                  width: 60,
                  color: Colors.amber[800]!,
                ),
              ],
            ),
            const SizedBox(height: 20),

            OutlinedButton(
              onPressed: () {
                Navigator.push<Object>(
                  context,
                  MaterialPageRoute<Object>(
                    builder: (BuildContext context) =>
                        const ColorPickerScreen(),
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
            const SizedBox(height: 16),
            const Text(
              'Now includes API tooltips, as\n'
              'an interactive quick guide\n'
              'and persisted settings.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const ResetSettingsButton(),
            const SizedBox(height: 16),
            // Theme mode toggle
            const ThemeModeSwitch(),
            const Spacer(),
            Text(
              'Using flex_color_picker version ${App.version}',
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              'Web build with Flutter ${App.flutterVersion}',
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
