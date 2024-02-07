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
    "order_ref": "pending",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Pending",
        "state": "active",
        "remark": "กรณีถ้าสินค้ามีบริการติดตั้ง\nกรุณารอเจ้าหน้าที่ติดต่อกลับ เพื่อนัดหมายวันจัดส่ง และติดตั้งสินค้า\nภายใน 24 ชม. ในวันและเวลาทำการ",
        "order_ref": "RE1293109248",
        "card_number": "เลขบัตร",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> pendingRefundRequest = {
    "order_ref": "pendingRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundRequest", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Pending",
        "state": "active",
        "remark": "กรณีถ้าสินค้ามีบริการติดตั้ง\nกรุณารอเจ้าหน้าที่ติดต่อกลับ เพื่อนัดหมายวันจัดส่ง และติดตั้งสินค้า\nภายใน 24 ชม. ในวันและเวลาทำการ",
        "order_ref": "RE1293109248",
        "card_number": "เลขบัตร",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> pendingRefundSuccess = {
    "order_ref": "pendingRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "*การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Pending",
        "state": "active",
        "remark": "กรณีถ้าสินค้ามีบริการติดตั้ง\nกรุณารอเจ้าหน้าที่ติดต่อกลับ เพื่อนัดหมายวันจัดส่ง และติดตั้งสินค้า\nภายใน 24 ชม. ในวันและเวลาทำการ",
        "order_ref": "RE1293109248",
        "card_number": "เลขบัตร",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> pendingRefundRejected = {
    "order_ref": "pendingRefundRejected",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundRejected", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Pending",
        "state": "active",
        "remark": "กรณีถ้าสินค้ามีบริการติดตั้ง\nกรุณารอเจ้าหน้าที่ติดต่อกลับ เพื่อนัดหมายวันจัดส่ง และติดตั้งสินค้า\nภายใน 24 ชม. ในวันและเวลาทำการ",
        "order_ref": "RE1293109248",
        "card_number": "เลขบัตร",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      }
    ]
  };

  ///Preparing
  Map<String, dynamic> preparedDelivery = {
    "order_ref": "preparedDelivery",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(hours: 2)).toUtc().toString(),
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท ABC",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedSelfSuccess = {
    "order_ref": "preparedSelfSuccess",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedSelfFailed = {
    "order_ref": "preparedSelfFailed",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_failed",
          "remark": "เจ้าหน้าที่ไม่สามารถติดต่อคุณได้ หรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedDeliveryRefundRequest = {
    "order_ref": "preparedDeliveryRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท ABC",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedDeliveryRefundSuccess = {
    "order_ref": "preparedDeliveryRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท ABC",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedDeliveryRefundRejected = {
    "order_ref": "preparedDeliveryRefundRejected",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundRejected", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท ABC",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedSelfSuccessRefundRequest = {
    "order_ref": "preparedSelfSuccessRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedSelfSuccessRefundSuccess = {
    "order_ref": "preparedSelfSuccessRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedSelfSuccessRefundReject = {
    "order_ref": "preparedSelfSuccessRefundReject",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundReject", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedSelfFailedRefundRequest = {
    "order_ref": "preparedSelfFailedRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_failed",
          "remark": "เจ้าหน้าที่ไม่สามารถติดต่อคุณได้ หรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedSelfFailedRefundSuccess = {
    "order_ref": "preparedSelfFailedRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_failed",
          "remark": "เจ้าหน้าที่ไม่สามารถติดต่อคุณได้ หรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> preparedSelfFailedRefundReject = {
    "order_ref": "preparingSelfFailed",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundReject", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Preparing/Packed",
        "state": "active",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_failed",
          "remark": "เจ้าหน้าที่ไม่สามารถติดต่อคุณได้ หรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  ///Shipped
  Map<String, dynamic> shippedDelivery = {
    "order_ref": "shippedDelivery",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping",
          "remark": "สินค้าอยู่ระหว่างการจัดส่ง"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedSelf = {
    "order_ref": "shippedSelf",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryRefundRequest = {
    "order_ref": "shippedDeliveryRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString(),
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryRefundSuccess = {
    "order_ref": "shippedDeliveryRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString(),
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryRefundReject = {
    "order_ref": "shippedDeliveryRefundReject",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundReject",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString(),
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedSelfRefundRequest = {
    "order_ref": "shippedSelfRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 3)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedSelfRefundSuccess = {
    "order_ref": "shippedSelfRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 3)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedSelfRefundReject = {
    "order_ref": "shippedSelfRefundReject",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundReject", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 3)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryFail = {
    "order_ref": "shippedDelivery",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Shipped",
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
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString(),
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedSelfFailed = {
    "order_ref": "shippedSelf",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
          "sub_status": "Shipping Failed"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 3)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryFailedRefundRequest = {
    "order_ref": "shippedDeliveryFailedRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Shipped",
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
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString(),
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryFailedRefundSuccess = {
    "order_ref": "shippedDeliveryFailedRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Shipped",
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
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString(),
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedDeliveryFailedRefundReject = {
    "order_ref": "shippedDeliveryFailedRefundReject",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundReject", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Shipped",
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
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString(),
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedSelfFailedRefundRequest = {
    "order_ref": "shippedSelfFailedRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Refund",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
          "sub_status": "Shipping Failed"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 3)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedSelfFailedRefundSuccess = {
    "order_ref": "shippedSelfFailedRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
          "sub_status": "Shipping Failed"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 3)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> shippedSelfFailedRefundReject = {
    "order_ref": "shippedSelfFailedRefundReject",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundReject", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Shipped",
        "state": "active",
        "service_type": "self",
        "self_service": {
          "remark": "จัดส่งไม่สำเร็จ กรุณาติดต่อกลับ",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
          "sub_status": "Shipping Failed"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 3)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 4)).toUtc().toString()
      }
    ]
  };

  ///Received
  Map<String, dynamic> receivedDelivery = {
    "order_ref": "shippedDelivery",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "status_date_time": DateTime.now().subtract(Duration(hours: 1)).toUtc().toString(),
        "service_type": "delivery",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "status_name": "Shipped",
        "state": "inactive",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "delivery_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> receivedDeliveryRefundRequest = {
    "order_ref": "receivedDeliveryRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "status_date_time": DateTime.now().subtract(Duration(hours: 1)).toUtc().toString(),
        "service_type": "delivery",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "status_name": "Shipped",
        "state": "inactive",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> receivedDeliveryRefundSuccess = {
    "order_ref": "receivedDeliveryRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "status_date_time": DateTime.now().subtract(Duration(hours: 1)).toUtc().toString(),
        "service_type": "delivery",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "status_name": "Shipped",
        "state": "inactive",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> receivedDeliveryRefundReject = {
    "order_ref": "receivedDeliveryRefundReject",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundReject", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "status_date_time": DateTime.now().subtract(Duration(hours: 1)).toUtc().toString(),
        "service_type": "delivery",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "status_name": "Shipped",
        "state": "inactive",
        "service_type": "delivery",
        "delivery_service": {
          "courier": "J&T Express",
          "tracking_number": "A3143423432",
          "tracking_url": "",
          "shipping_status": "Shipping / Re-shipping"
        },
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "delivery",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString(),
        "delivery_service": {"remark": "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้ว"}
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 3)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> receivedSelf = {
    "order_ref": "shippedSelf",
    "refund_day": 7,
    "refundable": true,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "status_date_time": DateTime.now().subtract(Duration(hours: 1)).toUtc().toString(),
        "service_type": "self",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "status_name": "Shipped",
        "state": "inactive",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> receivedSelfRefundRequest = {
    "order_ref": "receivedSelfRefundRequest",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundRequest",
        "remark": "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "status_date_time": DateTime.now().subtract(Duration(hours: 1)).toUtc().toString(),
        "service_type": "self",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "status_name": "Shipped",
        "state": "inactive",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> receivedSelfRefundSuccess = {
    "order_ref": "receivedSelfRefundSuccess",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {
        "status_name": "RefundSuccess",
        "remark": "การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()
      },
      {
        "status_name": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "status_date_time": DateTime.now().subtract(Duration(hours: 1)).toUtc().toString(),
        "service_type": "self",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "status_name": "Shipped",
        "state": "inactive",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
      }
    ]
  };

  Map<String, dynamic> receivedSelfRefundReject = {
    "order_ref": "receivedSelfRefundReject",
    "refund_day": 7,
    "refundable": false,
    "order_create_datetime": "datetime",
    "status": [
      {"status_name": "RefundReject", "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString()},
      {
        "status_name": "Received",
        "state": "active",
        "remark": "สินค้าถูกจัดส่งสำเร็จแล้ว",
        "status_date_time": DateTime.now().subtract(Duration(hours: 1)).toUtc().toString(),
        "service_type": "self",
        "merchant_number": "0812345678",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
      },
      {
        "status_name": "Shipped",
        "state": "inactive",
        "service_type": "self",
        "self_service": {"remark": "สินค้าอยู่ระหว่างการจัดส่ง", "merchant_number": "0812345678", "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"},
        "status_date_time": DateTime.now().subtract(Duration(days: 1)).toUtc().toString(),
      },
      {
        "status_name": "Preparing/Packed",
        "state": "inactive",
        "service_type": "self",
        "status_date_time": DateTime.now().subtract(Duration(hours: 2)).toUtc().toString(),
        "self_service": {
          "sub_status": "contact_success",
          "remark": "ยืนยันเวลาจัดส่งสำเร็จกรุณารอรับสินค้าตามเวลานัดหมาย",
          "merchant_number": "0812345678",
          "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด"
        }
      },
      {
        "status_name": "Pending",
        "state": "inactive",
        "order_ref": "RE1293109248",
        "card_number": "XXX1234",
        "payment_gateway": "2C2P",
        "merchant_name": "บริษัท อินโนพาวเวอร์ จำกัด",
        "status_date_time": DateTime.now().subtract(Duration(days: 2)).toUtc().toString()
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

extension XtrackingStatus on String {
  bool get isPending => this == "Pending";
  bool get isPreparing => this == "Preparing";
  bool get isShipped => this == "Shipped";
  bool get isReceived => this == "Received";
  bool get isRefund => this == "Refund";
}

extension ServiceTypeX on String {
  bool get isDelivery => this == "delivery";
  bool get isSelf => this == "self";
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
        orderRef: json['order_ref'] ?? '',
        refundDay: json['refund_day'] ?? 0,
        refundable: json['refundable'] ?? false,
        orderCreateDate: json['order_create_datetime'] ?? "",
        status: status
    );
  }

  @override
  List<Object?> get props => [orderRef, refundDay, refundable, orderCreateDate, status];
}

class Status extends Equatable {
  final String statusName;
  final String state;
  final String remark;
  final String statusDateTime;
  final String serviceType;
  final String merchantNumber;
  final String merchantName;
  final Service deliveryService;
  final Service selfService;
  final String orderRef;

  const Status(
      {required this.statusName,
      required this.state,
      required this.remark,
      required this.statusDateTime,
      required this.serviceType,
      required this.merchantNumber,
      required this.merchantName,
      required this.deliveryService,
      required this.selfService,
      required this.orderRef});

  static const empty = Status(
      statusName: "",
      state: "",
      remark: "",
      statusDateTime: "",
      serviceType: "",
      merchantNumber: "",
      merchantName: "",
      deliveryService: Service.empty,
      selfService: Service.empty,
      orderRef: "");

  factory Status.fromJson(Map<String, dynamic> json) {
    Service delivery = json['delivery_service'] != null ? Service.fromJson(json['delivery_service']) : Service.empty;
    Service self = json['self_service'] != null ? Service.fromJson(json['self_service']) : Service.empty;

    return Status(
      statusName: json['status_name'] ?? "",
      state: json['state'] ?? "",
      remark: json['remark'] ?? "",
      statusDateTime: json['status_date_time'] ?? "",
      serviceType: json['service_type'] ?? "",
      merchantNumber: json['merchant_number'] ?? "",
      merchantName: json['merchant_name'] ?? "",
      deliveryService: delivery,
      selfService: self,
      orderRef: json['order_ref'] ?? "",
    );
  }

  @override
  List<Object?> get props => [
        statusName,
        state,
        remark,
        statusDateTime,
        serviceType,
        merchantNumber,
        merchantName,
        deliveryService,
        selfService,
        orderRef,
      ];
}

class Service extends Equatable {
  final String courier;
  final String trackingNumber;
  final String trackingUrl;
  final String shippingStatus;
  final String remark;
  final String merchantNumber;
  final String merchantName;
  final String subStatus;

  const Service(
      {required this.courier,
      required this.trackingNumber,
      required this.trackingUrl,
      required this.shippingStatus,
      required this.remark,
      required this.merchantNumber,
      required this.merchantName,
      required this.subStatus});

  static const empty =
      Service(courier: "", trackingNumber: "", trackingUrl: "", shippingStatus: "", remark: "", merchantNumber: "", merchantName: "", subStatus: "");

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      courier: json['courier'] ?? "",
      trackingNumber: json['tracking_number'] ?? "",
      trackingUrl: json['tracking_url'] ?? "",
      shippingStatus: json['shipping_status'] ?? "",
      remark: json['remark'] ?? "",
      merchantNumber: json['merchant_number'] ?? "",
      merchantName: json['merchant_name'] ?? "",
      subStatus: json['sub_status'] ?? "",
    );
  }

  @override
  List<Object?> get props => [courier, trackingNumber, trackingUrl, shippingStatus, remark, merchantNumber, merchantName, subStatus];
}
