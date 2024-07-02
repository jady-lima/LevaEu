// api_client.dart
import 'package:dio/dio.dart';
import 'package:levaeu_mobile/model/race.dart';

class ApiClient {
  final Dio _dio = Dio();

  final String baseUrl = 'http://192.168.87.243:8080';

  Future<Response> register(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$baseUrl/auth/register', data: data);
      return response;
    } catch (e) {
      throw Exception('Erro ao cadastrar usuário ${e.toString()}');
    }
  }

  Future<Response> registerCNH(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$baseUrl/api/cnhs', data: data);
      return response;
    } catch (e) {
      throw Exception('Erro ao cadastrar CNH');
    }
  }

  Future<Response> registerVehicle(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$baseUrl/api/veiculos', data: data);
      return response;
    } catch (e) {
      throw Exception('Erro ao cadastrar veículo: ${e.toString()}');
    }
  }

  Future<Response> registerComplete(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$baseUrl/api/veiculos', data: data);
      return response;
    } catch (e) {
      throw Exception('Erro ao cadastrar completo: ${e.toString()}');
    }
  }

  Future<Response> login(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('$baseUrl/auth/login', data: data);
      return response;
    } catch (e) {
      throw Exception('Erro ao fazer login: ${e.toString()}');
    }
  }

  Future<Response> createRace(Map<String, dynamic> data, String token) async {
    try {
      final response = await _dio.post(
        '$baseUrl/api/rides',
         data: data,
         options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          )
         );
      return response;
    } catch (e) {
      throw Exception('Erro ao criar corrida: ${e}');
    }
  }

  Future<Response> fetchOpenRaces(String token, String id) async {
    try {
      final response = await _dio.get(
        '$baseUrl/api/rides/list/$id',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar corridas abertas');
    }
  }

  Future<Response> fetchDriverRaces(String token, String driverId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/api/rides/driver/$driverId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar corridas do motorista');
    }
  }

  Future<Response> submitUserRequest(Map<String, dynamic> data, String token) async {
    try {
      final response = await _dio.post(
        '$baseUrl/api/request-ride',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao enviar requisição do usuário: ${e.toString()}');
    }
  }

  Future<Response> getPassengerRequests(String token, int rideId) async {
    try {
      final response = await _dio.get('$baseUrl/api/request-ride/$rideId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar solicitações de carona');
    }
  }

  Future<void> confirmPassengerRequest(String token, int userId, int rideId) async {
    try {
      print('Corpo da requisição para confirmação: { userId: $userId, rideId: $rideId }');
      final response = await _dio.post('$baseUrl/api/request-ride/confirm/$userId/$rideId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode != 200) {
        throw Exception('Erro ao confirmar passageiro: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao confirmar passageiro: $e');
    }
  }

  Future<void> removePassengerRequest(String token, int userId, int rideId) async {
    try {
      print('Corpo da requisição para remoção: { userId: $userId, rideId: $rideId }');
      final response = await _dio.delete('$baseUrl/api/request-ride/confirm/$userId/$rideId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode != 200) {
        throw Exception('Erro ao remover passageiro: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao remover passageiro: $e');
    }
  }
}

