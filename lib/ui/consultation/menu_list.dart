import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinklinkmerchant/%20model/consultation_menu_model.dart';
import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../../provider/businessOutletProvider.dart';

class ConsultMenuPage extends HookWidget {
  const ConsultMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isRefresh = context.select((MenuProvider p) => p.isRefresh);
    final menuList = useState<List<ConsultationMenuModel>>([]);
    final outletIdprovider =
        context.select((BusinessOutletProvider p) => p.selectedOutletId);
    final searchMenuName = context.select((MenuProvider p) => p.searchMenuName);

    useEffect(() {
      Future.microtask(() async {
        await getMenu(menuList, context, outletIdprovider, searchMenuName);
      });
      return null;
    }, [isRefresh]);

    return Expanded(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenuList(context, menuList),
              ],
            )));
  }

  getMenu(ValueNotifier menuList, BuildContext context, String outletId,
      String menuName) async {
    List<ConsultationMenuModel> ulist = [];
    await FirebaseFirestore.instance
        .collection('merchant')
        .doc('X6odvQ5gqesAzwtJLaFl')
        .collection('consultationMenu')
        .orderBy('order', descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        debugPrint(doc.id);
        ConsultationMenuModel obj = ConsultationMenuModel(
            doc.id,
            doc['name'],
            doc['fileName'],
            doc['image'],
            doc['date'].toString(),
            doc['status'].toString(),
            doc['type'],
            doc['order'],
            doc['outletId']);

        ulist.add(obj);
      });

      if (menuName != '') {
        ulist = ulist
            .where((item) =>
                item.outletId.toLowerCase() == outletId.toLowerCase() &&
                item.name.toLowerCase().contains(menuName.toLowerCase()))
            .toList();
      } else {
        ulist = ulist
            .where(
                (item) => item.outletId.toLowerCase() == outletId.toLowerCase())
            .toList();
      }
    });

    menuList.value = ulist;
    context.read<MenuProvider>().updateMenuCount(ulist.length);
  }

  Widget _buildMenuList(BuildContext context,
      ValueNotifier<List<ConsultationMenuModel>> menuList) {
    return Expanded(
        // child: GridView.builder(
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3),
        //     itemCount: menuList.value.length,
        //     itemBuilder: (context, index) {

        //     }),

        child: ReorderableGridView.extent(
      maxCrossAxisExtent: 150,
      onReorder: (int index, int newIndex) async {
        print(index);
        print(newIndex);
        final item = menuList.value.removeAt(index);
        newIndex = newIndex + 1;
        FirebaseFirestore.instance
            .collection('merchant')
            .doc('X6odvQ5gqesAzwtJLaFl')
            .collection('consultationMenu')
            .doc(item.id)
            .update({
          'order': newIndex,
        }).then((value) async {
          context.read<MenuProvider>().menuRefresh();
        });
      },
      childAspectRatio: 1,
      children: menuList.value.map((item) {
        /// map every list entry to a widget and assure every child has a
        /// unique key
        return Padding(
          key: ValueKey(item),
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              if (item.type != 'pdf') {
                context.read<MenuProvider>().selectedMenu(
                    item.id, item.name, item.image, item.type, '');
              } else {
                String pdfdata = '''
        <!DOCTYPE html>
        <html>
         <h3>${item.name}</h3>
        <object data=
        "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20210101201653/PDF.pdf" 
                width="300"
                height="300">
        </object>
        <p>
          A paragraph with <strong>strong</strong>, <em>emphasized</em>
          and <span style="color: red">colored</span> text.
        </p>
          </html>
        ''';
                context.read<MenuProvider>().selectedMenu(
                    item.id, item.name, item.image, item.type, pdfdata);
              }
            },
            child: Container(
              width: 140,
              height: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    if (item.type != 'pdf') ...[
                      Image.network(
                        item.image,
                        fit: BoxFit.cover,
                      ),
                    ] else ...[
                      const Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.picture_as_pdf))
                    ],
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white.withOpacity(.8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(item.name),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ));
  }

//   /// create a new list of data
// final items = List<int>.generate(40, (index) => index);

// /// when the reorder completes remove the list entry from its old position
// /// and insert it at its new index
// void _onReorder(int oldIndex, int newIndex) {
// setState(() {
//     final item = items.removeAt(oldIndex);
//     items.insert(newIndex, item);
// });
// }
}
