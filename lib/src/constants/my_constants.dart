const titleWebPage = 'วอลชาร์จรถไฟฟ้า | กรุงศรี ออโต้';
const fontFamily = "Krungsri Condensed";
const carouselShowLimit = 3;

class HomeConst {
  String imageTopSecPath = 'assets/homepage/krungsri-auto-logo-2.20f3516 1.png';
  String titleTopSec = 'วอลชาร์จรถไฟฟ้า';
  String bannerImagePath = 'assets/homepage/banner.png';

  String lineOAURL = 'https://line.me/R/ti/p/@018qbfet';
  String termsAndConditions = 'ข้อกำหนดและเงื่อนไข';
  String privacyPolicy = 'นโยบายความเป็นส่วนตัว';
  String askInformation = 'สอบถามข้อมูลอื่นๆ เกี่ยวกับสินค้า หรือ ติดตามสถานะการจัดส่งสินค้า';
  String pleaseContact = 'กรุณาติดต่อ  081-123-4567';
  String warningWord = 'ข้อมูลนี้เป็นข้อมูลจากผู้ให้บริการ อาจมีการเปลี่ยนแปลงได้ตลอดเวลา';
}

class ErrorConst {
  // network/server
  String titleNS = 'ขออภัยไม่สามารถทำรายการได้ในขณะนี้';
  String subTitleNS = 'กรุณากด “ลองอีกครั้ง” เพื่อโหลดใหม่';
  String titleBtnNS = 'ลองอีกครั้ง';

  String titleBrowser = 'ขออภัยไม่รองรับการให้บริการบน บราวเซอร์นี้ี้';
  String subTitleBrowser = 'กรุณากด “เปิดไลน์” เพื่อใช้บริการ';
  String titleBtnBrowser = 'เปิดไลน์';

  String imagePath = "assets/images/404_error.png";
}

class ProductDetailConst {
  String imgDefaultPath = "assets/homepage/img_default.png";
  String imgHeroBannerPath = "assets/homepage/HeroBanner.png";
}

class LoaderConst {
  // Loader
  String iconLoading = 'assets/images/icon_loading.png';
}

const acceptButtonTH = "ตกลง";
const cancelButtonTH = "ยกเลิก";

const paymentTextTH = "กรุณากด ”ยืนยัน” เพื่อทำการชำระเงิน";

// assets data
const List assetsCarouselItem = [
  "assets/homepage/HeroBanner.png"
  // "assets/homepage/banner.png",
];

const carouselOver20Item = [
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
  "https://images.unsplash.com/photo-1558637845-c8b7ead71a3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80",
  "https://images.unsplash.com/photo-1594568284297-7c64464062b1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1626593261859-4fe4865d8cb1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1559511331-6a3a4e72f588?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2147&q=80",
  "https://images.unsplash.com/photo-1604278666650-0f3eab3c6644?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1931&q=80",
  "https://images.unsplash.com/photo-1567196884944-1b4b8f630560?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80",
  "https://images.unsplash.com/photo-1595835018349-198460e1d309?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1931&q=80",
  "https://images.unsplash.com/photo-1558637845-c8b7ead71a3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80",
  "https://images.unsplash.com/photo-1594568284297-7c64464062b1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1626593261859-4fe4865d8cb1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1559511331-6a3a4e72f588?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2147&q=80",
  "https://images.unsplash.com/photo-1604278666650-0f3eab3c6644?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1931&q=80",
  "https://images.unsplash.com/photo-1558637845-c8b7ead71a3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80",
  "https://images.unsplash.com/photo-1594568284297-7c64464062b1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1626593261859-4fe4865d8cb1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1559511331-6a3a4e72f588?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2147&q=80",
  "https://images.unsplash.com/photo-1604278666650-0f3eab3c6644?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1931&q=80",
  "https://images.unsplash.com/photo-1558637845-c8b7ead71a3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80",
  "https://images.unsplash.com/photo-1594568284297-7c64464062b1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1626593261859-4fe4865d8cb1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1559511331-6a3a4e72f588?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2147&q=80",
  "https://images.unsplash.com/photo-1604278666650-0f3eab3c6644?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1931&q=80",
  "https://images.unsplash.com/photo-1558637845-c8b7ead71a3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80",
  "https://images.unsplash.com/photo-1594568284297-7c64464062b1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1626593261859-4fe4865d8cb1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  "https://images.unsplash.com/photo-1559511331-6a3a4e72f588?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2147&q=80",
  "https://images.unsplash.com/photo-1604278666650-0f3eab3c6644?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1931&q=80",
];
const carouselSingleItem = [
 "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
]; 
const carouselTripleItem = [
  "https://images.unsplash.com/photo-1604278666650-0f3eab3c6644?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1931&q=80",
  "https://images.unsplash.com/photo-1567196884944-1b4b8f630560?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80",
  "https://images.unsplash.com/photo-1595835018349-198460e1d309?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1931&q=80",
  "https://images.unsplash.com/photo-1567196884944-1b4b8f630560?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80",
];
