import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mobile/domain/models/product.dart';
import 'package:store_mobile/presentation/viewmodels/blocs/product_bloc.dart';
import 'package:store_mobile/presentation/viewmodels/events/product_event.dart';
import 'package:store_mobile/presentation/viewmodels/states/product_state.dart';
import 'package:store_mobile/utils/const/enum.dart';
import 'package:store_mobile/utils/const/variable.dart';
import 'package:store_mobile/utils/helpers/helper.dart';

@RoutePage()
class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  Widget _showDecreaseButton(
      Product product, ProductBloc bloc, List<Product> products) {
    if (product.pcs > 0) {
      return ElevatedButton(
          onPressed: () => _decreaseProduct(
              bloc: bloc, product: product, products: products),
          child: const Text('-'));
    }

    return const SizedBox.shrink();
  }

  void _increaseProduct(
      {required ProductBloc bloc,
      required Product product,
      required List<Product> products}) {
    final isFound = products.indexWhere((element) => element.id == product.id);
    if (isFound != -1) {
      bloc.add(IncreasedProduct(product: product));
    } else {
      bloc.add(AddNewProduct(product: product));
    }
  }

  void _decreaseProduct(
      {required ProductBloc bloc,
      required Product product,
      required List<Product> products}) {
    final isFound = products.indexWhere((product) => product.id == product.id);
    if (isFound != -1) {
      final tempProduct = products[isFound];
      if (tempProduct.pcs > 1) {
        bloc.add(DecreasedProduct(product: product));
      } else {
        bloc.add(RemoveProduct(product: product));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.status == Status.success) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(state.product!.photoUrl, fit: BoxFit.cover, height: 250, width: double.infinity,),
                      Text(
                        state.product!.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        state.product!.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Stocks : ${state.product!.stocks}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          _showDecreaseButton(
                              Helper.findProductAtList(
                                  state.products, state.product!),
                              context.read<ProductBloc>(),
                              state.products),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            '${Helper.findProductAtList(state.products, state.product!).pcs}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                              onPressed: () => _increaseProduct(
                                  bloc: context.read<ProductBloc>(),
                                  product: Helper.findProductAtList(
                                      state.products, state.product!),
                                  products: state.products),
                              child: const Text('+')),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (state.status == Status.error) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Oops Terjadi Error', softWrap: true,),
                ),
              );
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
