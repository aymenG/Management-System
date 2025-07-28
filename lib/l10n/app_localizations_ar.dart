// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'نظام إدارة تأجير السيارات';

  @override
  String get welcome => 'مرحباً';

  @override
  String get home => 'الرئيسية';

  @override
  String get carManagement => 'إدارة السيارات';

  @override
  String get rentals => 'الإيجارات';

  @override
  String get archive => 'الأرشيف';

  @override
  String get settings => 'الإعدادات';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get closeButton => 'إغلاق';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get confirmButton => 'تأكيد';

  @override
  String get deleteButton => 'حذف';

  @override
  String get confirmExit => 'تأكيد الخروج';

  @override
  String get areYouSureToClose => 'هل أنت متأكد أنك تريد إغلاق التطبيق؟';

  @override
  String get pageNotFound => 'الصفحة غير موجودة';

  @override
  String get actionCannotBeUndone =>
      'لا يمكن التراجع عن هذا الإجراء وسيتم نقل الإيجار إلى الأرشيف.';

  @override
  String get currencySymbol => 'د.ج';

  @override
  String get dashboardTitle => 'نظرة عامة على لوحة التحكم';

  @override
  String get dailyIncome => 'الدخل اليومي';

  @override
  String get monthlyIncome => 'الدخل الشهري';

  @override
  String get dailyRentals => 'الإيجارات اليومية';

  @override
  String get monthlyRentals => 'الإيجارات الشهرية';

  @override
  String get topRentedCars => 'أكثر 5 سيارات تأجيراً';

  @override
  String get noRentalsYet => 'لم يتم تسجيل أي إيجارات بعد.';

  @override
  String get unknownCar => 'سيارة غير معروفة';

  @override
  String numberOfRentals(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString إيجار',
      many: '$countString إيجار',
      few: '$countString إيجارات',
      two: 'إيجاران',
      one: 'إيجار واحد',
      zero: 'لا توجد إيجارات',
    );
    return '$_temp0';
  }

  @override
  String get availableCarsTitle => 'السيارات المتاحة';

  @override
  String get addCarButton => 'إضافة سيارة';

  @override
  String get addCarTooltip => 'إضافة سيارة جديدة';

  @override
  String get noCarsAvailable => 'لا توجد سيارات متاحة';

  @override
  String get addFirstCarPrompt => 'أضف سيارتك الأولى للبدء';

  @override
  String get totalCars => 'إجمالي السيارات';

  @override
  String get rentedCars => 'السيارات المؤجرة';

  @override
  String get archivedCars => 'السيارات المؤرشفة';

  @override
  String get columnId => 'المعرف';

  @override
  String get columnBrand => 'الماركة';

  @override
  String get columnModel => 'الموديل';

  @override
  String get columnYear => 'السنة';

  @override
  String get columnPlateNumber => 'رقم اللوحة';

  @override
  String get columnDailyPrice => 'السعر اليومي (د.ج)';

  @override
  String get columnStatus => 'الحالة';

  @override
  String get columnActions => 'الإجراءات';

  @override
  String plateNumber(String number) {
    return 'اللوحة: $number';
  }

  @override
  String carYear(int year) {
    return 'السنة: $year';
  }

  @override
  String dailyPrice(String price, String currencySymbol) {
    return '$price $currencySymbol/يوم';
  }

  @override
  String get rentButton => 'تأجير';

  @override
  String get returnButton => 'إرجاع';

  @override
  String get editButton => 'تعديل';

  @override
  String get editCarTooltip => 'تعديل السيارة';

  @override
  String get archiveCarTooltip => 'أرشفة السيارة';

  @override
  String get restoreCarTooltip => 'استعادة السيارة';

  @override
  String get deleteCarTooltip => 'حذف السيارة نهائياً';

  @override
  String get carStatusAvailable => 'متاحة';

  @override
  String get carStatusRented => 'مؤجرة';

  @override
  String get carStatusUnderMaintenance => 'تحت الصيانة';

  @override
  String get carStatusArchived => 'مؤرشفة';

  @override
  String get confirmArchiveTitle => 'تأكيد الأرشفة';

  @override
  String get archiveCarConfirmation =>
      'هل أنت متأكد أنك تريد أرشفة هذه السيارة؟ سيتم نقلها إلى صفحة الأرشيف.';

  @override
  String get carArchivedSuccess => 'تم أرشفة السيارة بنجاح!';

  @override
  String get errorArchivingCar => 'خطأ في أرشفة السيارة';

  @override
  String get returnCarTitle => 'إرجاع السيارة';

  @override
  String get returnCarConfirmation =>
      'هل أنت متأكد أنك تريد إرجاع هذه السيارة؟';

  @override
  String carStatusUpdated(String status) {
    return 'تم تحديث حالة السيارة إلى $status!';
  }

  @override
  String get errorUpdatingCarStatus => 'خطأ في تحديث حالة السيارة';

  @override
  String get confirmDeleteTitle => 'تأكيد الحذف النهائي';

  @override
  String get deleteCarConfirmation =>
      'هل أنت متأكد أنك تريد حذف هذه السيارة نهائياً؟';

  @override
  String get carDeletedSuccess => 'تم حذف السيارة نهائياً!';

  @override
  String get errorDeletingCar => 'خطأ في حذف السيارة';

  @override
  String get errorLoadingCars => 'خطأ في تحميل السيارات';

  @override
  String get addCarPageTitle => 'إضافة سيارة جديدة';

  @override
  String get carBrandLabel => 'ماركة السيارة';

  @override
  String get carModelLabel => 'موديل السيارة';

  @override
  String get manufacturingYearLabel => 'سنة الصنع';

  @override
  String get plateNumberLabel => 'رقم اللوحة';

  @override
  String get dailyRentalRateLabel => 'سعر الإيجار اليومي';

  @override
  String get carStatusLabel => 'حالة السيارة';

  @override
  String get saveButton => 'حفظ';

  @override
  String get errorAddCar => 'خطأ في إضافة السيارة';

  @override
  String get carAddedSuccess => 'تمت إضافة السيارة بنجاح!';

  @override
  String get carStatusPrompt => 'اختر حالة السيارة';

  @override
  String get carUpdateSuccess => 'تم تحديث السيارة بنجاح!';

  @override
  String get errorUpdateCar => 'خطأ في تحديث السيارة';

  @override
  String get editCarPageTitle => 'تعديل تفاصيل السيارة';

  @override
  String get rentalsPageTitle => 'الإيجارات النشطة والسابقة';

  @override
  String get exportRentalsButton => 'تصدير الإيجارات إلى Excel';

  @override
  String get pickDateRangeTitle => 'اختيار نطاق التاريخ';

  @override
  String get noRentalsInDateRange =>
      'لم يتم العثور على إيجارات في النطاق الزمني المحدد.';

  @override
  String get exportSuccess => 'تم تصدير الإيجارات بنجاح!';

  @override
  String get noRentalsFound => 'لم يتم العثور على إيجارات بعد!';

  @override
  String get addRentalHint => 'ابدأ بإضافة إيجار سيارة جديد.';

  @override
  String get rentalIdHeader => 'المعرف';

  @override
  String get customerHeader => 'العميل';

  @override
  String get carBrandHeader => 'ماركة السيارة';

  @override
  String get carModelHeader => 'موديل السيارة';

  @override
  String get plateNumberHeader => 'رقم اللوحة';

  @override
  String get rentDateHeader => 'تاريخ الإيجار';

  @override
  String get returnDateHeader => 'تاريخ الإرجاع';

  @override
  String totalPriceHeader(Object currencySymbol) {
    return 'السعر الإجمالي ($currencySymbol)';
  }

  @override
  String get actionsHeader => 'الإجراءات';

  @override
  String get editRentalTooltip => 'تعديل الإيجار';

  @override
  String get deleteRentalTooltip => 'حذف الإيجار';

  @override
  String get errorLoadingRentals => 'خطأ في تحميل الإيجارات';

  @override
  String get rentalUpdatedSuccess => 'تم تحديث الإيجار بنجاح!';

  @override
  String errorRentalNotFound(int id) {
    return 'خطأ: لم يتم العثور على الإيجار بالمعرف $id للتعديل.';
  }

  @override
  String get errorEditNullRentalId => 'خطأ: محاولة تعديل إيجار بمعرف فارغ.';

  @override
  String get errorDeleteNullRentalId => 'خطأ: محاولة حذف إيجار بمعرف فارغ.';

  @override
  String get confirmDeletionTitle => 'تأكيد الحذف';

  @override
  String get deleteRentalConfirmation =>
      'هل أنت متأكد أنك تريد حذف هذا الإيجار؟';

  @override
  String get rentalDeletedSuccess => 'تم حذف الإيجار بنجاح!';

  @override
  String get errorDeletingRental => 'خطأ في حذف الإيجار';

  @override
  String get addRentalButton => 'إضافة إيجار جديد';

  @override
  String get confirmBookingTitle => 'تأكيد حجز الإيجار';

  @override
  String get confirmBookingMessage => 'هل أنت متأكد أنك تريد حجز هذا الإيجار؟';

  @override
  String get customerNameLabel => 'اسم العميل';

  @override
  String get customerPhoneLabel => 'هاتف العميل';

  @override
  String get rentDateLabel => 'تاريخ الإيجار';

  @override
  String get returnDateLabel => 'تاريخ الإرجاع';

  @override
  String get totalPriceLabel => 'السعر الإجمالي';

  @override
  String get errorBookingRental => 'خطأ في حجز الإيجار';

  @override
  String get rentalBookedSuccess => 'تم حجز الإيجار بنجاح!';

  @override
  String get selectCustomerMessage => 'اختر العميل';

  @override
  String get noCustomerSelected => 'لم يتم اختيار عميل';

  @override
  String get pickCustomerTitle => 'اختر عميلاً';

  @override
  String get customerSearchHint => 'البحث عن عملاء...';

  @override
  String get addNewCustomerButton => 'إضافة عميل جديد';

  @override
  String get addCustomerDialogTitle => 'إضافة عميل جديد';

  @override
  String get customerNameHint => 'أدخل اسم العميل';

  @override
  String get customerPhoneHint => 'أدخل رقم هاتف العميل';

  @override
  String get customerAddressHint => 'أدخل عنوان العميل (اختياري)';

  @override
  String get errorAddCustomer => 'خطأ في إضافة العميل';

  @override
  String get customerAddedSuccess => 'تمت إضافة العميل بنجاح!';

  @override
  String get selectCarMessage => 'اختر السيارة';

  @override
  String get carSearchHint => 'البحث عن سيارات...';

  @override
  String get selectCarTitle => 'اختر سيارة';

  @override
  String get noCarSelected => 'لم يتم اختيار سيارة';

  @override
  String get archivePageTitle => 'العناصر المؤرشفة';

  @override
  String get archivedCarsTab => 'السيارات المؤرشفة';

  @override
  String get archivedRentalsTab => 'الإيجارات المؤرشفة';

  @override
  String get noArchivedCarsFound => 'لا توجد سيارات مؤرشفة!';

  @override
  String get noArchivedRentalsFound => 'لا توجد إيجارات مؤرشفة!';

  @override
  String get archivedRentalsAppearHere =>
      'الإيجارات التي تقوم بأرشفتها ستظهر هنا.';

  @override
  String get restoreCarButton => 'استعادة السيارة';

  @override
  String get deletePermanentlyButton => 'حذف نهائياً';

  @override
  String get permanentDeleteCarConfirmation =>
      'هل أنت متأكد أنك تريد حذف هذه السيارة بشكل دائم؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get carRestoredSuccess => 'تم استعادة السيارة بنجاح!';

  @override
  String get errorRestoringCar => 'خطأ في استعادة السيارة';

  @override
  String get carPermanentlyDeleted => 'تم حذف السيارة نهائياً!';

  @override
  String get errorDeletingCarPermanently => 'خطأ في حذف السيارة نهائياً';

  @override
  String get restoreRentalButton => 'استعادة الإيجار';

  @override
  String get permanentDeleteRentalConfirmation =>
      'هل أنت متأكد أنك تريد حذف هذا الإيجار بشكل دائم؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get rentalRestoredSuccess => 'تم استعادة الإيجار بنجاح!';

  @override
  String get errorRestoringRental => 'خطأ في استعادة الإيجار';

  @override
  String get rentalPermanentlyDeleted => 'تم حذف الإيجار نهائياً!';

  @override
  String get errorDeletingRentalPermanently => 'خطأ في حذف الإيجار نهائياً';
}
