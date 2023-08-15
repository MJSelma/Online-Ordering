import 'package:drinklinkmerchant/ui/data_class/cases_messages_class.dart';

class CasesClass {
  final String id;
  final String caseId;
  final DateTime deteStart;
  final DateTime dateEnd;
  final String customerName;
  final String customerUser;
  final String customerContact;
  final String caseType;
  final String caseObjective;
  final String caseDescription;
  final String agentName;
  final String status;
  final String note;
  final String customerId;
  final String customerImage;
  final String merchantId;
  final String branchId;
  final String agentId;
  final String agentImage;
  List<CasesMessagesClass> casesMessagesClass;
  CasesClass(
      {required this.id,
      required this.caseId,
      required this.deteStart,
      required this.dateEnd,
      required this.customerName,
      required this.customerUser,
      required this.customerContact,
      required this.caseType,
      required this.caseObjective,
      required this.caseDescription,
      required this.agentName,
      required this.status,
      required this.note,
      required this.customerId,
      required this.customerImage,
      required this.merchantId,
      required this.branchId,
      required this.agentId,
      required this.agentImage,
      required this.casesMessagesClass});
}
