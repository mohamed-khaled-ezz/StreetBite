// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'ستريت بايت';

  @override
  String get welcomeTitle => 'أكلك وطلباتك توصلك لحد بابك';

  @override
  String get welcomeSubtitle => 'سجّل الدخول أو أنشئ حسابًا للبدء';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get createAccount => 'إنشاء حساب جديد';

  @override
  String get fullName => 'الاسم بالكامل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get noAccountPrompt => 'ليس لديك حساب؟';

  @override
  String get haveAccountPrompt => 'لديك حساب بالفعل؟';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get nameRequired => 'من فضلك أدخل اسمك بالكامل';

  @override
  String get nameCapital => 'يجب أن يبدأ الاسم بحرف كبير';

  @override
  String get emailInvalid => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get passwordShort => 'يجب ألا تقل كلمة المرور عن 6 أحرف';

  @override
  String get passwordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get cardInvalid => 'أدخل رقم بطاقة صحيح من 16 رقمًا';

  @override
  String get errorNetwork => 'لا يوجد اتصال بالإنترنت. حاول مرة أخرى.';

  @override
  String get errorServer => 'حدث خطأ من جانبنا. حاول لاحقًا.';

  @override
  String get errorInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get errorEmailInUse => 'هذا البريد الإلكتروني مسجّل بالفعل.';

  @override
  String get errorWeakPassword => 'كلمة المرور ضعيفة جدًا.';

  @override
  String get errorTooManyRequests =>
      'محاولات كثيرة. انتظر قليلًا ثم حاول مجددًا.';

  @override
  String get errorPayment => 'فشلت عملية الدفع. تحقق من بيانات البطاقة.';

  @override
  String get errorUnknown => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get home => 'الرئيسية';

  @override
  String get browse => 'استكشف';

  @override
  String get orders => 'الطلبات';

  @override
  String get profile => 'حسابي';

  @override
  String get search => 'بحث';

  @override
  String get searchHint => 'ابحث عن وجبة';

  @override
  String get categories => 'التصنيفات';

  @override
  String get noResults => 'لا توجد وجبات';

  @override
  String get featured => 'مميز';

  @override
  String get hotOffers => 'عروض ساخنة';

  @override
  String get recommended => 'مقترح لك';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String addedToCart(String name) {
    return 'تمت إضافة $name إلى السلة';
  }

  @override
  String addAnother(int count) {
    return 'أضف المزيد ($count في السلة)';
  }

  @override
  String discountBadge(String percent) {
    return 'خصم $percent%';
  }

  @override
  String priceLabel(String amount) {
    return '$amount ج.م';
  }

  @override
  String get category => 'التصنيف';

  @override
  String get origin => 'بلد المنشأ';

  @override
  String get instructions => 'طريقة التحضير';

  @override
  String get favourites => 'المفضلة';

  @override
  String get favouriteAdded => 'تمت الإضافة إلى المفضلة';

  @override
  String get favouriteRemoved => 'تمت الإزالة من المفضلة';

  @override
  String get noFavourites => 'لا توجد مفضلات بعد';

  @override
  String get order => 'الطلب';

  @override
  String get delivery => 'توصيل';

  @override
  String get pickup => 'استلام';

  @override
  String get emptyCart => 'السلة فارغة';

  @override
  String get cartBecameEmpty => 'أصبحت السلة فارغة';

  @override
  String get remove => 'إزالة';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get deliveryFee => 'رسوم التوصيل';

  @override
  String get serviceFee => 'الرسوم والضرائب';

  @override
  String get total => 'الإجمالي';

  @override
  String get checkout => 'إتمام الطلب';

  @override
  String get deliveryTime => 'وقت التوصيل';

  @override
  String get express => 'سريع';

  @override
  String get standard => 'عادي';

  @override
  String minutesRange(String range) {
    return '$range دقيقة';
  }

  @override
  String get deliveryAddress => 'عنوان التوصيل';

  @override
  String get addAddress => 'أضف عنوان التوصيل';

  @override
  String get address => 'العنوان';

  @override
  String get apartment => 'الشقة';

  @override
  String get comment => 'ملاحظات';

  @override
  String get save => 'حفظ';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get cash => 'نقدًا';

  @override
  String get card => 'بطاقة';

  @override
  String get addCard => 'إضافة بطاقة';

  @override
  String get cardNumber => 'رقم البطاقة';

  @override
  String get cardName => 'الاسم على البطاقة';

  @override
  String get expiry => 'الانتهاء';

  @override
  String get cvv => 'CVV';

  @override
  String get zip => 'الرمز البريدي';

  @override
  String get defaultPaymentMethod => 'طريقة الدفع الافتراضية';

  @override
  String get placeOrder => 'تأكيد الطلب';

  @override
  String get orderPlaced => 'تم تسجيل الطلب بنجاح';

  @override
  String get ordersEmpty => 'لا توجد طلبات بعد';

  @override
  String get pastOrders => 'السابقة';

  @override
  String get orderHistory => 'سجل الطلبات';

  @override
  String orderNumber(String id) {
    return 'طلب رقم $id';
  }

  @override
  String itemsCount(int count) {
    return '$count عناصر';
  }

  @override
  String arrivesIn(String range) {
    return 'يصل خلال $range دقيقة';
  }

  @override
  String get preparingOrder => 'جارٍ تحضير طلبك';

  @override
  String get stepReceived => 'تم استلام الطلب';

  @override
  String get stepCooking => 'جارٍ تحضير الطعام';

  @override
  String get stepCourier => 'البحث عن مندوب';

  @override
  String get stepDelivered => 'تم توصيل الطلب';

  @override
  String get deviceDetails => 'تفاصيل الجهاز';

  @override
  String get deviceBrand => 'الشركة';

  @override
  String get deviceModel => 'الطراز';

  @override
  String get deviceOs => 'إصدار النظام';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get photoUpdated => 'تم تحديث صورة الحساب';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get contactUs => 'تواصل معنا';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get contactInfo => 'راسلنا على support@streetbite.app';

  @override
  String get helpInfo =>
      'تصفّح الوجبات وأضفها إلى السلة ثم أتمم الطلب من شاشة السلة.';

  @override
  String get close => 'إغلاق';
}
