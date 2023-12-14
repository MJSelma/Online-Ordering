class MenuSectionModel {
  final String id;
   String name;
   List<menuNamesByLang> nameLanguage;
   bool sendAllWst;

  MenuSectionModel(this.id, this.name, this.nameLanguage, this.sendAllWst);
}

class menuNamesByLang {
  final String id;
   String name;
   String language;

  menuNamesByLang(this.id, this.name, this.language);
}