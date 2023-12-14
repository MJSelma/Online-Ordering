class WorkStationClass {
  final bool isActivate;
  final bool isSelfService;
  final bool isServedServices;
  final String stationSet;
  final int averagePreparationTime;
  final String stationSetId;
  WorkStationClass(
      {required this.isActivate,
      required this.isSelfService,
      required this.isServedServices,
      required this.stationSet,
      required this.averagePreparationTime,
      required this.stationSetId});
}
