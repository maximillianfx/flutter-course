import 'package:dio/dio.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repositories/api_error.dart';
import 'package:xlo/repositories/api_response.dart';

Future<ApiResponse> getAddressFromApi(String postalCode) async {
  final String endPoint = "http://viacep.com.br/ws/${postalCode.replaceAll('.','').replaceAll('-', '')}/json/";

  try {
    final Response response = await Dio().get<Map>(endPoint);

    if (response.data.containsKey('erro') && response.data['erro']) {
      return ApiResponse.error(
        error: ApiError(
          code: response.statusCode,
          message: 'CEP invalido'
        )
      );
    }

    final Address address = Address(
        place: response.data['logradouro'],
        district: response.data['bairro'],
        city: response.data['localidade'],
        postalCode: response.data['cep'],
        federativeUnit: response.data['uf']
    );



    return ApiResponse.success(
      result: address
    );
  } on DioError catch(e) {
    return ApiResponse.error(
      error: ApiError(
        code: e.response.statusCode,
        message: "Falha ao conectar VIACEP"
      )
    );
  }
}