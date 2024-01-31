import 'package:get/get.dart';
import 'package:jdolh_customers/core/localization/words/auth/login.dart';
import 'package:jdolh_customers/core/localization/words/auth/signup.dart';
import 'package:jdolh_customers/core/localization/words/home.dart';
import 'package:jdolh_customers/core/localization/words/language.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'Buy Now': 'شراء الان',
          'Add to card': 'اضافة الى السلة',
          // ========  Language ===========//
          WordsLanguage.wordKey1: WordsLanguage.arWordValue1,
          WordsLanguage.wordKey2: WordsLanguage.arWordValue2,
          WordsLanguage.wordKey3: WordsLanguage.arWordValue3,
          // ========= Home ==============//
          WordsHome.wordKey1: WordsHome.arWordValue1,
          // ======== Signup ==============//
          WordsSignup.wordKey1: WordsSignup.arWordValue1,
          WordsSignup.wordKey2: WordsSignup.arWordValue2,
          WordsSignup.wordKey3: WordsSignup.arWordValue3,
          // =========== Login =============/
          WordsLogin.wordKey1: WordsLogin.arWordValue1,
          WordsLogin.wordKey2: WordsLogin.arWordValue2,
          WordsLogin.wordKey3: WordsLogin.arWordValue3,
        },
        'en': {
          'Buy Now': 'Buy Now',
          'Add to card': 'Add to card',
          // ========== Language ===========//
          WordsLanguage.wordKey1: WordsLanguage.enWordValue1,
          WordsLanguage.wordKey2: WordsLanguage.enWordValue2,
          WordsLanguage.wordKey3: WordsLanguage.enWordValue3,
          // ========= Home ==============//
          WordsHome.wordKey1: WordsHome.enWordValue1,
          // =========== Signup ============//
          WordsSignup.wordKey1: WordsSignup.enWordValue1,
          WordsSignup.wordKey2: WordsSignup.enWordValue2,
          WordsSignup.wordKey3: WordsSignup.enWordValue3,
          // =========== Login =============//
          WordsLogin.wordKey1: WordsLogin.enWordValue1,
          WordsLogin.wordKey2: WordsLogin.enWordValue2,
          WordsLogin.wordKey3: WordsLogin.enWordValue3,
        }
      };
}
