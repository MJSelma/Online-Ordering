import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/businessOutletProvider.dart';
import '../../provider/menu_provider.dart';
import '../components/constant.dart';
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
    final defaultOutletIdProvider =
        context.select((BusinessOutletProvider p) => p.defaultOutletId);

    outletClasss = outletClassx;
    outletIdProvider = defaultOutletIdProvider;
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
            padding: const EdgeInsets.fromLTRB(25.0, 8.0, 8.0, 8.0),
            child: Text(
              indexPageName.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFPro',
                  fontSize: 20,
                  color: defaultFileColorOrange),
            ),
          ),
          // const Text(
          //   'Main Wall',
          //   style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //       color: Color(0xffef7700)),
          // ),
          // const Spacer(),
          SizedBox(
            width: 230,
            child: outletClasss.isEmpty
                ? Container()
                : Container(
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
          ),
        ],
      ),
    );
  }
}
