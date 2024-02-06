class StatusCountEntity {
  int? cOMPLETE;
  int? pAYSUCCESS;
  int? wAITDELIVER;
  int? cANCEL;
  int? wAITRECEIVE;
  int? wAITPAY;
  int? wAITSENDCODE;
  int? wAITUSE;
  int? gOLDCREATEFAILED;
  int? sTABLEDATED;
  int? dRAWBILLFALIED;

  StatusCountEntity(
      {this.cOMPLETE,
        this.pAYSUCCESS,
        this.wAITDELIVER,
        this.cANCEL,
        this.wAITRECEIVE,
        this.wAITPAY,
        this.wAITSENDCODE,
        this.wAITUSE,
        this.gOLDCREATEFAILED,
        this.sTABLEDATED,
        this.dRAWBILLFALIED});

  StatusCountEntity.fromJson(Map<String, dynamic> json) {
    cOMPLETE = json['COMPLETE'];
    pAYSUCCESS = json['PAY_SUCCESS'];
    wAITDELIVER = json['WAIT_DELIVER'];
    cANCEL = json['CANCEL'];
    wAITRECEIVE = json['WAIT_RECEIVE'];
    wAITPAY = json['WAIT_PAY'];
    wAITSENDCODE = json['WAIT_SEND_CODE'];
    wAITUSE = json['WAIT_USE'];
    gOLDCREATEFAILED = json['GOLD_CREATE_FAILED'];
    sTABLEDATED = json['STABLE_DATED'];
    dRAWBILLFALIED = json['DRAW_BILL_FALIED'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPLETE'] = this.cOMPLETE;
    data['PAY_SUCCESS'] = this.pAYSUCCESS;
    data['WAIT_DELIVER'] = this.wAITDELIVER;
    data['CANCEL'] = this.cANCEL;
    data['WAIT_RECEIVE'] = this.wAITRECEIVE;
    data['WAIT_PAY'] = this.wAITPAY;
    data['WAIT_SEND_CODE'] = this.wAITSENDCODE;
    data['WAIT_USE'] = this.wAITUSE;
    data['GOLD_CREATE_FAILED'] = this.gOLDCREATEFAILED;
    data['STABLE_DATED'] = this.sTABLEDATED;
    data['DRAW_BILL_FALIED'] = this.dRAWBILLFALIED;
    return data;
  }
}
