// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get errorLoadingCars => 'خطأ في تحميل السيارات:';

  @override
  String get carDeletedSuccess => 'تم حذف السيارة بنجاح!';

  @override
  String get errorArchivingCar => 'خطأ في أرشفة السيارة:';

  @override
  String carStatusUpdated(String status) {
    return 'تم تحديث حالة السيارة إلى $status!';
  }

  @override
  String get errorUpdatingCarStatus => 'خطأ في تحديث حالة السيارة:';

  @override
  String get availableCarsTitle => 'السيارات المتاحة';

  @override
  String get addCarButton => 'إضافة سيارة';

  @override
  String get noCarsAvailable => 'لا توجد سيارات متاحة';

  @override
  String get addFirstCarHint => 'أضف سيارتك الأولى للبدء';

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
    return '$price $currencySymbol/اليوم';
  }

  @override
  String get rentButton => 'استئجار';

  @override
  String get returnButton => 'إرجاع';

  @override
  String get editButton => 'تعديل';

  @override
  String get deleteCarTooltip => 'حذف السيارة';

  @override
  String get archiveCarTitle => 'أرشفة السيارة';

  @override
  String get archiveCarConfirmation =>
      'هل أنت متأكد أنك تريد أرشفة هذه السيارة؟ سيتم نقلها إلى صفحة الأرشيف.';

  @override
  String get confirmButton => 'تأكيد';

  @override
  String get returnCarTitle => 'إرجاع السيارة';

  @override
  String get returnCarConfirmation =>
      'هل أنت متأكد أنك تريد إرجاع هذه السيارة؟';

  @override
  String get carStatusAvailable => 'متاحة';

  @override
  String get carStatusRented => 'مؤجرة';

  @override
  String get carStatusMaintenance => 'تحت الصيانة';

  @override
  String get carStatusArchived => 'مؤرشفة';

  @override
  String get appTitle => 'نظام إدارة السيارات';

  @override
  String get closeButton => 'إغلاق';

  @override
  String get welcome => 'مرحباً';

  @override
  String get home => 'الرئيسية';

  @override
  String get availableCars => 'السيارات المتاحة';

  @override
  String get rentals => 'الإيجارات';

  @override
  String get archive => 'الأرشيف';

  @override
  String get settings => 'الإعدادات';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get confirmExit => 'تأكيد الخروج';

  @override
  String get areYouSureToClose => 'هل أنت متأكد أنك تريد إغلاق التطبيق؟';

  @override
  String get pageNotFound => 'الصفحة غير موجودة';

  @override
  String get dashboardTitle => 'نظرة عامة على لوحة التحكم';

  @override
  String get dailyIncome => 'الإيراد اليومي';

  @override
  String get monthlyIncome => 'الإيراد الشهري';

  @override
  String get dailyRentals => 'الإيجارات اليومية';

  @override
  String get monthlyRentals => 'الإيجارات الشهرية';

  @override
  String get currencySymbol => 'د.ج';

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
      other: 'إيجارات',
      many: 'إيجارات',
      few: 'إيجارات',
      two: 'إيجاران',
      one: 'إيجار واحد',
      zero: 'لا توجد إيجارات',
    );
    return '$_temp0';
  }

  @override
  String get addFirstCarPrompt => 'أضف سيارتك الأولى للبدء';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get carArchivedSuccess => 'تمت أرشفة السيارة بنجاح!';

  @override
  String get columnId => 'الرقم التعريفي';

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
  String get rentalsPageTitle => 'الإيجارات الحالية والسابقة';

  @override
  String get noRentalsFound => 'لم يتم العثور على إيجارات بعد!';

  @override
  String get startAddingRentalPrompt => 'ابدأ بإضافة عقد إيجار سيارة جديد.';

  @override
  String get editRentalButton => 'تعديل الإيجار';

  @override
  String get archiveRentalButton => 'أرشفة الإيجار';

  @override
  String get confirmArchivingRentalTitle => 'تأكيد الأرشفة';

  @override
  String get archiveRentalConfirmation =>
      'هل أنت متأكد أنك تريد أرشفة هذا الإيجار؟ يمكن استعادة الإيجارات المؤرشفة لاحقًا.';

  @override
  String get rentalArchivedSuccess => 'تمت أرشفة الإيجار بنجاح!';

  @override
  String get errorArchivingRental => 'خطأ في أرشفة الإيجار:';

  @override
  String get errorLoadingRentals => 'خطأ في تحميل الإيجارات:';

  @override
  String get confirmDeletionTitle => 'تأكيد الحذف';

  @override
  String get deleteRentalConfirmation =>
      'هل أنت متأكد أنك تريد حذف هذا الإيجار؟';

  @override
  String get actionCannotBeUndone => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get deleteButton => 'حذف';

  @override
  String get rentalDeletedSuccess => 'تم حذف الإيجار بنجاح!';

  @override
  String get errorDeletingRental => 'خطأ في حذف الإيجار:';

  @override
  String get columnCustomer => 'العميل';

  @override
  String get columnCarBrand => 'ماركة السيارة';

  @override
  String get columnCarModel => 'موديل السيارة';

  @override
  String get columnRentDate => 'تاريخ الإيجار';

  @override
  String get columnReturnDate => 'تاريخ الإرجاع';

  @override
  String get columnTotalPrice => 'السعر الإجمالي (د.ج)';

  @override
  String get archivePageTitle => 'العناصر المؤرشفة';

  @override
  String get archivedCarsTab => 'السيارات المؤرشفة';

  @override
  String get archivedRentalsTab => 'الإيجارات المؤرشفة';

  @override
  String get noArchivedCarsFound => 'لم يتم العثور على سيارات مؤرشفة!';

  @override
  String get noArchivedRentalsFound => 'لم يتم العثور على إيجارات مؤرشفة!';

  @override
  String get restoreCarButton => 'استعادة السيارة';

  @override
  String get deletePermanentlyButton => 'حذف نهائي';

  @override
  String get confirmPermanentDeletionTitle => 'تأكيد الحذف النهائي';

  @override
  String get permanentDeleteCarConfirmation =>
      'هل أنت متأكد أنك تريد حذف هذه السيارة نهائيًا؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get carRestoredSuccess => 'تمت استعادة السيارة بنجاح!';

  @override
  String get errorRestoringCar => 'خطأ في استعادة السيارة:';

  @override
  String get carPermanentlyDeleted => 'تم حذف السيارة نهائيًا!';

  @override
  String get errorDeletingCarPermanently => 'خطأ في حذف السيارة نهائيًا:';

  @override
  String get restoreRentalButton => 'استعادة الإيجار';

  @override
  String get permanentDeleteRentalConfirmation =>
      'هل أنت متأكد أنك تريد حذف هذا الإيجار نهائيًا؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get rentalRestoredSuccess => 'تمت استعادة الإيجار بنجاح!';

  @override
  String get errorRestoringRental => 'خطأ في استعادة الإيجار:';

  @override
  String get rentalPermanentlyDeleted => 'تم حذف الإيجار نهائيًا!';

  @override
  String get errorDeletingRentalPermanently => 'خطأ في حذف الإيجار نهائيًا:';

  @override
  String get archivedRentalsAppearHere =>
      'الإيجارات التي تقوم بأرشفتها ستظهر هنا.';
}
