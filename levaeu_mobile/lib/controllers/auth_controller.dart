// auth_controller.dart
import 'package:dio/dio.dart';
import 'package:levaeu_mobile/api/api_client.dart';

class AuthController {
  final ApiClient apiClient;

  AuthController({required this.apiClient});

  Future<Response> registerUser(Map<String, dynamic> data) async {
    return await apiClient.register(data);
  }

  Future<Response> registerCNH(Map<String, dynamic> data) async {
    return await apiClient.registerCNH(data);
  }

  Future<Response> registerVehicle(Map<String, dynamic> data) async {
    return await apiClient.registerVehicle(data);
  }

  Future<Response> registerComplete(Map<String, dynamic> data) async {
    return await apiClient.registerComplete(data);
  }
}
