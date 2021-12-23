import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:home_services_provider/app/models/forgot_password.dart';
import '../models/wallet_model.dart';
import '../models/history_model.dart';
import 'auth_interceptor.dart';
import 'redirection_interceptor.dart';
import '../models/document_model.dart';

// import 'package:home_services_provider/app/models/document_model.dart';
// import '../models/CategoryModel.dart';
// import '../models/ServiceModel.dart';
// import '../models/company_model.dart';
// import '../models/doc_proof_type_model.dart';
import '../../common/console.dart';

import '../../common/uuid.dart';
import '../models/address_model.dart';

// import '../models/award_model.dart';
// import '../models/booking_model.dart';
// import '../models/booking_status_model.dart';
// import '../models/category_model.dart';
// import '../models/custom_page_model.dart';
// import '../models/e_provider_model.dart';
// import '../models/e_service_model.dart';
// import '../models/experience_model.dart';
// import '../models/faq_category_model.dart';
// import '../models/faq_model.dart';
// import '../models/notification_model.dart';
// import '../models/option_group_model.dart';
// import '../models/option_model.dart';
// import '../models/payment_model.dart';
// import '../models/review_model.dart';
import '../models/setting_model.dart';

// import '../models/statistic.dart';
import '../models/user_model.dart';
import 'api_provider.dart';
import 'package:http/http.dart' as http;

class LaravelApiClient extends GetxService with ApiClient {
  dio.Dio _httpClient;
  dio.Options _optionsNetwork;
  dio.Options _optionsCache;
  ForgotPassword forgotPassword;

  LaravelApiClient() {
    this.baseUrl = this.globalService.global.value.laravelBaseUrl;
    _httpClient = new dio.Dio();
  }

  Future<LaravelApiClient> init() async {
    if (foundation.kIsWeb || foundation.kDebugMode) {
      _optionsNetwork = dio.Options();
      _optionsCache = dio.Options();
    } else {
      _optionsNetwork =
          buildCacheOptions(Duration(days: 3), forceRefresh: true);
      _optionsCache =
          buildCacheOptions(Duration(minutes: 10), forceRefresh: false);
      _httpClient.interceptors.add(
          DioCacheManager(CacheConfig(baseUrl: getApiBaseUrl(""))).interceptor);
    }
    _httpClient.interceptors
        .addAll([RedirectionInterceptor(), AuthInterceptor()]);
    return this;
  }

  void forceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
      _optionsCache = dio.Options();
    }
  }

  void unForceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
      _optionsCache = buildCacheOptions(duration, forceRefresh: false);
    }
  }

  Future<User> getUser(User user) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getUser() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("provider/user")
        .replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(
      _uri,
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      return User.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<User> login(Map<String, dynamic> data) async {
    Uri _uri = getApiBaseUri("provider/oauth/token");
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.postUri(_uri,
        data: json.encode(data), options: _optionsNetwork);
    Console.log(response.data);
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<User> register(Map<String, dynamic> data) async {
    Uri _uri = getApiBaseUri("provider/register");
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.postUri(_uri,
        data: json.encode(data), options: _optionsNetwork);
    Console.log(response.data);
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> sendResetLinkEmail(Map<String, dynamic> data) async {
    Uri _uri = getApiBaseUri("provider/send_reset_link_email");
    Get.log(_uri.toString());
    // to remove other attributes from the user object
    var response = await _httpClient.postUri(
      _uri,
      data: json.encode(data),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      return true;
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> forgotPass(Map<String, dynamic> data) async{
    var response = await http.post(
        Uri.parse("https://pro.assign.co.nz/api/provider/forgot/password"),
        body: data);
    print("response is" + response.toString());
    // var decode=jsonDecode(response.body);
    forgotPassword=jsonDecode(response.body);
    forgotPassword=jsonDecode(response.body);

  }

  Future<User> updateUser(User user) async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ updateUser() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("provider/users/${user.id}")
        .replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.postUri(
      _uri,
      data: json.encode(user.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      response.data['data']['auth'] = true;
      return User.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  // Future<List<Statistic>> getHomeStatistics() async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ getHomeStatistics() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("provider/dashboard")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<Statistic>((obj) => Statistic.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  Future<List<Address>> getAddresses() async {
    if (!authService.isAuth) {
      throw new Exception(
          "You don't have the permission to access to this area!".tr +
              "[ getAddresses() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'search': "user_id:${authService.user.value.id}",
      'searchFields': 'user_id:=',
    };
    Uri _uri =
        getApiBaseUri("addresses").replace(queryParameters: _queryParameters);
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']
          .map<Address>((obj) => Address.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  // Future<List<EService>> searchEServices(
  //     String keywords, List<String> categories, int page) async {
  //   // TODO Pagination
  //   var _queryParameters = {
  //     'with': 'eProvider;eProvider.addresses;categories',
  //     'search': 'categories.id:${categories.join(',')};name:$keywords',
  //     'searchFields': 'categories.id:in;name:like',
  //     'searchJoin': 'and',
  //   };
  //   Uri _uri =
  //       getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<EService>((obj) => EService.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<EService> getEService(String id) async {
  //   var _queryParameters = {
  //     'with': 'eProvider;categories',
  //   };
  //   if (authService.isAuth) {
  //     _queryParameters['api_token'] = authService.apiToken;
  //   }
  //   Uri _uri = getApiBaseUri("e_services/$id")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return EService.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<EService> createEService(EService eService) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ createEService(EService eService) ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri =
  //       getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   try {
  //     var response = await _httpClient.postUri(
  //       _uri,
  //       data: json.encode(eService.toJson()),
  //       options: _optionsNetwork,
  //     );
  //     if (response.data['success'] == true) {
  //       return EService.fromJson(response.data['data']);
  //     } else {
  //       throw new Exception(response.data['message']);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception(e);
  //   }
  // }
  //
  // Future<EService> updateEService(EService eService) async {
  //   if (!authService.isAuth || !eService.hasData) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ updateEService(EService eService) ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("e_services/${eService.id}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.patchUri(
  //     _uri,
  //     data: json.encode(eService.toJson()),
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     return EService.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<bool> deleteEService(String eServiceId) async {
  //   if (!authService.isAuth || eServiceId == null) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ deleteEService(String eServiceId) ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("e_services/${eServiceId}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.deleteUri(
  //     _uri,
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     return true;
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<Option> createOption(Option option) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ createOption(Option option) ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri =
  //       getApiBaseUri("options").replace(queryParameters: _queryParameters);
  //   print(option.toJson());
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(
  //     _uri,
  //     data: json.encode(option.toJson()),
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     return Option.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<Option> updateOption(Option option) async {
  //   if (!authService.isAuth || !option.hasData) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ updateOption(Option option) ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("options/${option.id}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   print(option.toJson());
  //   var response = await _httpClient.patchUri(
  //     _uri,
  //     data: json.encode(option.toJson()),
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     return Option.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<bool> deleteOption(String optionId) async {
  //   if (!authService.isAuth || optionId == null) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ deleteOption(String optionId) ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("options/${optionId}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.deleteUri(
  //     _uri,
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     return true;
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<EProvider> getEProvider(String eProviderId) async {
  //   const _queryParameters = {
  //     'with': 'eProviderType;availabilityHours;users',
  //   };
  //   Uri _uri = getApiBaseUri("e_providers/$eProviderId")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.statusCode == 200) {
  //     return EProvider.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<EProvider>> getEProviders() async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ getEProviders() ]");
  //   }
  //   var _queryParameters = {
  //     'only': 'id;name',
  //     'orderBy': 'created_at',
  //     'sortedBy': 'desc',
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("provider/e_providers")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<EProvider>((obj) => EProvider.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<Review>> getEProviderReviews(String userId) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ getEProviderReviews() ]");
  //   }
  //   var _queryParameters = {
  //     'with': 'eService;user',
  //     'only': 'id;review;rate;user;eService;created_at',
  //     'orderBy': 'created_at',
  //     'sortedBy': 'desc',
  //     // 'limit': '10',
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("provider/e_service_reviews")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<Review>((obj) => Review.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<Review> getEProviderReview(String reviewId) async {
  //   var _queryParameters = {
  //     'with': 'eService;user',
  //     'only': 'id;review;rate;user;eService',
  //   };
  //   Uri _uri = getApiBaseUri("e_service_reviews/$reviewId")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.statusCode == 200) {
  //     return Review.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<Award>> getEProviderAwards(String eProviderId) async {
  //   var _queryParameters = {
  //     'search': 'e_provider_id:$eProviderId',
  //     'searchFields': 'e_provider_id:=',
  //     'orderBy': 'updated_at',
  //     'sortedBy': 'desc',
  //   };
  //   Uri _uri =
  //       getApiBaseUri("awards").replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<Award>((obj) => Award.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<List<Experience>> getEProviderExperiences(String eProviderId) async {
  //   var _queryParameters = {
  //     'search': 'e_provider_id:$eProviderId',
  //     'searchFields': 'e_provider_id:=',
  //     'orderBy': 'updated_at',
  //     'sortedBy': 'desc',
  //   };
  //   Uri _uri =
  //       getApiBaseUri("experiences").replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<Experience>((obj) => Experience.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<List<EService>> getEProviderFeaturedEServices(int page) async {
  //   var _queryParameters = {
  //     'with': 'eProvider;eProvider.addresses;categories',
  //     'search': 'featured:1',
  //     'searchFields': 'featured:=',
  //     'limit': '4',
  //     'offset': ((page - 1) * 4).toString(),
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("provider/e_services")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<EService>((obj) => EService.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<EService>> getEProviderPopularEServices(int page) async {
  //   // TODO popular eServices
  //   var _queryParameters = {
  //     'with': 'eProvider;eProvider.addresses;categories',
  //     'rating': 'true',
  //     'limit': '4',
  //     'offset': ((page - 1) * 4).toString(),
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("provider/e_services")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<EService>((obj) => EService.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<EService>> getEProviderAvailableEServices(int page) async {
  //   var _queryParameters = {
  //     'with': 'eProvider;eProvider.addresses;categories',
  //     'available_e_provider': 'true',
  //     'limit': '4',
  //     'offset': ((page - 1) * 4).toString(),
  //     'api_token': authService.apiToken
  //   };
  //   Uri _uri = getApiBaseUri("provider/e_services")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<EService>((obj) => EService.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<EService>> getEProviderMostRatedEServices(int page) async {
  //   var _queryParameters = {
  //     //'only': 'id;name;price;discount_price;price_unit;duration;has_media;total_reviews;rate',
  //     'with': 'eProvider;eProvider.addresses;categories',
  //     'rating': 'true',
  //     'limit': '4',
  //     'offset': ((page - 1) * 4).toString(),
  //     'api_token': authService.apiToken
  //   };
  //   Uri _uri = getApiBaseUri("provider/e_services")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<EService>((obj) => EService.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<User>> getEProviderEmployees(String eProviderId) async {
  //   var _queryParameters = {
  //     'with': 'users',
  //     'only':
  //         'users;users.id;users.name;users.email;users.phone_number;users.device_token'
  //   };
  //   Uri _uri = getApiBaseUri("e_providers/$eProviderId")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return response.data['data']['users']
  //         .map<User>((obj) => User.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<List<EService>> getEProviderEServices(int page) async {
  //   var _queryParameters = {
  //     'with': 'eProvider;eProvider.addresses;categories',
  //     'limit': '4',
  //     'offset': ((page - 1) * 4).toString(),
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("provider/e_services")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<EService>((obj) => EService.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<Review>> getEServiceReviews(String eServiceId) async {
  //   var _queryParameters = {
  //     'with': 'user',
  //     'only': 'created_at;review;rate;user',
  //     'search': "e_service_id:$eServiceId",
  //     'orderBy': 'created_at',
  //     'sortBy': 'desc',
  //     'limit': '10',
  //   };
  //   Uri _uri = getApiBaseUri("e_service_reviews")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<Review>((obj) => Review.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<OptionGroup>> getEServiceOptionGroups(String eServiceId) async {
  //   var _queryParameters = {
  //     'with': 'options;options.media',
  //     'only':
  //         'id;name;allow_multiple;options.id;options.name;options.description;options.price;options.option_group_id;options.e_service_id;options.media',
  //     'search': "options.e_service_id:$eServiceId",
  //     'searchFields': 'options.e_service_id:=',
  //     'orderBy': 'name',
  //     'sortBy': 'desc'
  //   };
  //   Uri _uri = getApiBaseUri("option_groups")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<OptionGroup>((obj) => OptionGroup.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<OptionGroup>> getOptionGroups() async {
  //   var _queryParameters = {
  //     'with': 'options',
  //     'only':
  //         'id;name;allow_multiple;options.id;options.name;options.description;options.price;options.option_group_id;options.e_service_id',
  //     'orderBy': 'name',
  //     'sortBy': 'desc'
  //   };
  //   Uri _uri = getApiBaseUri("option_groups")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<OptionGroup>((obj) => OptionGroup.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<Category>> getAllCategories() async {
  //   const _queryParameters = {
  //     'orderBy': 'order',
  //     'sortBy': 'asc',
  //   };
  //   Uri _uri =
  //       getApiBaseUri("categories").replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<Category>((obj) => Category.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<Category>> getAllParentCategories() async {
  //   const _queryParameters = {
  //     'parent': 'true',
  //     'orderBy': 'order',
  //     'sortBy': 'asc',
  //   };
  //   Uri _uri =
  //       getApiBaseUri("categories").replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<Category>((obj) => Category.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<Category>> getAllWithSubCategories() async {
  //   const _queryParameters = {
  //     'with': 'subCategories',
  //     'parent': 'true',
  //     'orderBy': 'order',
  //     'sortBy': 'asc',
  //   };
  //   Uri _uri =
  //       getApiBaseUri("categories").replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<Category>((obj) => Category.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }
  //
  // Future<List<Booking>> getBookings(String statusId, int page) async {
  //   var _queryParameters = {
  //     'with': 'bookingStatus;payment;payment.paymentStatus',
  //     'api_token': authService.apiToken,
  //     'search': 'booking_status_id:${statusId}',
  //     'orderBy': 'created_at',
  //     'sortedBy': 'desc',
  //     'limit': '4',
  //     'offset': ((page - 1) * 4).toString()
  //   };
  //   Uri _uri =
  //       getApiBaseUri("bookings").replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<Booking>((obj) => Booking.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<List<BookingStatus>> getBookingStatuses() async {
  //   var _queryParameters = {
  //     'only': 'id;status;order',
  //     'orderBy': 'order',
  //     'sortedBy': 'asc',
  //   };
  //   Uri _uri = getApiBaseUri("booking_statuses")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<BookingStatus>((obj) => BookingStatus.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<Booking> getBooking(String bookingId) async {
  //   var _queryParameters = {
  //     'with':
  //         'bookingStatus;user;payment;payment.paymentMethod;payment.paymentStatus',
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("bookings/${bookingId}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return Booking.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<Booking> updateBooking(Booking booking) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ updateBooking() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("bookings/${booking.id}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.putUri(_uri,
  //       data: booking.toJson(), options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return Booking.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<Payment> updatePayment(Payment payment) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ updatePayment() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("provider/payments/${payment.id}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.putUri(_uri,
  //       data: payment.toJson(), options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return Payment.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<List<NotificationModel>> getNotifications() async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ getNotifications() ]");
  //   }
  //   var _queryParameters = {
  //     'search': 'notifiable_id:${authService.user.value.id}',
  //     'searchFields': 'notifiable_id:=',
  //     'searchJoin': 'and',
  //     'orderBy': 'created_at',
  //     'sortedBy': 'desc',
  //     'limit': '50',
  //     'only': 'id;type;data;read_at;created_at',
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("notifications")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<Notification>((obj) => NotificationModel.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<NotificationModel> markAsReadNotification(
  //     NotificationModel notification) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ markAsReadNotification() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("notifications/${notification.id}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.patchUri(_uri,
  //       data: notification.markReadMap(), options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return NotificationModel.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<bool> sendNotification(
  //     List<User> users, User from, String type, String text, String id) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ sendNotification() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   var data = {
  //     'users': users.map((e) => e.id).toList(),
  //     'from': from.id,
  //     'type': type,
  //     'text': text,
  //     'id': id,
  //   };
  //   Uri _uri = getApiBaseUri("notifications")
  //       .replace(queryParameters: _queryParameters);
  //   Get.log(_uri.toString());
  //   Get.log(data.toString());
  //   var response =
  //       await _httpClient.postUri(_uri, data: data, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return true;
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<NotificationModel> removeNotification(
  //     NotificationModel notification) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ removeNotification() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("notifications/${notification.id}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.deleteUri(_uri, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return NotificationModel.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<int> getNotificationsCount() async {
  //   if (!authService.isAuth) {
  //     return 0;
  //   }
  //   var _queryParameters = {
  //     'search': 'notifiable_id:${authService.user.value.id}',
  //     'searchFields': 'notifiable_id:=',
  //     'searchJoin': 'and',
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("notifications/count")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
  //   if (response.data['success'] == true) {
  //     return response.data['data'];
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<List<FaqCategory>> getFaqCategories() async {
  //   var _queryParameters = {
  //     'orderBy': 'created_at',
  //     'sortedBy': 'asc',
  //   };
  //   Uri _uri = getApiBaseUri("faq_categories")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<FaqCategory>((obj) => FaqCategory.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<List<Faq>> getFaqs(String categoryId) async {
  //   var _queryParameters = {
  //     'search': 'faq_category_id:${categoryId}',
  //     'searchFields': 'faq_category_id:=',
  //     'searchJoin': 'and',
  //     'orderBy': 'updated_at',
  //     'sortedBy': 'desc',
  //   };
  //   Uri _uri = getApiBaseUri("faqs").replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<Faq>((obj) => Faq.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  Future<Setting> getSettings() async {
    // Uri _uri = Uri.parse("https://pro.assign.co.nz/admin/settings");
    Uri _uri = getBaseUri("admin/settings");
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    Console.log(response.data);
    if (response.statusCode == 200) {
      return Setting.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  // Future<List<CustomPage>> getCustomPages() async {
  //   var _queryParameters = {
  //     'only': 'id;title',
  //     'search': 'published:1',
  //     'orderBy': 'created_at',
  //     'sortedBy': 'asc',
  //   };
  //   Uri _uri = getApiBaseUri("custom_pages")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<CustomPage>((obj) => CustomPage.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<CustomPage> getCustomPageById(String id) async {
  //   Uri _uri = getApiBaseUri("custom_pages/$id");
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.data['success'] == true) {
  //     return CustomPage.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<String> uploadImage(File file, String field) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ uploadImage() ]");
  //   }
  //   String fileName = file.path.split('/').last;
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("uploads/store")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   dio.FormData formData = dio.FormData.fromMap({
  //     "file": await dio.MultipartFile.fromFile(file.path, filename: fileName),
  //     "uuid": Uuid().generateV4(),
  //     "field": field,
  //   });
  //   var response = await _httpClient.postUri(_uri, data: formData);
  //   print(response.data);
  //   if (response.data['data'] != false) {
  //     return response.data['data'];
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<bool> deleteUploaded(String uuid) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ deleteUploaded() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("uploads/clear")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(_uri, data: {'uuid': uuid});
  //   print(response.data);
  //   if (response.data['data'] != false) {
  //     return true;
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<bool> deleteAllUploaded(List<String> uuids) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "You don't have the permission to access to this area!".tr +
  //             "[ deleteUploaded() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   Uri _uri = getApiBaseUri("uploads/clear")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(_uri, data: {'uuid': uuids});
  //   print(response.data);
  //   if (response.data['data'] != false) {
  //     return true;
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<List<CompanyModel>> getAllCompany() async {
  //   Uri _uri = getApiBaseUri("provider/fetchcompany");
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(
  //     _uri,
  //   );
  //   Console.log(response.data);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<CompanyModel>((obj) => CompanyModel.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  //   // if (response.statusCode == 200) {
  //   //   return EProvider.fromJson(response.data['data']);
  //   // } else {
  //   //   throw new Exception(response.statusMessage);
  //   // }
  // }
  //
  // Future<List<CategoryModel>> getAllCategory() async {
  //   Uri _uri = getApiBaseUri("categories");
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(
  //     _uri,
  //   );
  //   Console.log(response.data);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<CategoryModel>((obj) => CategoryModel.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  //   // if (response.statusCode == 200) {
  //   //   return EProvider.fromJson(response.data['data']);
  //   // } else {
  //   //   throw new Exception(response.statusMessage);
  //   // }
  // }
  //
  // Future<List<ServiceModel>> getAllServices() async {
  //   Uri _uri = getApiBaseUri("e_services");
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(
  //     _uri,
  //   );
  //   Console.log(response.data);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<ServiceModel>((obj) => ServiceModel.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  //   // if (response.statusCode == 200) {
  //   //   return EProvider.fromJson(response.data['data']);
  //   // } else {
  //   //   throw new Exception(response.statusMessage);
  //   // }
  // }
  //
  // Future<List<DocProofTypeModel>> getIdProofTypes() async {
  //   Uri _uri = getApiBaseUri("provider/idproof");
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(_uri);
  //   Console.log(response.data);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<DocProofTypeModel>((obj) => DocProofTypeModel.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  //   // if (response.statusCode == 200) {
  //   //   return EProvider.fromJson(response.data['data']);
  //   // } else {
  //   //   throw new Exception(response.statusMessage);
  //   // }
  // }
  //
  // Future<List<DocProofTypeModel>> getAddressProofTypes() async {
  //   Uri _uri = getApiBaseUri("provider/addressproof");
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(
  //     _uri,
  //   );
  //   Console.log(response.data);
  //   if (response.statusCode == 200) {
  //     return response.data['data']
  //         .map<DocProofTypeModel>((obj) => DocProofTypeModel.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  //   // if (response.statusCode == 200) {
  //   //   return EProvider.fromJson(response.data['data']);
  //   // } else {
  //   //   throw new Exception(response.statusMessage);
  //   // }
  // }
  //
  // Future setOffering(Map<String, dynamic> data) async {
  //   Uri _uri = getApiBaseUri("provider/profile_update");
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(
  //     _uri,
  //     data: json.encode(data),
  //     options: _optionsNetwork.copyWith(
  //         headers: {"Accept": "application/json"},
  //         followRedirects: false,
  //         validateStatus: (status) {
  //           return status < 500;
  //         }),
  //   );
  //   Console.log(response.data);
  //   if (response.data['success'] == true) {
  //     response.data['data']['auth'] = true;
  //     // return User.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future uploadDocuments(Map<String, dynamic> data) async {
  //   Uri _uri = getApiBaseUri("provider/register_3");
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(
  //     _uri,
  //     data: dio.FormData.fromMap(data),
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     response.data['data']['auth'] = true;
  //     // return User.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  Future<List<DocumentModel>> getDocuments() async {
    Uri _uri = getApiBaseUri("provider/profile/documents");
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    Console.log(response.data);
    if (response.statusCode == 200) {
      return response.data['documents']
          .map<DocumentModel>((obj) => DocumentModel.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.data['message']);
    }
    // if (response.statusCode == 200) {
    //   return EProvider.fromJson(response.data['data']);
    // } else {
    //   throw new Exception(response.statusMessage);
    // }
  }

  Future<List<DocumentModel>> uploadProviderDocuments(
      Map<String, dynamic> data) async {
    Uri _uri = getApiBaseUri("provider/profile/documents/store");
    printUri(StackTrace.current, _uri);
    Console.log(data);
    var response = await _httpClient.postUri(
      _uri,
      data: dio.FormData.fromMap(data),
      options: _optionsNetwork,
    );
    Console.log('response.body${response.data}');
    if (response.statusCode == 200) {
      // response.data['data']['auth'] = true;
      return response.data['documents']
          .map<DocumentModel>((obj) => DocumentModel.fromJson(obj))
          .toList();
      // return User.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<String> getUserStatus() async {
    Uri _uri = getApiBaseUri("provider/providerrecord");
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    Console.log(response.data);
    if (response.statusCode == 200) {
      return response.data['status'];
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<HistoryModel>> getAllHistory() async {
    Uri _uri = getApiBaseUri("provider/requests/history");
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri,
        options: _optionsNetwork
            .copyWith(headers: {'X-Requested-With': 'XMLHttpRequest'}));
    Console.log('response.body${response.data}');
    // if (response.statusCode == 200) {
    return response.data
        .map<HistoryModel>((obj) => HistoryModel.fromJson(obj))
        .toList();
    // } else {
    //   throw new Exception(response.data['message']);
    // }
  }

  Future<WalletModel> getWalletTransactions() async {
    Uri _uri = getApiBaseUri("provider/wallettransaction");
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    Console.log(response.data);
    if (response.statusCode == 200) {
      return WalletModel.fromJson(response.data);
    } else {
      throw new Exception(response.data['message']);
    }
  }
}
