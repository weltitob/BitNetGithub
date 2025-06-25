import 'dart:ui';

import 'package:bitnet/backbone/helper/location.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:country_state_city/country_state_city.dart' as countryProvider;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PopUpCountryPickerWidget extends StatefulWidget {
  const PopUpCountryPickerWidget({super.key});

  @override
  State<PopUpCountryPickerWidget> createState() =>
      _PopUpCountryickerWidgetState();
}

class _PopUpCountryickerWidgetState extends State<PopUpCountryPickerWidget> {
  List<countryProvider.Country> countries = List.empty(growable: true);
  countryProvider.Country? initialCountry;
  bool sheetOpen = false;
  @override
  void initState() {
    setupAsyncData();
    super.initState();
  }

  void setupAsyncData() async {
    determinePosition().then((v) async {
      print("InitialCountry is being set to: ${v.country!}");
      initialCountry =
          await countryProvider.getCountryFromCode(v.isoCountryCode!);

      setState(() {});
    }, onError: (a, b) async {
      initialCountry = await countryProvider.getCountryFromCode("US");
      print("InitialCountry is being set to: ${initialCountry!.name}");
      setState(() {});
    });
    countries = await countryProvider.getAllCountries();
  }

  String isoToFlag(String iso) {
    String flag = iso.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        sheetOpen = true;
        setState(() {});
        await BitNetBottomSheet(
            height: MediaQuery.of(context).size.height * 0.65.h,
            borderRadius: AppTheme.borderRadiusBig,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .canvasColor, // Add a background color here
                    // borderRadius: new BorderRadius.only(
                    //   topLeft: AppTheme.cornerRadiusBig.w,
                    //   topRight: AppTheme.cornerRadiusBig.w,
                    // ),
                  ),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.only(
                    //   topLeft: AppTheme.cornerRadiusBig.w,
                    //   topRight: AppTheme.cornerRadiusBig.w,
                    // ),

                    child: bitnetScaffold(
                      extendBodyBehindAppBar: true,
                      context: context,
                      appBar: bitnetAppBar(
                        hasBackButton: false,
                        text: 'Select Country',
                        context: context,
                        buttonType: ButtonType.transparent,
                      ),
                      body: (countries.isEmpty || initialCountry == null)
                          ? Center(child: dotProgress(context))
                          : CountryPickerSheet(
                              onTapCountry: (country) {
                                Provider.of<CountryProvider>(context,
                                        listen: false)
                                    .setCountryInDatabase(country.isoCode,
                                        isUser: false);
                                initialCountry = country;
                                setState(() {});
                                // context.go('/authhome');
                              },
                              countries: countries,
                              current: initialCountry!,
                            ),
                    ),
                  ),
                );
              },
            ),
            context: context);
        sheetOpen = false;
        setState(() {});
      },
      child: Container(
        child: ClipRRect(
          borderRadius: AppTheme.cardRadiusMid,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppTheme.cardRadiusMid,
                border: GradientBoxBorder(
                  borderRadius: AppTheme.cardRadiusMid,
                ),
                color:
                    Theme.of(context).colorScheme.brightness == Brightness.light
                        ? AppTheme.white60
                        : AppTheme.colorGlassContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.elementSpacing / 1.75),
                child: Row(
                  children: [
                    SizedBox(
                      width: AppTheme.elementSpacing / 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: AppTheme.elementSpacing / 2),
                      child: Text((initialCountry?.flag ?? isoToFlag("US")),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Text((initialCountry?.name ?? "United States"),
                        style: Theme.of(context).textTheme.bodyLarge),
                    const Spacer(),
                    Icon(
                        sheetOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CountryPickerSheet extends StatefulWidget {
  const CountryPickerSheet(
      {super.key,
      required this.onTapCountry,
      required this.countries,
      required this.current});
  final Function(countryProvider.Country) onTapCountry;
  final List<countryProvider.Country> countries;
  final countryProvider.Country current;
  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final get = MediaQuery.of(context).size;

    return bitnetScaffold(
      context: context,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchFieldWidget(
                  hintText: "Search for a specific country here",
                  isSearchEnabled: true,
                  onChanged: (val) {
                    setState(() {
                      search.text = val;
                    });
                  },
                  handleSearch: (dynamic) {}),
              SizedBox(
                width: get.width,
                height: get.height * 0.6.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.countries.length,
                  itemBuilder: (context, index) {
                    if (search.text.isEmpty) {
                      return countryBox(index, widget.current.isoCode);
                    }
                    if (widget.countries[index].name
                        .toString()
                        .toLowerCase()
                        .startsWith(search.text.toLowerCase())) {
                      return countryBox(index, widget.current.isoCode);
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget countryBox(int index, String currentCountryIso) {
    return BitNetListTile(
      leading: Text(
        widget.countries[index].flag,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      selected:
          currentCountryIso == widget.countries[index].isoCode ? true : false,
      text: widget.countries[index].name,
      onTap: () {
        // Provider.of<LocalProvider>(context, listen: false)
        //     .setLocaleInDatabase(codeList[index],
        //     locale);
        //     setState((){});
        widget.onTapCountry(widget.countries[index]);
        Navigator.pop(context);
      },
    );
  }
}
