import 'dart:convert';

class CheckResponseWrapper {
  String? eroName;
  String? eroPhone;
  String? avgUnits;
  String? sectionName;
  String? sectionPhone;
  String? area;
  String? cat;
  String? circle;
  String? erono;
  String? errorCause;
  String? load;
  String? name;
  String? scno;
  String? status;
  String? uscno;
  Bill? bill;
  String? serialNo;
  String? areaCode;
  String? ebs2DigitSecCode;
  String? kvahClosingReading;
  String? kwhClosingReading;
  String? mobile;
  String? poleNo;
  String? subCat;
  String? trivectorFlag;
  String? aadharNo;
  String? rationNo;
  String? prajaPalanaApplicationNo;

  CheckResponseWrapper({
    this.eroName,
    this.eroPhone,
    this.avgUnits,
    this.sectionName,
    this.sectionPhone,
    this.area,
    this.cat,
    this.circle,
    this.erono,
    this.errorCause,
    this.load,
    this.name,
    this.scno,
    this.status,
    this.uscno,
    this.bill,
    this.serialNo,
    this.areaCode,
    this.ebs2DigitSecCode,
    this.kvahClosingReading,
    this.kwhClosingReading,
    this.mobile,
    this.poleNo,
    this.subCat,
    this.trivectorFlag,
    this.aadharNo,
    this.rationNo,
    this.prajaPalanaApplicationNo,
  });

  // Factory method to create a CheckResponseWrapper from a JSON object
  factory CheckResponseWrapper.fromJson(Map<String, dynamic> json) {
    return CheckResponseWrapper(
      eroName: json['eroName'],
      eroPhone: json['eroPhone'],
      avgUnits: json['avgUnits'],
      sectionName: json['sectionName'],
      sectionPhone: json['sectionPhone'],
      area: json['area'],
      cat: json['cat'],
      circle: json['circle'],
      erono: json['erono'],
      errorCause: json['errorCause'],
      load: json['load'],
      name: json['name'],
      scno: json['scno'],
      status: json['status'],
      uscno: json['uscno'],
      bill: json['bill'] != null ? Bill.fromJson(json['bill']) : null,
      serialNo: json['serialNo'],
      areaCode: json['areaCode'],
      ebs2DigitSecCode: json['ebs2DigitSecCode'],
      kvahClosingReading: json['kvahClosingReading'],
      kwhClosingReading: json['kwhClosingReading'],
      mobile: json['mobile'],
      poleNo: json['poleNo'],
      subCat: json['subCat'],
      trivectorFlag: json['trivectorFlag'],
      aadharNo: json['aadharNo'],
      rationNo: json['rationNo'],
      prajaPalanaApplicationNo: json['prajaPalanaApplicationNo'],
    );
  }

  // Method to convert CheckResponseWrapper object to JSON
  Map<String, dynamic> toJson() {
    return {
      'eroName': eroName,
      'eroPhone': eroPhone,
      'avgUnits': avgUnits,
      'sectionName': sectionName,
      'sectionPhone': sectionPhone,
      'area': area,
      'cat': cat,
      'circle': circle,
      'erono': erono,
      'errorCause': errorCause,
      'load': load,
      'name': name,
      'scno': scno,
      'status': status,
      'uscno': uscno,
      'bill': bill?.toJson(),
      'serialNo': serialNo,
      'areaCode': areaCode,
      'ebs2DigitSecCode': ebs2DigitSecCode,
      'kvahClosingReading': kvahClosingReading,
      'kwhClosingReading': kwhClosingReading,
      'mobile': mobile,
      'poleNo': poleNo,
      'subCat': subCat,
      'trivectorFlag': trivectorFlag,
      'aadharNo': aadharNo,
      'rationNo': rationNo,
      'prajaPalanaApplicationNo': prajaPalanaApplicationNo,
    };
  }
}

// Bill class that may exist within CheckResponseWrapper
class Bill {
  // Define the fields based on your server response for Bill
  String? billNo;

  Bill({
    this.billNo,
  });

  // Factory method to create a Bill from a JSON object
  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      billNo: json['billNo'],
    );
  }

  // Method to convert Bill object to JSON
  Map<String, dynamic> toJson() {
    return {
      'billNo': billNo,
    };
  }
}
