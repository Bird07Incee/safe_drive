//resources

//for introScreen
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

int currentPage = 0;
CarouselController carouselController = CarouselController();
dynamic person;

List viewPage = [
  {
    'Title': 'Order Your Food',
    'image': 'assets/images/stocks/1.png',
    'desc': 'Now you can order food any time right from your mobile.',
  },
  {
    'Title': 'Cooking Safe Food',
    'image': 'assets/images/stocks/2.png',
    'desc': 'We are maintain safety and We keep clean while making food.',
  },
  {
    'Title': 'Quick delivery',
    'image': 'assets/images/stocks/3.png',
    'desc': 'Orders your favourite meals will be immediately deliver',
  },
];

//for signInScreen
final GlobalKey<FormState> SignInKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String? email;
String? password;
bool viewPassword = true;

//for loginScreen
final GlobalKey<FormState> logInKey = GlobalKey<FormState>();
TextEditingController emailControllerLog = TextEditingController();
TextEditingController passwordControllerLog = TextEditingController();
String? logEmail;
String? logPassword;
bool logViewPassword = true;

//for HomePage and Detail Page
List viewCategory = [
  {
    'id': 1,
    'name': 'All',
  },
  {
    'id': 2,
    'name': 'Fiction',
  },
  {
    'id': 3,
    'name': 'Psychology',
  },
  {
    'id': 4,
    'name': 'Finance',
  },
  {
    'id': 5,
    'name': 'Self-Help',
  },
];
List category = [
  {
    'id': 1,
    'name': 'Fiction',
    'img': '🍕',
  },
  {
    'id': 2,
    'name': 'Psychology',
    'img': '🍔',
  },
  {
    'id': 3,
    'name': 'Finance',
    'img': '☕️',
  },
  {
    'id': 4,
    'name': 'Selp-Help Books',
    'img': '🍦',
  },
];

