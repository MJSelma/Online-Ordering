import 'package:drinklinkmerchant/provider/menu_provider.dart';
import 'package:drinklinkmerchant/ui/smart_menu/smart_menu.dart';
import 'package:drinklinkmerchant/ui/smart_menu/workStation.dart';
import 'package:drinklinkmerchant/ui/smart_menu/worktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class SmartMenuPage extends HookWidget {


  @override
  Widget build(BuildContext context) {
    final int menu = context.select((MenuProvider p) => p.menuCount);
 
    

    print(menu.toString());
    if(menu == 0){
      return WorkStation();
    }else if(menu == 1){
      return WorkTop();
    }else if(menu == 2){
      return SmartMenu();
    }else{
      return SmartMenu();
    }
  }
}