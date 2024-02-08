import 'package:equatable/equatable.dart';

class EX {
  List<String> statusName = [
    "Pending",
    "Preparing",
    "PreparingSelfServiceFail",
    "Shipped",
    "ShippingFail",
    "Received",
    "RefundRequest",
    "RefundSuccess",
    "RefundRejected",
  ];


  ///Pending
  Map<String, dynamic> pending = {
    "orderRef": "pending",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Preparing",
        "state": "active",
        "statusDetail": [
          {
            "column1": "ผู้ขายกำลังเตรียมพัสดุ",
          },
          {
            "column1": "กรณีถ้าสินค้ามีบริการติดตั้ง\nกรุณารอเจ้าหน้าที่ติดต่อกลับ เพื่อนัดหมายวันจัดส่ง และติดตั้งสินค้า\nภายใน 24 ชม. ในวันและเวลาทำการ",
            "isHighlight": true
          },
        ]
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "statusDetail": [
          {
            "labelName": "orderRef",
            "column1": "หมายเลขอ้างอิง",
            "column2": "LA202401191444029i6hQ"
          },
          {
            "labelName": "card_number",
            "column1": "ชำระเงินโดย",
            "column2": "XXXXXXXXXXX1234",
          },
          {
            "labelName": "payment_gateway",
            "column1": "ช่องทางการชำระเงิน",
            "column2": "บัตรเครดิต/เดบิต(ผ่าน 2C2P)",
          },
          {
            "labelName": "merchant_name",
            "column1": "ผู้รับเงิน",
            "column2": "บริษัท อินโนพาวเวอร์ จำกัด",
          }
        ],
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> pendingRefundRequest = {
    "orderRef": "pendingRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundRequest", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Pending",
        "state": "active",
        "remark": "กรณีถ้าสินค้ามีบริการติดตั้ง\nกรุณารอเจ้าหน้าที่ติดต่อกลับ เพื่อนัดหมายวันจัดส่ง และติดตั้งสินค้า\nภายใน 24 ชม. ในวันและเวลาทำการ",
        "orderRef": "RE1293109248",
        "card_number": "เลขบัตร",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> pendingRefundSuccess = {
    "orderRef": "pendingRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "*การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Pending",
        "state": "active",
        "remark": "กรณีถ้าสินค้ามีบริการติดตั้ง\nกรุณารอเจ้าหน้าที่ติดต่อกลับ เพื่อนัดหมายวันจัดส่ง และติดตั้งสินค้า\nภายใน 24 ชม. ในวันและเวลาทำการ",
        "orderRef": "RE1293109248",
        "card_number": "เลขบัตร",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> pendingRefundRejected = {
    "orderRef": "pendingRefundRejected",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundRejected", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Pending",
        "state": "active",
        "remark": "กรณีถ้าสินค้ามีบริการติดตั้ง\nกรุณารอเจ้าหน้าที่ติดต่อกลับ เพื่อนัดหมายวันจัดส่ง และติดตั้งสินค้า\nภายใน 24 ชม. ในวันและเวลาทำการ",
        "orderRef": "RE1293109248",
        "card_number": "เลขบัตร",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  ///Preparing
  Map<String, dynamic> preparedDelivery = {
    "orderRef": "preparedDelivery",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท ABC",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedSelfSuccess = {
    "orderRef": "preparedSelfSuccess",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedSelfFailed = {
    "orderRef": "preparedSelfFailed",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_failed",
          "remark": "เจ้าหน้าที่ไม่สามารถติดต่อคุณได้ หรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedDeliveryRefundRequest = {
    "orderRef": "preparedDeliveryRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท ABC",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedDeliveryRefundSuccess = {
    "orderRef": "preparedDeliveryRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท ABC",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedDeliveryRefundRejected = {
    "orderRef": "preparedDeliveryRefundRejected",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundRejected", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท ABC",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedSelfSuccessRefundRequest = {
    "orderRef": "preparedSelfSuccessRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedSelfSuccessRefundSuccess = {
    "orderRef": "preparedSelfSuccessRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedSelfSuccessRefundReject = {
    "orderRef": "preparedSelfSuccessRefundReject",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundReject", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedSelfFailedRefundRequest = {
    "orderRef": "preparedSelfFailedRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_failed",
          "remark": "เจ้าหน้าที่ไม่สามารถติดต่อคุณได้ หรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedSelfFailedRefundSuccess = {
    "orderRef": "preparedSelfFailedRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_failed",
          "remark": "เจ้าหน้าที่ไม่สามารถติดต่อคุณได้ หรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> preparedSelfFailedRefundReject = {
    "orderRef": "preparingSelfFailed",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundReject", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_failed",
          "remark": "เจ้าหน้าที่ไม่สามารถติดต่อคุณได้ หรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  ///Shipped
  Map<String, dynamic> shippedDelivery = {
    "orderRef": "shippedDelivery",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping",
          "remark": "สินค้าอยู่ระหว่างการจัดส่ง"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedSelf = {
    "orderRef": "shippedSelf",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryRefundRequest = {
    "orderRef": "shippedDeliveryRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryRefundSuccess = {
    "orderRef": "shippedDeliveryRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryRefundReject = {
    "orderRef": "shippedDeliveryRefundReject",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundReject",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedSelfRefundRequest = {
    "orderRef": "shippedSelfRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedSelfRefundSuccess = {
    "orderRef": "shippedSelfRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedSelfRefundReject = {
    "orderRef": "shippedSelfRefundReject",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundReject", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryFail = {
    "orderRef": "shippedDelivery",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "shipping_status": "Shipping Failed",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedSelfFailed = {
    "orderRef": "shippedSelf",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
          "sub_status": "Shipping Failed"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryFailedRefundRequest = {
    "orderRef": "shippedDeliveryFailedRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "shipping_status": "Shipping Failed",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryFailedRefundSuccess = {
    "orderRef": "shippedDeliveryFailedRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "shipping_status": "Shipping Failed",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryFailedRefundReject = {
    "orderRef": "shippedDeliveryFailedRefundReject",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundReject", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "shipping_status": "Shipping Failed",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedSelfFailedRefundRequest = {
    "orderRef": "shippedSelfFailedRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Refund",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
          "sub_status": "Shipping Failed"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedSelfFailedRefundSuccess = {
    "orderRef": "shippedSelfFailedRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
          "sub_status": "Shipping Failed"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> shippedSelfFailedRefundReject = {
    "orderRef": "shippedSelfFailedRefundReject",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundReject", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
          "sub_status": "Shipping Failed"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  ///Received
  Map<String, dynamic> receivedDelivery = {
    "orderRef": "shippedDelivery",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "service_type": "delivery",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "statusName": "Shipped",
        "state": "inactive",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> receivedDeliveryRefundRequest = {
    "orderRef": "receivedDeliveryRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "service_type": "delivery",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "statusName": "Shipped",
        "state": "inactive",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> receivedDeliveryRefundSuccess = {
    "orderRef": "receivedDeliveryRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "service_type": "delivery",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "statusName": "Shipped",
        "state": "inactive",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> receivedDeliveryRefundReject = {
    "orderRef": "receivedDeliveryRefundReject",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundReject", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "service_type": "delivery",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "statusName": "Shipped",
        "state": "inactive",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> receivedSelf = {
    "orderRef": "shippedSelf",
    "refundDay": 7,
    "refundable": true,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "service_type": "self",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "statusName": "Shipped",
        "state": "inactive",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> receivedSelfRefundRequest = {
    "orderRef": "receivedSelfRefundRequest",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "service_type": "self",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "statusName": "Shipped",
        "state": "inactive",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> receivedSelfRefundSuccess = {
    "orderRef": "receivedSelfRefundSuccess",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {
        "statusName": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      },
      {
        "statusName": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "service_type": "self",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "statusName": "Shipped",
        "state": "inactive",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  Map<String, dynamic> receivedSelfRefundReject = {
    "orderRef": "receivedSelfRefundReject",
    "refundDay": 7,
    "refundable": false,
    "orderCreateDateTime": "datetime",
    "status": [
      {"statusName": "RefundReject", "statusDateTime": "8 ธันวาคม 2566 15:30"},
      {
        "statusName": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "service_type": "self",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "statusName": "Shipped",
        "state": "inactive",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "statusDateTime": "8 ธันวาคม 2566 15:30",
      },
      {
        "statusName": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "statusDateTime": "8 ธันวาคม 2566 15:30",
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "statusName": "Pending",
        "state": "inactive",
        "orderRef": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "statusDateTime": "8 ธันวาคม 2566 15:30"
      }
    ]
  };

  TrackingModel get pendingMock => TrackingModel.fromJson(pending);
  TrackingModel get pendingRefundRequestMock => TrackingModel.fromJson(pendingRefundRequest);
  TrackingModel get pendingRefundSuccessMock => TrackingModel.fromJson(pendingRefundSuccess);
  TrackingModel get pendingRefundRejectedMock => TrackingModel.fromJson(pendingRefundRejected);
  TrackingModel get preparedDeliveryMock => TrackingModel.fromJson(preparedDelivery);
  TrackingModel get preparedSelfSuccessMock => TrackingModel.fromJson(preparedSelfSuccess);
  TrackingModel get preparedSelfFailedMock => TrackingModel.fromJson(preparedSelfFailed);
  TrackingModel get preparedDeliveryRefundRequestMock => TrackingModel.fromJson(preparedDeliveryRefundRequest);
  TrackingModel get preparedDeliveryRefundSuccessMock => TrackingModel.fromJson(preparedDeliveryRefundSuccess);
  TrackingModel get preparedDeliveryRefundRejectedMock => TrackingModel.fromJson(preparedDeliveryRefundRejected);
  TrackingModel get preparedSelfSuccessRefundRequestMock => TrackingModel.fromJson(preparedSelfSuccessRefundRequest);
  TrackingModel get preparedSelfSuccessRefundSuccessMock => TrackingModel.fromJson(preparedSelfSuccessRefundSuccess);
  TrackingModel get preparedSelfSuccessRefundRejectMock => TrackingModel.fromJson(preparedSelfSuccessRefundReject);
  TrackingModel get preparedSelfFailedRefundRequestMock => TrackingModel.fromJson(preparedSelfFailedRefundRequest);
  TrackingModel get preparedSelfFailedRefundSuccessMock => TrackingModel.fromJson(preparedSelfFailedRefundSuccess);
  TrackingModel get preparedSelfFailedRefundRejectMock => TrackingModel.fromJson(preparedSelfFailedRefundReject);
  TrackingModel get shippedDeliveryMock => TrackingModel.fromJson(shippedDelivery);
  TrackingModel get shippedSelfMock => TrackingModel.fromJson(shippedSelf);
  TrackingModel get shippedDeliveryRefundRequestMock => TrackingModel.fromJson(shippedDeliveryRefundRequest);
  TrackingModel get shippedDeliveryRefundSuccessMock => TrackingModel.fromJson(shippedDeliveryRefundSuccess);
  TrackingModel get shippedDeliveryRefundRejectMock => TrackingModel.fromJson(shippedDeliveryRefundReject);
  TrackingModel get shippedSelfRefundRequestMock => TrackingModel.fromJson(shippedSelfRefundRequest);
  TrackingModel get shippedSelfRefundSuccessMock => TrackingModel.fromJson(shippedSelfRefundSuccess);
  TrackingModel get shippedSelfRefundRejectMock => TrackingModel.fromJson(shippedSelfRefundReject);
  TrackingModel get shippedDeliveryFailMock => TrackingModel.fromJson(shippedDeliveryFail);
  TrackingModel get shippedSelfFailedMock => TrackingModel.fromJson(shippedSelfFailed);
  TrackingModel get shippedDeliveryFailedRefundRequestMock => TrackingModel.fromJson(shippedDeliveryFailedRefundRequest);
  TrackingModel get shippedDeliveryFailedRefundSuccessMock => TrackingModel.fromJson(shippedDeliveryFailedRefundSuccess);
  TrackingModel get shippedDeliveryFailedRefundRejectMock => TrackingModel.fromJson(shippedDeliveryFailedRefundReject);
  TrackingModel get shippedSelfFailedRefundRequestMock => TrackingModel.fromJson(shippedSelfFailedRefundRequest);
  TrackingModel get shippedSelfFailedRefundSuccessMock => TrackingModel.fromJson(shippedSelfFailedRefundSuccess);
  TrackingModel get shippedSelfFailedRefundRejectMock => TrackingModel.fromJson(shippedSelfFailedRefundReject);
  TrackingModel get receivedDeliveryMock => TrackingModel.fromJson(receivedDelivery);
  TrackingModel get receivedDeliveryRefundRequestMock => TrackingModel.fromJson(receivedDeliveryRefundRequest);
  TrackingModel get receivedDeliveryRefundSuccessMock => TrackingModel.fromJson(receivedDeliveryRefundSuccess);
  TrackingModel get receivedDeliveryRefundRejectMock => TrackingModel.fromJson(receivedDeliveryRefundReject);
  TrackingModel get receivedSelfMock => TrackingModel.fromJson(receivedSelf);
  TrackingModel get receivedSelfRefundRequestMock => TrackingModel.fromJson(receivedSelfRefundRequest);
  TrackingModel get receivedSelfRefundSuccessMock => TrackingModel.fromJson(receivedSelfRefundSuccess);
  TrackingModel get receivedSelfRefundRejectMock => TrackingModel.fromJson(receivedSelfRefundReject);
}

extension StatusNameX on String {
  bool get isPending => this == "Pending";
  bool get isPreparing => this == "Preparing";
  bool get isPreparingSelfServiceFail => this == "PreparingSelfServiceFail";
  bool get isShipped => this == "Shipped";
  bool get isShippingFail => this == "ShippingFail";
  bool get isReceived => this == "Received";
  bool get isRefundRequest => this == "RefundRequest";
  bool get isRefundSuccess => this == "RefundSuccess";
  bool get isRefundRejected => this == "RefundRejected";
}

extension StateX on String {
  bool get isActive => this == "active";
}

class TrackingModel extends Equatable {
  final String orderRef;
  final int refundDay;
  final bool refundable;
  final String orderCreateDate;
  final List<Status> status;

  const TrackingModel({required this.orderRef,required this.refundDay, required this.refundable, required this.orderCreateDate, required this.status});

  static const empty = TrackingModel(orderRef: "", refundDay: 0, refundable: false, orderCreateDate: "", status: []);

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    var status = json['status'] != null ? json['status'].map<Status>((e) => Status.fromJson(e)).toList() : [];
    return TrackingModel(
        orderRef: json['orderRef'] ?? '',
        refundDay: json['refundDay'] ?? 0,
        refundable: json['refundable'] ?? false,
        orderCreateDate: json['orderCreateDateTime'] ?? "",
        status: status
    );
  }

  @override
  List<Object?> get props => [orderRef, refundDay, refundable, orderCreateDate, status];
}

class Status extends Equatable {
  final String statusName;
  final String state;
  final String statusDateTime;
  final String serviceType;
  final List<StatusDetail> details;
  final List<StatusDetail> paymentDetails;

  const Status(
      {required this.statusName,
      required this.state,
      required this.statusDateTime,
      required this.serviceType,
      required this.details,
      required this.paymentDetails});

  static const empty = Status(
      statusName: "",
      state: "",
      statusDateTime: "",
      serviceType: "",
      details: [],
      paymentDetails: []
  );

  factory Status.fromJson(Map<String, dynamic> json) {
    List<StatusDetail> details = json['statusDetail'] != null ? json['statusDetail'].map<StatusDetail>((json) => StatusDetail.fromJson(json)).toList() : [];
    List<StatusDetail> paymentDetails = json['paymentDetail'] != null ? json['paymentDetail'].map<StatusDetail>((json) => StatusDetail.fromJson(json)).toList() : [];
    return Status(
      statusName: json['statusName'] ?? "",
      state: json['state'] ?? "",
      statusDateTime: json['statusDateTime'] ?? "",
      serviceType: json['serviceType'] ?? "",
      details: details,
      paymentDetails: paymentDetails
    );
  }

  @override
  List<Object?> get props => [
        statusName,
        state,
        statusDateTime,
        serviceType,
        details,
        paymentDetails
      ];
}

class StatusDetail extends Equatable {
  final String labelName;
  final String column1;
  final String column2;
  final bool isCopyButton;
  final bool isHighlight;

  const StatusDetail(
      {required this.labelName,
      required this.column1,
      required this.column2,
      required this.isCopyButton,
      required this.isHighlight});

  static const empty =
  StatusDetail(labelName: "", column1: "", column2: "", isCopyButton: false, isHighlight: false);

  factory StatusDetail.fromJson(Map<String, dynamic> json) {
    return StatusDetail(
      labelName: json['labelName'] ?? "",
      column1: json['column1'] ?? "",
      column2: json['column2'] ?? "",
      isCopyButton: json['isCopyButton'] ?? false,
      isHighlight: json['isHighlight'] ?? false
    );
  }

  @override
  List<Object?> get props => [labelName,
    column1,
    column2,
    isCopyButton,
    isHighlight];
}
