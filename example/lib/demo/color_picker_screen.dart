import 'package:flutter/material.dart';

import 'all_control_widgets.dart';
import 'app_const.dart';
import 'color_picker_card.dart';

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

    // ********************************************************************
    // COLUMN 1 - Content
    // ********************************************************************
    final List<Widget> column1 = <Widget>[
      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
        child: Text(
          'FlexColorPicker',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      // Show the selected color in a dialog
      const DialogColorIndicator(),
      // Show the color selected in the picker below
      const ScreenColorIndicator(),
      // Color picker demo in a raised card
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
    ];

    // ********************************************************************
    // COLUMN 2 - Content
    // ********************************************************************
    final List<Widget> column2 = <Widget>[
      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
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
    ];

    // *************************************************************************
    // COLUMN 3 - Content
    // *************************************************************************
    final List<Widget> column3 = <Widget>[
      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
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
    ];

    // *************************************************************************
    // COLUMN 4 - Content
    // *************************************************************************
    final List<Widget> column4 = <Widget>[
      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
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
      const EditUsesParsedPasteSwitch(),
      const SnackbarParseErrorSwitch(),
      const FeedbackParseErrorSwitch(),
    ];

    // *************************************************************************
    // END of COLUMN content finals.
    // *************************************************************************
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FlexColorPicker Demo'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: App.maxBodyWidth),
          child: Row(
            // The Row contains 1 to 4 ListViews, each in an Expanded widget.
            children: <Widget>[
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).padding.top +
                              kToolbarHeight),
                      ...column1,
                      if (columns < 3) ...column2,
                      if (columns < 2) ...column3,
                      if (columns < 2) ...column4,
                    ],
                  ),
                ),
              ),
              if (columns > 1)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        if (columns == 3 || columns == 4) ...column2,
                        if (columns < 3) ...column3,
                        if (columns < 3) ...column4,
                      ],
                    ),
                  ),
                ),
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
                        ...column3,
                        if (columns < 4) ...column4,
                      ],
                    ),
                  ),
                ),
              if (columns > 3)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        ...column4,
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
