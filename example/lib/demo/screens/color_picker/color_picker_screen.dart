import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/app.dart';
import 'about.dart';
import 'all_control_widgets.dart';
import 'color_picker_card.dart';

/// Screen with the two ColorPickers and all controls and settings we use to
/// manipulate their design and behavior.
///
/// The laout is responsive and can have 1 to 4 columns that contains the
/// ColorPicker and the controls, each column when visible has its own
/// ListView, so the columns can be scrolled individually when they are visible.
class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Used for a simple scrollable column based responsive layout
    final double width = MediaQuery.of(context).size.width;
    // That can have 1 to max 4 columns
    int columns = width ~/ App.minColumnWidth;
    if (columns < 1) columns = 1;
    if (columns > 4) columns = 4;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FlexColorPicker Demo'),
        actions: const <Widget>[AboutIconButton()],
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .appBarTheme
                      .backgroundColor!
                      .withOpacity(0.7),
                  border: Border(
                    bottom: BorderSide(color: Theme.of(context).dividerColor),
                  )),
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: App.maxBodyWidth),
          child: Row(
            // The Row contains 1 to 4 ListViews, each in an Expanded widget.
            //
            // Based on width, the 1st one can contain, col 1, 1+2 or 1+2+3+4
            children: <Widget>[
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).padding.top +
                              kToolbarHeight),
                      const _Column1(),
                      if (columns < 3) const _Column2(),
                      if (columns < 2) const _Column3(),
                      if (columns < 2) const _Column4(),
                    ],
                  ),
                ),
              ),
              //
              // Based on width, the 2nd one can contain, col 3+4 or col 2,
              // when we have 2 columns or more.
              if (columns > 1)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        if (columns == 3 || columns == 4) const _Column2(),
                        if (columns < 3) const _Column3(),
                        if (columns < 3) const _Column4(),
                      ],
                    ),
                  ),
                ),
              //
              // Based on width, the 3rd one can contain, col 3 or col 3+4,
              // when we have 3 columns or more.
              if (columns > 2)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        // Show the selected color in a dialog
                        const _Column3(),
                        if (columns < 4) const _Column4(),
                      ],
                    ),
                  ),
                ),
              //
              // The 4th one only shows the 4th column when we have 4 columns.
              if (columns > 3)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        const _Column4(),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Column1 extends StatelessWidget {
  const _Column1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 14),
          child: Text(
            'FlexColorPicker',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        // Show the color selected in a dialog and open a dialog to change it.
        const DialogPickerColorIndicator(),
        // Show the color selected in the picker in a Card below.
        const CardPickerColorIndicator(),
        // Show the picker meta remote control widget.
        const MetaPickerColorIndicator(),
        // The color picker in a Card.
        const Padding(
          padding: EdgeInsets.all(6),
          child: ColorPickerCard(),
        ),
        ListTile(
          subtitle: Wrap(runSpacing: 8, children: const <Widget>[
            OnStartColorIndicator(),
            SizedBox(width: 8),
            OnChangedColorIndicator(),
            SizedBox(width: 8),
            OnEndColorIndicator(),
          ]),
        ),
        const ListTile(
          title: Text('Color change callbacks'),
          subtitle: Text('Above callbacks are color before change started, '
              'during change and when change ended.'),
        ),
        const Divider(),
        const CopyFormatSwitch(),
        const SizedBox(height: 8),
        const ListTile(
          title: Text('Select and COPY a color value. PASTE it into the picker '
              'with toolbar buttons, context menu or keyboard shortcuts.\n'
              'Try these:'),
          subtitle: SelectableText('Primary FF7B1FA2  Accent FFCCFF90  '
              'BW FFF9F9F9\n'
              'Custom #014443  Wheel 0xFF6E55C4  ShortWeb 5EC\n'
              'Partial #DDFF  Opacity #99FF9800  Fail 94G02\n'
              'PASTE supports all above formats. COPY in selected format.'),
        ),
        const ParseShortHexCodeSwitch(),
        const Divider(),
      ],
    );
  }
}

class _Column2 extends StatelessWidget {
  const _Column2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 14),
          child: Text(
            'Show and hide',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        //
        const PickersEnabledSwitch(),
        const SizedBox(height: 8),
        const ShadesSwitch(),
        const Index850Switch(),
        const OpacitySwitch(),
        const Divider(),
        //
        const MaterialNameSwitch(),
        const ColorNameSwitch(),
        const ColorCodeSwitch(),
        const ColorCodeHasColorSwitch(),
        const ColorCodeReadOnlySwitch(),
        const ColorValueSwitch(),
        const RecentColorsSwitch(),
        const Divider(),
        //
        const TitleSwitch(),
        const HeadingSwitch(),
        const SubheadingSwitch(),
        const OpacitySubheadingSwitch(),
        const RecentSubheadingSwitch(),
        const Divider(),
      ],
    );
  }
}

class _Column3 extends StatelessWidget {
  const _Column3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 14),
          child: Text(
            'Picker design',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        // Color picker size
        const ItemSizeSlider(),
        const BorderRadiusSlider(),
        const ElevationSlider(),
        const SpacingSlider(),
        const RunSpacingSlider(),
        const HasBorderSwitch(),
        const Divider(),
        //
        const WheelDiameterSlider(),
        const WheelWidthSlider(),
        const WheelHasBorderSwitch(),
        const Divider(),
        //
        const OpacityTrackHeightSlider(),
        const OpacityTrackWidthSlider(),
        const OpacityThumbRadiusSlider(),
        const Divider(),
        //
        const EnableTooltipsSwitch(),
        const Divider(),
      ],
    );
  }
}

class _Column4 extends StatelessWidget {
  const _Column4({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 14),
          child: Text(
            'Picker layout',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const AlignmentSwitch(),
        const ColumnSpacingSlider(),
        const PaddingSlider(),
        const CloseButtonSwitch(),
        const OkButtonSwitch(),
        const CloseIsLastSwitch(),
        const DialogActionsButtonsSwitch(),
        const DialogActionIconsSwitch(),
        const Divider(),
        //
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
          child: Text(
            'Copy paste actions',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const ControlCopySwitch(),
        const ControlPasteSwitch(),
        const ToolbarCopySwitch(),
        const ToolbarPasteSwitch(),
        const EditFieldCopySwitch(),
        const SecondaryMenuSwitch(),
        const LongPressMenuSwitch(),
        const SecondaryDesktopLongDeviceSwitch(),
        const SecondaryDesktopLongWebDeviceSwitch(),
        const EditUsesParsedPasteSwitch(),
        const SnackbarParseErrorSwitch(),
        const FeedbackParseErrorSwitch(),
        const Divider(),
      ],
    );
  }
}
