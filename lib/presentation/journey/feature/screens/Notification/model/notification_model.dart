import 'package:intl/intl.dart';

class NotificationModels {
  int? iD;
  String? title;
  String? content;
  int? customerID;
  int? orderID;
  String? dateCreated;
  String? dateTimeText;
  int? type;
  bool? isRead;

  NotificationModels.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
    content = json['Content'];
    customerID = json['CustomerID'];
    orderID = json['OrderID'];
    dateCreated = json['DateCreated'];
    type = json['Type'];
    isRead = json['IsRead'];
    DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
    DateFormat dateFormat2 = DateFormat('hh:mm | dd/MM/yyyy');
    if (dateCreated?.isNotEmpty ?? false) {
      dateTimeText = dateFormat2.format(dateFormat.parse(dateCreated!));
    }
  }

  NotificationModels({this.iD});

  @override
  bool operator ==(Object other) {
    return other is NotificationModels && this.iD == other.iD;
  }

  @override
  int get hashCode => super.hashCode;
}
