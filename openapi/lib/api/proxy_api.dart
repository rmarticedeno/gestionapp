//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.6

// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';

import 'package:openapi/model/quota_response.dart';

class ProxyApi {

    final Dio _dio;

    final Serializers _serializers;

    const ProxyApi(this._dio, this._serializers);

    /// 
    ///
    /// Get proxy quota status
    Future<Response<QuotaResponse>> proxyQuotaStatus({ 
        CancelToken cancelToken,
        Map<String, dynamic> headers,
        Map<String, dynamic> extra,
        ValidateStatus validateStatus,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
    }) async {
        final String _path = '/proxy/quota';

        final queryParams = <String, dynamic>{};
        final headerParams = <String, dynamic>{ 
            if (headers != null) ...headers,
        };
        dynamic bodyData;

        queryParams.removeWhere((key, dynamic value) => value == null);
        headerParams.removeWhere((key, dynamic value) => value == null);

        final contentTypes = <String>[];

        return _dio.request<dynamic>(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
                method: 'get'.toUpperCase(),
                headers: headerParams,
                extra: <String, dynamic>{
                    'secure': <Map<String, String>>[
                        {
                            'type': 'http',
                            'name': 'bearerAuth',
                        },
                    ],
                    if (extra != null) ...extra,
                },
                validateStatus: validateStatus,
                contentType: contentTypes.isNotEmpty ? contentTypes[0] : 'application/json',
            ),
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
        ).then((response) {
            final serializer = _serializers.serializerForType(QuotaResponse) as Serializer<QuotaResponse>;
            final data = _serializers.deserializeWith<QuotaResponse>(
                serializer,
                response.data is String ? jsonDecode(response.data as String) : response.data,
            );

            return Response<QuotaResponse>(
                data: data,
                headers: response.headers,
                isRedirect: response.isRedirect,
                request: response.request,
                redirects: response.redirects,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                extra: response.extra,
            );
        });
    }

}
