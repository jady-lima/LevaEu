import 'package:levaeu_mobile/model/driver_car.dart';
import 'package:levaeu_mobile/model/driver_license.dart';
import 'package:levaeu_mobile/model/user_data.dart';

class DriverUser extends UserData{
  @override
  final DriverLicense? driverLicense;
  @override
  final DriverCar? driverCar;

  DriverUser({
    required String name,
    required String email,
    required String matricula,
    required String phone,
    required String cep,
    required String street,
    required String number,
    required String district,
    required String city,
    required String state,
    required String country,
    required String pass,
    required String gender,
    this.driverLicense,
    this.driverCar,
  }) : super ( 
    name: name,
    email: email,
    matricula: matricula,
    phone: phone,
    cep: cep,
    street: street,
    number: number,
    district: district,
    city: city,
    state: state,
    country: country,
    pass: pass,
    gender: gender,
  );
}