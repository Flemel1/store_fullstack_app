import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mobile/domain/models/product.dart';
import 'package:store_mobile/domain/models/requests/checkout_request.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/checkout_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/product_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/events/checkout_event.dart';
import 'package:store_mobile/presentation/viewmodels/events/product_event.dart';
import 'package:store_mobile/presentation/viewmodels/states/product_state.dart';
import 'package:store_mobile/utils/const/variable.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  void _checkout(CheckoutBloc bloc, ProductBloc prooductBloc, List<Product> products) {
    final List<CheckoutItem> body = products.map<CheckoutItem>((product) {
      return CheckoutItem(id: product.id, pcs: product.pcs);
    }).toList();
    final request = CheckoutRequest(checkoutProducts: body);
    bloc.add(CheckoutProducts(request: request));
    prooductBloc.add(ResetCartProducts());
    appRouter.popUntilRoot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.products.isNotEmpty) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<ProductBloc>()
                              .add(GetProduct(id: state.products[index].id));
                          appRouter.pushNamed('/product');
                        },
                        child: SizedBox(
                          height: 150,
                          child: Card(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4 +
                                      20,
                                  child: Image.network(
                                    state.products[index].photoUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    '${state.products[index].name} - ${state.products[index].pcs} X',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () => _checkout(context.read<CheckoutBloc>(), context.read<ProductBloc>(), state.products),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) => Colors.blue)),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Text(
                'Maaf Produk Tidak Ada, Silahkan Tambah Produk',
                style: Theme.of(context).textTheme.titleMedium,
                softWrap: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
