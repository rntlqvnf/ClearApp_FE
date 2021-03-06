import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobx/mobx.dart';

import '../../util/http_client.dart';
import '../../vo/user/user.dart';
import '../error/error_store.dart';
import '../success/success_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  // other stores:--------------------------------------------------------------
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // store variables:-----------------------------------------------------------
  @observable
  bool loading = false;

  // other variables:-----------------------------------------------------------
  final GlobalKey<FormBuilderState> fbKey = new GlobalKey<FormBuilderState>();

  User user;

  // actions:-------------------------------------------------------------------
  @action
  Future login() async {
    if (loading) return; //No login during login

    loading = true;
    if (fbKey.currentState.saveAndValidate()) {
      String povisId = fbKey.currentState.value['povisId'];
      int studentId = fbKey.currentState.value['studentId'];
      Map<String, dynamic> body = {'studentId': studentId, 'povisId': povisId};

      HttpClient.send(method: "POST", address: "/api/clear/login", body: body)
          .then((response) {
            String token = response['token'];
            HttpClient.token = token;
            user = User.fromJson(JwtDecoder.decode(token));
            updateOnSuccess("Login Success");
          })
          .catchError((e) => updateOnError(e.cause))
          .whenComplete(() => loading = false);
    } else {
      loading = false;
    }
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    errorStore.dispose();
    successStore.dispose();
    for (final d in disposers) {
      d();
    }
  }

  // functions:-----------------------------------------------------------------
  void updateOnError(String message) {
    errorStore.errorMessage = message;
    errorStore.error = true;
  }

  void updateOnSuccess(String message) {
    successStore.successMessage = message;
    successStore.success = true;
  }
}
