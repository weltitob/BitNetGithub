import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timezone/standalone.dart';

import '../bottomsheet/settings_controller.dart';

class ChangeTimeZone extends StatefulWidget {
  const ChangeTimeZone({super.key});

  @override
  State<ChangeTimeZone> createState() => _ChangeTimeZoneState();
}

class _ChangeTimeZoneState extends State<ChangeTimeZone> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: "Change Timezone",
        context: context,
        buttonType: ButtonType.transparent,
        onTap: () {
          controller.switchTab('main');
        },
      ),
      body: const TimezonePicker(),
    );
  }
}

class TimezonePicker extends StatefulWidget {
  const TimezonePicker({super.key});

  @override
  State<TimezonePicker> createState() => _TimezonePickerState();
}

class _TimezonePickerState extends State<TimezonePicker> {
  TextEditingController search = TextEditingController();
  bool loading = true;
  late List<Location> locations;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = L10n.of(context);
    if (loading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        locations = timeZoneDatabase.locations.values.toList();
        loading = false;

        setState(() {});
      });
    }
    return bitnetScaffold(
      context: context,
      resizeToAvoidBottomInset: false,
      body: loading
          ? dotProgress(context)
          : Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.elementSpacing),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    SearchFieldWidget(
                        hintText: "Search Timezone Here",
                        isSearchEnabled: true,
                        onChanged: (val) {
                          setState(() {
                            search.text = val;
                          });
                        },
                        handleSearch: (dynamic) {}),
                    TimezoneList(
                        timezones: timeZoneDatabase.locations.values.toList(),
                        search: search.text)
                  ],
                ),
              ),
            ),
    );
  }
}

class TimezoneList extends StatelessWidget {
  const TimezoneList(
      {super.key, required this.timezones, required this.search});
  final List<Location> timezones;
  final String search;

  @override
  Widget build(BuildContext context) {
    final selectedTimeZone =
        Provider.of<TimezoneProvider>(context, listen: true).timeZone;

    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
          itemCount: timezones.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, i) {
            return TimezoneBox(
              search: search,
              selectedTimeZone: selectedTimeZone,
              timeZone: timezones[i],
            );
          }),
    );
  }
}

class TimezoneBox extends StatelessWidget {
  final String search;
  final Location selectedTimeZone;
  final Location timeZone;

  const TimezoneBox(
      {super.key,
      required this.search,
      required this.selectedTimeZone,
      required this.timeZone});

  @override
  Widget build(BuildContext context) {
    if (search.isEmpty) {
      return TimezoneTile(
        timeZone: timeZone,
        selectedTimeZone: selectedTimeZone,
      );
    }
    if (timeZone.currentTimeZone.abbreviation
            .toLowerCase()
            .startsWith(search.toLowerCase()) ||
        timeZone.name.toLowerCase().startsWith(search.toLowerCase())) {
      return TimezoneTile(
          timeZone: timeZone, selectedTimeZone: selectedTimeZone);
    }
    return Container();
  }
}

class TimezoneTile extends StatelessWidget {
  final Location timeZone;
  final Location selectedTimeZone;

  const TimezoneTile(
      {super.key, required this.timeZone, required this.selectedTimeZone});
  @override
  Widget build(BuildContext context) {
    return BitNetListTile(
      customTitle: Text(
        processTimezoneIdentifier(timeZone.name),
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        "${formatDurationOffset(Duration(milliseconds: timeZone.currentTimeZone.offset))} ${timeZone.currentTimeZone.abbreviation}",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      selected: timeZone == selectedTimeZone,
      onTap: () {
        Provider.of<TimezoneProvider>(context, listen: false)
            .setTimezoneInDatabase(timeZone);
        Navigator.pop(context);
      },
    );
  }
}

String formatDurationOffset(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);

  // Determine the sign and absolute values
  String sign = hours >= 0 ? "+" : "-";
  hours = hours.abs();
  minutes = minutes.abs();

  // Format as "+HH:MM" or "-HH:MM"
  return "$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
}

String processTimezoneIdentifier(String timezone) {
  // Replace "/" with ", " and "_" with " "
  String formattedTimezone =
      timezone.replaceAll("/", ", ").replaceAll("_", " ");

  // Split at ", " to separate the two parts
  return formattedTimezone;
}
