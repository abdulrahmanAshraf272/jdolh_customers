import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          // ========  Language ===========//
          'اللغة': 'اللغة',
          'اختر اللغة': 'اختر اللغة',
          'العربية': 'العربية',
          'الإنجليزية': 'الإنجليزية',
          // ======== Main screen =======/
          'الرئيسية': 'الرئيسية',
          'جدولة': 'جدولة',
          'الحجز': 'الحجز',
          'المزيد': 'المزيد',
          //====== Home ======//
          'مناسبات قريبة': 'مناسبات قريبة',
          'لا توجد مناسبات قريبة': 'لا توجد مناسبات قريبة',
          'حجوزات قريبة': 'حجوزات قريبة',
          'لا توجد حجوزات قريبة': 'لا توجد حجوزات قريبة',
          'نشاطات الأصدقاء': 'نشاطات الأصدقاء',
          'لا توجد نشاطات': 'لا توجد نشاطات',
          'أكتشف': 'أكتشف',
          'الأكثر زيارة خلال اسبوع': 'الأكثر زيارة خلال اسبوع',
          'لا توجد نتائج': 'لا توجد نتائج',
          'الأكثر تسجيل وصول خلال ساعتين': 'الأكثر تسجيل وصول خلال ساعتين',
          'الأكثر تقييم خلال اسبوع': 'الأكثر تقييم خلال اسبوع',
          //======= More ========//
          'متابعين': 'متابعين',
          'متابعون': 'متابعون',
          'الأنشطة': 'الأنشطة',
          'البيانات الشخصية': 'البيانات الشخصية',
          'المجموعات': 'المجموعات',
          'جهات الإتصال': 'جهات الإتصال',
          'المحفظة': 'المحفظة',
          'الحجوزات السابقة': 'الحجوزات السابقة',
          'المناسبات السابقة': 'المناسبات السابقة',
          'الفواتير': 'الفواتير',
          'تواصل معنا': 'تواصل معنا',
          'تسجيل الخروج': 'تسجيل الخروج',
          'هل تريد تسجيل الخروج؟': 'هل تريد تسجيل الخروج؟',
          'نعم': 'نعم',
          'الغاء': 'الغاء',
          //====== Schedule ======/
          'الحجوزات': 'الحجوزات',
          'حجوزات قادمة': 'حجوزات قادمة',
          'بحاجة لموافقتك': 'بحاجة لموافقتك',
          'لا توجد حجوزات': 'لا توجد حجوزات',
          'تفاصيل الحجز رقم:': 'تفاصيل الحجز رقم:',
          'الغاء الحجز': 'الغاء الحجز',
          'الخدمات': 'الخدمات',
          'تفاصيل الطلب': 'تفاصيل الطلب',
          'حجز تقليدي': 'حجز تقليدي',
          'خدمات منزلية': 'خدمات منزلية',
          'نوع المتجر': 'نوع المتجر',
          'النوع الفرعي': 'النوع الفرعي',
          'المدينة': 'المدينة',
          'اختر المدينة': 'اختر المدينة',
          'النتائج-': 'النتائج-',
          'المناسبات': 'المناسبات',
          'حجوزات منتهية': 'حجوزات منتهية',
          'حجوزات ملغية': 'حجوزات ملغية',
          'تقييم الحجز': 'تقييم الحجز',
          'يمكنك تقييم الحجز واضافة تعليق عن تجربك':
              'يمكنك تقييم الحجز واضافة تعليق عن تجربك',
          'تقييم': 'تقييم',
          'اضف رايك في المكان': 'اضف رايك في المكان',
          'حذف': 'حذف',
          'حجز': 'حجز',
          'عرض على الخريطة': 'عرض على الخريطة',
          'بيانات الحجز': 'بيانات الحجز',
          'التاريخ': 'التاريخ',
          'الوقت: ': 'الوقت: ',
          'التفضيل': 'التفضيل',
          'مدة الحجز': 'مدة الحجز',
          'دقيقة': 'دقيقة',
          'رقم التواصل: ': 'رقم التواصل: ',
          'المجموع': 'المجموع',
          'رسوم الحجز': 'رسوم الحجز',
          'الإجمالي غير شامل الضريبة': 'الإجمالي غير شامل الضريبة',
          'ضريبة القيمة المضافة': 'ضريبة القيمة المضافة',
          'الإجمالي شامل الضريبة': 'الإجمالي شامل الضريبة',
          'التقييم': 'التقييم',
          'لا يوجد نشاطات': 'لا يوجد نشاطات',
          'الغاء المتابعة': 'الغاء المتابعة',
          'متابعة': 'متابعة',
          'الإشعارات': 'الإشعارات',
          'لا توجد اشعارات': 'لا توجد اشعارات',
          'جهات الاتصال': 'جهات الاتصال',
          'غير مسموح بالوصول الى جهات الاتصال لديك':
              'غير مسموح بالوصول الى جهات الاتصال لديك',
          'دعوة الأصدقاء': 'دعوة الأصدقاء',
          'دعوة': 'دعوة',
          'البحث باسم المستخدم او اسم التاجر':
              'البحث باسم المستخدم او اسم التاجر',
          'عرض الكل': 'عرض الكل',
          'انشاء مناسبة': 'انشاء مناسبة',
          'لا توجد مناسبات': 'لا توجد مناسبات',
          'إضافة الحجز': 'إضافة الحجز',
          'ريال': 'ريال',
          'غير متوفر ضمن تفضيل': 'غير متوفر ضمن تفضيل',
          'قم بإزالة': 'قم بإزالة',
          'او قم بتغيير التفضيل': 'او قم بتغيير التفضيل',
          'من فضلك قم بإضافة الخدمات ثم قم بتحديد وقت الحجز':
              'من فضلك قم بإضافة الخدمات ثم قم بتحديد وقت الحجز',
          'من فضلك قم بإضافة المنتجات ثم قم بتحديد وقت الحجز':
              'من فضلك قم بإضافة المنتجات ثم قم بتحديد وقت الحجز',
          'السلة فارغة!': 'السلة فارغة!',
          'من فضلك اختر وقت الحجز': 'من فضلك اختر وقت الحجز',
          'القائمة': 'القائمة',
          'تفاصيل الحجز': 'تفاصيل الحجز',
          'من فضلك قم بتحديد عنوان المنزل': 'من فضلك قم بتحديد عنوان المنزل',
          'من فضلك قم بكتابة اسم الحي': 'من فضلك قم بكتابة اسم الحي',
          'من فضلك قم بكتابة اسم الشارع': 'من فضلك قم بكتابة اسم الشارع',
          'من فضلك قم بكتابة اسم او رقم البرج':
              'من فضلك قم بكتابة اسم او رقم البرج',
          'من فضلك قم بكتابة رقم الدور': 'من فضلك قم بكتابة رقم الدور',
          'من فضلك قم بكتابة رقم الشقة': 'من فضلك قم بكتابة رقم الشقة',
          'عذراً': 'عذراً',
          'الخدمة غير متوفرة في هذه المنطقة':
              'الخدمة غير متوفرة في هذه المنطقة',
          'من فضلك قم باختيار وقت الحجز': 'من فضلك قم باختيار وقت الحجز',
          'تفضيلات الحجز': 'تفضيلات الحجز',
          'وقت الحجز': 'وقت الحجز',
          'اختر وقت و تاريخ الحجز': 'اختر وقت و تاريخ الحجز',
          'تأكيد الحجز': 'تأكيد الحجز',
          'الموقع': 'الموقع',
          'حدد موقع المنزل': 'حدد موقع المنزل',
          'العنوان': 'العنوان',
          'اسم الحي': 'اسم الحي',
          'اسم الشارع': 'اسم الشارع',
          'اسم البرج': 'اسم البرج',
          'رقم الدور': 'رقم الدور',
          'رقم الشقة': 'رقم الشقة',
          'تنبيه': 'تنبيه',
          'مدة الخدمة': 'مدة الخدمة',
          'من فضلك قم باختيار المدعوين': 'من فضلك قم باختيار المدعوين',
          'ارسال الدعوات': 'ارسال الدعوات',
          'اختر تاريخ الحجز': 'اختر تاريخ الحجز',
          'اختر وقت الحجز': 'اختر وقت الحجز',
          'عفواً لا توجد اوقات متاحة في هذا اليوم':
              'عفواً لا توجد اوقات متاحة في هذا اليوم',
          'حفظ': 'حفظ',
          'الصنف': 'الصنف',
          'العدد': 'العدد',
          'المبلغ': 'المبلغ',
          "الحقل فارغ!": "الحقل فارغ!",
          'اسم مستخدم غير صالح, مثال":@ahmed.ali44':
              'اسم مستخدم غير صالح, مثال":@ahmed.ali44',
          'بريد الكتروني غير صالح': 'بريد الكتروني غير صالح',
          'رقم هاتف غير صالح': 'رقم هاتف غير صالح',
          "لا يمكن ان تكون البيانات اقل من خانتين":
              "لا يمكن ان تكون البيانات اقل من خانتين",
          "لا يمكن ان تكون البيانات اكبر من 100 خانه":
              "لا يمكن ان تكون البيانات اكبر من 100 خانه",
          'لا يمكن ان يكون الاسم اصغر من حرفين':
              'لا يمكن ان يكون الاسم اصغر من حرفين',
          'لا يمكن ان يكون الاسم اكبر من 60 حرف':
              'لا يمكن ان يكون الاسم اكبر من 60 حرف',
          'غير مسموح بوجود فراغات في الاسم الاول واسم العائلة':
              'غير مسموح بوجود فراغات في الاسم الاول واسم العائلة',
          'تقسيم رسوم الحجز': 'تقسيم رسوم الحجز',
          'معزوم': 'معزوم',
          'ازالة': 'ازالة',
          'قيمة الفاتورة': 'قيمة الفاتورة',
          'مغادرة الحجز': 'مغادرة الحجز',
          'المدعوين': 'المدعوين',
          'المقاعد الاضافية: ': 'المقاعد الاضافية: ',
          'اذا قمت بدفع رسوم,لا يوجد استرداد للرسوم في حالة المغادرة':
              'اذا قمت بدفع رسوم,لا يوجد استرداد للرسوم في حالة المغادرة',
          'تأكيد': 'تأكيد',
          'رسوم الحجز غير مستردة عند الغاء الحجز':
              'رسوم الحجز غير مستردة عند الغاء الحجز',
          'عند الضغط على قبول سيتم تحويل الرسوم من محفظتك وتحويلها لمحفظة صديقك الذي ارسل الدعوة ليقوم بتأكيد الحجز':
              'عند الضغط على قبول سيتم تحويل الرسوم من محفظتك وتحويلها لمحفظة صديقك الذي ارسل الدعوة ليقوم بتأكيد الحجز',
          'قبول': 'قبول',
          'الرسوم': 'الرسوم',
          'رفض': 'رفض',
          'هل تريد رفض دعوة': 'هل تريد رفض دعوة',
          'لا يوجد لديك رصيد كاف': 'لا يوجد لديك رصيد كاف',
          'الرقم غير صالح': 'الرقم غير صالح',
          'خروج': 'خروج',
          'هل تريد الخروج من التطبيق؟': 'هل تريد الخروج من التطبيق؟',
          'قيمة الفاتورة تدفع عند الوصول': 'قيمة الفاتورة تدفع عند الوصول',
          'اخر العمليات': 'اخر العمليات',
          'رصيد المحفظة': 'رصيد المحفظة',
          'شحن المحفظة': 'شحن المحفظة',
          'دفع': 'دفع',
          'رصيدك الان': 'رصيدك الان',
          'تهانينا, تم شحن مبلغ': 'تهانينا, تم شحن مبلغ',
          'شكراً لاختيارك جدولة': 'شكراً لاختيارك جدولة',
          'تحويل رصيد': 'تحويل رصيد',
          'هذا المبلغ لا يمكن اعادة سحبه يستخدم داخل التطبيق فقط':
              'هذا المبلغ لا يمكن اعادة سحبه يستخدم داخل التطبيق فقط',
          'غير مدفوعة': 'غير مدفوعة',
          'مدفوعة': 'مدفوعة',
          'فاتورة رقم': 'فاتورة رقم',
          'بتاريخ': 'بتاريخ',
          'لا توجد فواتير غبر مدفوعة': 'لا توجد فواتير غبر مدفوعة',
          'لا توجد فواتير مدفوعة': 'لا توجد فواتير مدفوعة',
          'الدفع في الفرع': 'الدفع في الفرع',
          'الدفع بالبطاقة': 'الدفع بالبطاقة',
          'الدفع بالمحفظة': 'الدفع بالمحفظة',
          'الدفع بتمارا': 'الدفع بتمارا',
          'تم تقسيم الفاتورة الاصلية المبلغ الذي عليك دفعه هو:':
              'تم تقسيم الفاتورة الاصلية المبلغ الذي عليك دفعه هو:',
          'شامل ضريبة القيمة المضافة': 'شامل ضريبة القيمة المضافة',
          'عرض الفاتورة؟': 'عرض الفاتورة؟'
        },
        'en': {
          // ========  Language ===========//
          "اللغة": "Language",
          "اختر اللغة": "Select Language",
          "العربية": "Arabic",
          "الإنجليزية": "English",
          // ======== Main screen =======/
          "الرئيسية": "Home",
          "جدولة": "Schedule",
          "الحجز": "Booking",
          "المزيد": "More",
          //====== Home ======//
          "مناسبات قريبة": "Upcoming Events",
          "لا توجد مناسبات قريبة": "No Upcoming Events",
          "حجوزات قريبة": "Upcoming Bookings",
          "لا توجد حجوزات قريبة": "No Upcoming Bookings",
          "نشاطات الأصدقاء": "Friends' Activities",
          "لا توجد نشاطات": "No Activities",
          "أكتشف": "Discover",
          "الأكثر زيارة خلال اسبوع": "Most Visited This Week",
          "لا توجد نتائج": "No Results",
          "الأكثر تسجيل وصول خلال ساعتين": "Most Check-ins In Two Hours",
          "الأكثر تقييم خلال اسبوع": "Top Rated This Week",
          //======= More ========//
          "متابعين": "Followers",
          "متابعون": "Following",
          "الأنشطة": "Activities",
          "البيانات الشخصية": "Personal Information",
          "المجموعات": "Groups",
          "جهات الإتصال": "Contacts",
          "المحفظة": "Wallet",
          "الحجوزات السابقة": "Previous Bookings",
          "المناسبات السابقة": "Previous Events",
          "الفواتير": "Bills",
          "تواصل معنا": "Contact Us",
          "تسجيل الخروج": "Log Out",
          "هل تريد تسجيل الخروج؟": "Do You Want To Log Out?",
          "نعم": "Yes",
          "الغاء": "Cancel",
          //====== Schedule ======//
          "الحجوزات": "Bookings",
          "حجوزات قادمة": "Upcoming Bookings",
          "بحاجة لموافقتك": "Needs Approval",
          "لا توجد حجوزات": "No Bookings",
          "تفاصيل الحجز رقم:": "Booking Details Number:",
          "الغاء الحجز": "Cancel Booking",
          "الخدمات": "Services",
          "تفاصيل الطلب": "Order Details",
          "حجز تقليدي": "Traditional Booking",
          "خدمات منزلية": "Home Services",
          "نوع المتجر": "Store Type",
          "النوع الفرعي": "Subtype",
          "المدينة": "City",
          "اختر المدينة": "Select City",
          "النتائج-": "Results-",
          "المناسبات": "Events",
          "حجوزات منتهية": "Completed Bookings",
          "حجوزات ملغية": "Cancelled Bookings",
          "تقييم الحجز": "Rate Booking",
          "يمكنك تقييم الحجز واضافة تعليق عن تجربك":
              "You Can Rate The Booking And Add A Comment About Your Experience",
          "تقييم": "Rate",
          "اضف رايك في المكان": "Add Your Opinion About The Place",
          "حذف": "Delete",
          "حجز": "Booking",
          "عرض على الخريطة": "Show On Map",
          "بيانات الحجز": "Booking Details",
          "التاريخ": "Date",
          "الوقت: ": "Time:",
          "التفضيل": "Preference",
          "مدة الحجز": "Booking Duration",
          "دقيقة": "Minute",
          "رقم التواصل: ": "Contact Number:",
          "المجموع": "Total",
          "رسوم الحجز": "Booking Fee",
          "الإجمالي غير شامل الضريبة": "Total Excluding Tax",
          "ضريبة القيمة المضافة": "Value Added Tax",
          "الإجمالي شامل الضريبة": "Total Including Tax",
          "التقييم": "Rating",
          "لا يوجد نشاطات": "No Activities",
          "الغاء المتابعة": "Unfollow",
          "متابعة": "Follow",
          "الإشعارات": "Notifications",
          "لا توجد اشعارات": "No Notifications",
          "جهات الاتصال": "Contacts",
          "غير مسموح بالوصول الى جهات الاتصال لديك":
              "Access To Your Contacts Is Not Allowed",
          "دعوة الأصدقاء": "Invite Friends",
          "دعوة": "Invite",
          "البحث باسم المستخدم او اسم التاجر":
              "Search By Username Or Merchant Name",
          'عرض الكل': 'Show all',
          'انشاء مناسبة': 'Create event',
          'لا توجد مناسبات': 'No upcoming events'
        }
      };
}
