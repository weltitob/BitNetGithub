import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';

class TimeChooserButton extends StatelessWidget {
  final String timeperiod;
  final String? timespan;
  final VoidCallback onPressed;

  const TimeChooserButton({
    Key? key,
    required this.timeperiod,
    this.timespan,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = timespan == timeperiod;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getZoomScale(context) > 2.9
              ? AppTheme.elementSpacing / 16
              : AppTheme.elementSpacing / 2),
      child: isSelected
          ? GlassContainer(
              border:
                  Border.all(width: 1.5, color: Theme.of(context).dividerColor),
              opacity: 0.1,
              borderRadius: const BorderRadius.all(
                  Radius.circular(AppTheme.cardPadding / 1.5)),
              child: _buildButtonContent(context, isSelected),
            )
          : _buildButtonContent(context, isSelected),
    );
  }

  Widget _buildButtonContent(BuildContext context, bool isSelected) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(50, isSelected ? 30 : 20),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.elementSpacing * 0.5,
          horizontal: AppTheme.elementSpacing,
        ),
        child: Text(
          timeperiod,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withOpacity(0.6),
              ),
        ),
      ),
    );
  }
}

class CustomizableTimeChooser extends StatefulWidget {
  final List<String> timePeriods;
  final Function(String) onTimePeriodSelected;
  final String initialSelectedPeriod;
  final Widget Function(BuildContext, String, bool, VoidCallback) buttonBuilder;

  const CustomizableTimeChooser({
    Key? key,
    required this.timePeriods,
    required this.onTimePeriodSelected,
    required this.initialSelectedPeriod,
    required this.buttonBuilder,
  }) : super(key: key);

  @override
  _CustomizableTimeChooserState createState() =>
      _CustomizableTimeChooserState();
}

class _CustomizableTimeChooserState extends State<CustomizableTimeChooser> {
  late String selectedPeriod;

  @override
  void initState() {
    super.initState();
    selectedPeriod = widget.initialSelectedPeriod;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            widget.timePeriods.map((period) => _buildButton(period)).toList(),
      ),
    );
  }

  Widget _buildButton(String period) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: widget.buttonBuilder(
          context,
          period,
          selectedPeriod == period,
          () => _handleButtonPress(period),
        ),
      ),
    );
  }

  void _handleButtonPress(String period) {
    setState(() {
      selectedPeriod = period;
    });
    widget.onTimePeriodSelected(period);
  }
}
