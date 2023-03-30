import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_mobile/config/routers/app_router.gr.dart';
import 'package:store_mobile/locator.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/home_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/login_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/product_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/events/home_event.dart';
import 'package:store_mobile/presentation/viewmodels/events/product_event.dart';
import 'package:store_mobile/presentation/viewmodels/states/home_state.dart';
import 'package:store_mobile/utils/const/enum.dart';
import 'package:store_mobile/utils/const/string.dart';
import 'package:store_mobile/utils/const/variable.dart';

import '../viewmodels/states/login_state.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  String? photoUrl;

  void _logout() async {
    final storage = locator<FlutterSecureStorage>();
    await storage.delete(key: 'jwt');
    appRouter.replaceAll([const LoginRoute()]);
  }

  Future<void> _showLogoutDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Apakah anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: _logout,
              child: const Text('Logout'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _initUserPreference() async {
    final storage = locator<FlutterSecureStorage>();
    String namePref = await storage.read(key: 'user_name') ?? 'User Name';
    String? photoUrlPref = await storage.read(key: 'user_photo');
    setState(()  {
      name = namePref;
      photoUrl = photoUrlPref;
    });
  }

  @override
  void initState() {
    super.initState();
    _initUserPreference();
  }

  @override
  Widget build(BuildContext context) {
    final LoginState loginsState = context.read<LoginBloc>().state;
    context.read<HomeBloc>().add(FetchProducts());
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? 'User Name'),
        actions: [
          InkWell(
            onTap: () => _showLogoutDialog(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(photoUrl ?? userImage),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == Status.success && state.products!.isNotEmpty) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: state.products!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<ProductBloc>()
                          .add(GetProduct(id: state.products![index].id));
                      appRouter.pushNamed('/product');
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Image.network(
                                  state.products![index].photoUrl,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              state.products![index].name,
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state.status == Status.success &&
                state.products!.isEmpty) {
              return Center(
                child: Text(
                  'Maaf Item Tidak Ada',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            } else if (state.status == Status.error && !loginsState.isLogin) {
              appRouter.replaceNamed('/login');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appRouter.pushNamed('/cart');
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
