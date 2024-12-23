import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_models.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, CartModels>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<Map<String, CartModels>> {
  CartNotifier() : super({});

  void addProductToCart({
    required String productName,
    required double productPrice,
    required String categoryName,
    required List imageUrl,
    required int quantity,
    required int instock,
    required String productid,
    required String productSize,
    required int discount,
    required String description,
  }) {
    if (state.containsKey(productid)) {
      // Update existing product quantity
      final updatedCart = Map<String, CartModels>.from(state);
      updatedCart[productid] = CartModels(
        productName: state[productid]!.productName,
        productPrice: state[productid]!.productPrice,
        categoryName: state[productid]!.categoryName,
        imageUrl: state[productid]!.imageUrl,
        quantity: state[productid]!.quantity + 1,
        instock: state[productid]!.instock,
        productid: state[productid]!.productid,
        productSize: state[productid]!.productSize,
        discount: state[productid]!.discount,
        description: state[productid]!.description,
      );
      state = updatedCart;
    } else {
      // Add new product
      final updatedCart = Map<String, CartModels>.from(state);
      updatedCart[productid] = CartModels(
        productName: productName,
        productPrice: productPrice,
        categoryName: categoryName,
        imageUrl: imageUrl,
        quantity: quantity,
        instock: instock,
        productid: productid,
        productSize: productSize,
        discount: discount,
        description: description,
      );
      state = updatedCart;
    }
  }

  void removeProductFromCart(String productid) {
    final updatedCart = Map<String, CartModels>.from(state);
    updatedCart.remove(productid);
    state = updatedCart;
  }

  void incrementQuantity(String productid) {
    if (state.containsKey(productid)) {
      final updatedCart = Map<String, CartModels>.from(state);
      updatedCart[productid] = CartModels(
        productName: state[productid]!.productName,
        productPrice: state[productid]!.productPrice,
        categoryName: state[productid]!.categoryName,
        imageUrl: state[productid]!.imageUrl,
        quantity: state[productid]!.quantity + 1,
        instock: state[productid]!.instock,
        productid: state[productid]!.productid,
        productSize: state[productid]!.productSize,
        discount: state[productid]!.discount,
        description: state[productid]!.description,
      );
      state = updatedCart;
    }
  }

  void decrementQuantity(String productid) {
    if (state.containsKey(productid)) {
      final updatedCart = Map<String, CartModels>.from(state);
      if (state[productid]!.quantity > 1) {
        updatedCart[productid] = CartModels(
          productName: state[productid]!.productName,
          productPrice: state[productid]!.productPrice,
          categoryName: state[productid]!.categoryName,
          imageUrl: state[productid]!.imageUrl,
          quantity: state[productid]!.quantity - 1,
          instock: state[productid]!.instock,
          productid: state[productid]!.productid,
          productSize: state[productid]!.productSize,
          discount: state[productid]!.discount,
          description: state[productid]!.description,
        );
        state = updatedCart;
      } else {
        removeProductFromCart(productid);
      }
    }
  }

  Map<String, CartModels> get cartItems => state;
}