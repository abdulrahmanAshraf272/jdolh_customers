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
              'من فضلك قم بإضافة المنتجات ثم قم بتحديد وقت الحجز'
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
