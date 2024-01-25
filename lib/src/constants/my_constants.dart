const titleWebPage = 'วอลชาร์จรถไฟฟ้า | กรุงศรี ออโต้';
const fontFamily = "Krungsri Condensed";
const carouselShowLimit = 3;

class HomeConst {
  String imageTopSecPath = 'assets/homepage/krungsri-auto-logo-2.20f3516 1.png';
  String titleTopSec = 'PromptBuy';
  String bannerImagePath = 'assets/homepage/banner.png';

  String lineOAURL = 'https://line.me/R/ti/p/@018qbfet';
  String termsAndConditions = 'ข้อตกลงและเงื่อนไข';
  String privacyPolicy = 'ประกาศความคุ้มครองข้อมูลส่วนบุคคล';
  String askInformation = 'สอบถามข้อมูลอื่นๆ เกี่ยวกับสินค้า หรือ ติดตามสถานะการจัดส่งสินค้า';
  String pleaseContact = 'กรุณาติดต่อ  02-023-8858';
  String warningWord = 'ข้อมูลนี้เป็นข้อมูลจากผู้ให้บริการ อาจมีการเปลี่ยนแปลงได้ตลอดเวลา';
}

class ErrorConst {
  // network/server
  String titleNS = 'ขออภัย';
  String subTitleNS = 'ขณะนี้ไม่สามารถทำรายการได้';
  String titleBtnNS = 'ลองอีกครั้ง';

  String titleBrowser = 'ขออภัย';
  String subTitleBrowser = 'ไม่รองรับการใช้งานบนเบราว์เซอร์นี้';
  String subTitleSecBrowser = 'ระบบจะทำการกลับไปที่ LINE เพื่อดำเนินการต่อไป';
  String titleBtnBrowser = 'ตกลง';

  String imagePath = "assets/images/404_error.png";
}

class ProductDetailConst {
  String imgDefaultPath = "assets/homepage/img_default.png";
  String imgHeroBannerPath = "assets/homepage/HeroBanner.png";

  String htmlExampleBullet = '''
<strong>✅Installation Package</strong>
<ul>
<li> ฟรี เดินสายไฟ ระยะ 20 เมตร / ท่อ uPVC ขาว 3/4″-1″ / เบรกเกอร์ 40A /</li>
<li> อุปกรณ์กันไฟดูด RCD Type A/ Plastic CB Box</li>
<li> อุปกรณ์กันไฟดูด RCD Type A/ Plastic CB Box</li>
<li> อุปกรณ์กันไฟดูด RCD Type A/ Plastic CB Box</li>
</ul>
<strong>– ฟรี รับประกันสินค้า 3 ปี (หากเครื่องมีปัญหา จะเปลี่ยนเป็นเครื่องใหม่)</strong>
''';
  String htmlTag = '''
|column1|column2|
|-|-|-|
|Model|Pulsar MAX|
|Cable Length|5 metres (7 metres optional)|
''';
  String testData = '''<strong>Installation Package</strong>
<p>– ฟรี เดินสายไฟ ระยะ 20 เมตร / ท่อ uPVC ขาว 3/4″-1″ / เบรกเกอร์ 40A /</p>
<br><br>
<strong>อุปกรณ์กันไฟดูด RCD Type A/ Plastic CB Box</strong>

<p>– ฟรี รับประกันสินค้า 3 ปี (หากเครื่องมีปัญหา จะเปลี่ยนเป็นเครื่องใหม่)</p>

''';
  String testHtmlWithoutTag =
      '''Installation Package<br><br>– ฟรี เดินสายไฟ ระยะ 20 เมตร / ท่อ uPVC ขาว 3/4″-1″ / เบรกเกอร์ 40A /<br><br>อุปกรณ์กันไฟดูด RCD Type A/ Plastic CB Boxุปกรณ์กันไฟดูด RCD Type A/ Plastic CB Box
''';
}

class LoaderConst {
  // Loader
  String iconLoading = 'assets/images/icon_loading.png';
}

// assets data
const List assetsCarouselItem = ["assets/homepage/HeroBanner.png"];

class ProductSelectOptionsConst {
  String continueText = "ดำเนินการต่อ";
  String selectProdText = "ตัวเลือกสินค้า";
  String priceProdDefaultText = "0 บาท";
  String backButtonKey = "pop_navigator_to_product_detail";
  String imgDefaultPath = "assets/homepage/img_default.png";
}

const carouselOver20Item = [
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/EIFFEL_BASIC_COMMANDER.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/BlackFriday_Commander_Harting.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/Public_Garage_Indoor.jpg",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/Public_Garage_Indoor_2.jpg",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/Public_Garage_Indoor_3.jpg",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/Public_Garage_Indoor_4.jpg",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/WALLBOX_DAY2_2.jpg",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/WALLBOX_DAY2_4.jpg",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/WALLBOX_DAY2_9.jpg",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_BLACK_MONOCHROME_2_2.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PPMAX_BLACK_MONOCHROME_PHONE_1.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PPMAX_GREY_MONOCHROME_PHONE.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_2.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_3.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_APP_EURO.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_INSTALL_2.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_INSTALL.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/WallBox_Home_Garage_Indoor_Pulsar_Max_Installer_2150.jpg",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/WallBox_Home_Garage_Outoor_Stucco_Pulsar_Max_1889.jpg",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/WallBox_Residential_Complex_Pulsar_Plus_NA_4657.jpg",
];
const carouselSingleItem = [
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
];
const carouselTripleItem = [
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/EIFFEL_BASIC_COMMANDER.png",
];

// FormType
const String formTypeTextField = 'textField';
const String formTypeDropdown = 'selectDropdown';
