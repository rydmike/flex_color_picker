import 'package:flutter/material.dart';

import '../../utils/app.dart';
import '../../widgets/flex_app_bar.dart';
import 'about.dart';
import 'all_control_widgets.dart';
import 'color_picker_card.dart';
import 'picker_text_fields/text_field_focus_demo.dart';
import 'picker_toggle_buttons/actions_order_switch.dart';

/// Screen with the two ColorPickers and all controls and settings we use to
/// manipulate their design and behavior.
///
/// The layout is responsive and can have 1 to 4 columns that contains the
/// ColorPicker and the controls, each column when visible has its own
/// ListView, so the columns can be scrolled individually when they are visible.
class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Used for a simple scrollable column based responsive layout
    final double width = MediaQuery.of(context).size.width;
    // That can have 1 to max 4 columns
    int columns = width ~/ App.minColumnWidth;
    if (columns < 1) columns = 1;
    if (columns > 4) columns = 4;

    // ScrollControllers for potential 4 List views
    final ScrollController scrollOne = ScrollController();
    final ScrollController scrollTwo = ScrollController();
    final ScrollController scrollThree = ScrollController();
    final ScrollController scrollFour = ScrollController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FlexAppBar.styled(
        context,
        centerTitle: true,
        title: const Text('FlexColorPicker Demo'),
        actions: const <Widget>[AboutIconButton()],
        blurred: true,
        opacity: 0.5,
        gradient: false,
        hasBorderOnSurface: true,
        scrim: false,
      ).toAppBar(),
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
                  controller: scrollOne,
                  // TODO(rydmike): Remove commented deprecated API.
                  // isAlwaysShown: true,
                  thumbVisibility: true,
                  interactive: true,
                  child: ListView(
                    controller: scrollOne,
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
                    controller: scrollTwo,
                    // TODO(rydmike): Remove commented deprecated API.
                    // isAlwaysShown: true,
                    thumbVisibility: true,
                    interactive: true,
                    child: ListView(
                      controller: scrollTwo,
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
                    controller: scrollThree,
                    // TODO(rydmike): Remove commented deprecated API.
                    // isAlwaysShown: true,
                    thumbVisibility: true,
                    interactive: true,
                    child: ListView(
                      controller: scrollThree,
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
                    controller: scrollFour,
                    // TODO(rydmike): Remove commented deprecated API.
                    // isAlwaysShown: true,
                    thumbVisibility: true,
                    interactive: true,
                    child: ListView(
                      controller: scrollFour,
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
  const _Column1();

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
        const TextFieldFocusDemo(),
        const Divider(),
      ],
    );
  }
}

class _Column2 extends StatelessWidget {
  const _Column2();
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
        const TonalSwitch(),
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
        const TonalSubheadingSwitch(),
        const OpacitySubheadingSwitch(),
        const RecentSubheadingSwitch(),
        const Divider(),
      ],
    );
  }
}

class _Column3 extends StatelessWidget {
  const _Column3();
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
        const WheelSquarePaddingSlider(),
        const WheelSquareBorderRadiusSlider(),
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
  const _Column4();
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
        const ActionsOrderSwitch(),
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
        const PickerAutoFocusSwitch(),
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
