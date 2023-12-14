import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/business_outlet_provider.dart';
import '../../provider/menu_provider.dart';
import '../constant/theme_data.dart';
import '../data_class/outlet_class.dart';

class OutletMenu extends StatefulWidget {
  const OutletMenu({super.key});

  @override
  State<OutletMenu> createState() => _OutletMenuState();
}

class _OutletMenuState extends State<OutletMenu> {
  List<OutletClass> outletClasss = [];
  String currentItem = 'Select Outlet';
  String outletIdProvider = '';

  List<DropdownMenuEntry<OutletClass>> _createListOutlet() {
    return outletClasss.map<DropdownMenuEntry<OutletClass>>((e) {
      return DropdownMenuEntry(value: e, label: e.name);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final indexPageName =
        context.select((BusinessOutletProvider p) => p.indexPageName);
    final outletClassx =
        context.select((BusinessOutletProvider p) => p.outletClass);
    // final defaultOutletIdProvider =
    //     context.select((BusinessOutletProvider p) => p.defaultOutletId);

    final outletId =
        context.select((BusinessOutletProvider p) => p.selectedOutletId);

    outletClasss = outletClassx;
    outletIdProvider = outletId;
    for (var data in outletClasss) {
      if (data.id.toLowerCase() == outletIdProvider.toLowerCase()) {
        currentItem = data.name;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(13.0, 8.0, 8.0, 8.0),
            child: Text(
              indexPageName.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: defaultFontFamily,
                  fontSize: defaultMainWallFontSize,
                  color: systemDefaultColorOrange),
            ),
          ),
          SizedBox(
            width: 350,
            child: outletClasss.isEmpty
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Outlet',
                        style: TextStyle(
                            fontFamily: defaultFontFamily,
                            color: systemDefaultColorOrange,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: DropdownMenu<OutletClass>(
                          enableSearch: true,
                          enableFilter: true,
                          inputDecorationTheme: const InputDecorationTheme(
                              border: InputBorder.none,
                              fillColor: Color(0xffef7700),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xffef7700))),
                          trailingIcon: const Icon(
                            Icons.search,
                            color: Color(0xffef7700),
                          ),
                          width: 200,
                          hintText: currentItem,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xffef7700)),
                          onSelected: (OutletClass? value) {
                            setState(() {
                              context
                                  .read<MenuProvider>()
                                  .selectedMenu('', '', '', '', '');
                              context
                                  .read<BusinessOutletProvider>()
                                  .setSelectedOutletId(value!.id);
                              context
                                  .read<BusinessOutletProvider>()
                                  .setCountry(value.country, value.location);
                            });
                            context.read<MenuProvider>().menuRefresh();
                          },
                          dropdownMenuEntries: _createListOutlet(),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
