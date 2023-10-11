import 'package:dsm_helper/apis/app_api/app_api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_api.dart';

export 'package:dsm_helper/apis/dsm_api/dsm_response.dart';
export 'package:dsm_helper/apis/dsm_api/dsm_exception.dart';

class Api {
  static DsmApi dsm = DsmApi();
  static AppApi app = AppApi();
}
