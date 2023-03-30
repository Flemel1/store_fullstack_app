import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:store_mobile/domain/models/requests/register_request.dart';
import 'package:store_mobile/domain/models/user.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/register_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/events/register_event.dart';
import 'package:store_mobile/utils/const/variable.dart';
import 'package:store_mobile/utils/helpers/helper.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _key = GlobalKey<FormState>();

  File? _uploadedFile;
  String? locationPermissionMessage;
  bool isLoading = true;

  void _loadPhotoFile() async {
    FilePickerResult? photo = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);
    if (photo != null) {
      PlatformFile file = photo.files.first;
      setState(() {
        _uploadedFile = File(file.path!);
      });
    }
  }

  void _onSubmit({required RegisterBloc bloc}) {
    if (_key.currentState!.validate() && _uploadedFile != null) {
      final user = User(
          name: _nameController.text,
          email: _emailController.text,
          address: _addressController.text,
          phone: _phoneController.text,
          password: _passwordController.text);
      final RegisterRequest request =
          RegisterRequest(user: user, file: _uploadedFile!);
      bloc.add(RegisterUser(request: request));
      appRouter.pop();
    }
  }

  Future<Position> _initializeUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('GPS tidak aktif.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied, please go to settings");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission denied, please go to settings");
    }

    return await Geolocator.getCurrentPosition();
  }

  void _init() async {
    try {
      final position = await _initializeUserPosition();
      final List<Placemark> placeMarks = await placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: 'en_US');
      final place = placeMarks.first;
      _addressController.text =
          "${place.thoroughfare}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
      setState(() {
        isLoading = false;
      });
    } on Exception catch (error, _) {
      setState(() {
        locationPermissionMessage = error.toString();
        isLoading = false;
      });
      if (locationPermissionMessage != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(locationPermissionMessage!)));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Register Page',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Form(
                      key: _key,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _nameController,
                              validator: Helper.nameValidation,
                              decoration: InputDecoration(
                                hintText: 'Nama',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _emailController,
                              validator: Helper.emailValidation,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              validator: Helper.passwordValidation,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _addressController,
                              validator: Helper.streetValidation,
                              decoration: InputDecoration(
                                hintText: 'Alamat',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _phoneController,
                              validator: Helper.phoneValidation,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Nomor Telepon',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: _loadPhotoFile,
                              child: Text('Pilih Foto'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              _uploadedFile == null
                                  ? 'Foto Belum Dipilih'
                                  : 'Foto Berhasil Diload',
                              softWrap: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  _onSubmit(bloc: context.read<RegisterBloc>()),
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
