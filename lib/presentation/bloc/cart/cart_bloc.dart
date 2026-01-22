import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';
import 'package:foody_licious/domain/entities/cart/cartPricing.dart';
import 'package:foody_licious/domain/usecase/cart/add_item_to_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/decrease_item_quantity_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/delete_item_in_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/get_all_cart_item_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/get_cart_pricing_details_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/increase_item_quantity_usecase.dart';
import '../../../core/error/failures.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> _cachedCartItems = [];
  final GetAllCartItemUseCase _getAllCartItemUseCase;
  final GetCartPricingDetailsUseCase _getCartPricingDetailsUseCase;
  final AddItemToCartUseCase _addItemToCartUseCase;
  final DeleteItemInCartUseCase _deleteItemInCartUseCase;
  final IncreaseItemQuantityUseCase _increaseItemQuantityUseCase;
  final DecreaseItemQuantityUseCase _decreaseItemQuantityUseCase;
  CartBloc(
      this._getAllCartItemUseCase,
      this._getCartPricingDetailsUseCase,
      this._addItemToCartUseCase,
      this._deleteItemInCartUseCase,
      this._increaseItemQuantityUseCase,
      this._decreaseItemQuantityUseCase)
      : super(CartInitial()) {
    on<GetAllCartItem>(_onGetAllCartItem);
    on<GetCartPricingDetails>(_onGetCartPricingDetails);
    on<AddItemToCart>(_onAddItemToCart);
    on<DeleteItemInCart>(_onDeleteItemInCart);
    on<IncreaseItemQuantity>(_onIncreaseItemQuantity);
    on<DecreaseItemQuantity>(_onDecreaseItemQuantity);
  }

  FutureOr<void> _onGetAllCartItem(
      GetAllCartItem event, Emitter<CartState> emit) async {
    try {
      // Only show loading for first page
      if (event.params.page == 1) {
        emit(GetAllCartItemLoading());
      }

      final result = await _getAllCartItemUseCase(event.params);
      result.fold((failure) => emit(GetAllCartItemFailed(failure)), (
        newItems,
      ) {
        final currentState = state;
        if (currentState is GetAllCartItemSuccess) {
          final updatedList = event.params.page == 1
              ? newItems
              : [...currentState.cartItems, ...newItems];
          emit(GetAllCartItemSuccess(updatedList));
          _cachedCartItems = updatedList;
        } else {
          emit(GetAllCartItemSuccess(newItems));
          _cachedCartItems = newItems;
        }
      });
    } catch (e) {
      emit(GetAllCartItemFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onGetCartPricingDetails(
      GetCartPricingDetails event, Emitter<CartState> emit) async {
    try {
      emit(GetCartPricingDetailsLoading());
      final result = await _getCartPricingDetailsUseCase(event.params);
      result.fold(
        (failure) {
          emit(GetCartPricingDetailsFailed(failure));

          // 🔁 Restore cart state
          if (_cachedCartItems.isNotEmpty) {
            emit(GetAllCartItemSuccess(_cachedCartItems));
          }
        },
        (cartPricingDetails) {
          emit(GetCartPricingDetailsSuccess(cartPricingDetails));

          // 🔁 Restore cart state AFTER success
          if (_cachedCartItems.isNotEmpty) {
            emit(GetAllCartItemSuccess(_cachedCartItems));
          }
        },
      );
    } catch (e) {
      emit(GetCartPricingDetailsFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onAddItemToCart(
      AddItemToCart event, Emitter<CartState> emit) async {
    try {
      emit(AddItemToCartLoading());
      final result = await _addItemToCartUseCase(event.params);
      result.fold(
        (failure) => emit(AddItemToCartFailed(failure)),
        (unit) => emit(
          AddItemToCartSuccess(unit),
        ),
      );
    } catch (e) {
      emit(AddItemToCartFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onDeleteItemInCart(
      DeleteItemInCart event, Emitter<CartState> emit) async {
    try {
      final currentState = state;
      if (currentState is GetAllCartItemSuccess) {
        final result = await _deleteItemInCartUseCase(event.params);
        result.fold(
          (failure) {
            emit(DeleteItemInCartFailed(failure));
            emit(GetAllCartItemSuccess(currentState.cartItems));
          },
          (unit) {
            currentState.cartItems.removeWhere(
              (item) => item.menuItemId == event.params.menuItemId,
            );
            emit(DeleteItemInCartSuccess(unit));
            emit(GetAllCartItemSuccess(currentState.cartItems));
          },
        );
      }
    } catch (e) {
      emit(DeleteItemInCartFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onIncreaseItemQuantity(
      IncreaseItemQuantity event, Emitter<CartState> emit) async {
    try {
      final currentState = state;
      if (currentState is GetAllCartItemSuccess) {
        final result = await _increaseItemQuantityUseCase(event.params);
        result.fold(
          (failure) {
            emit(IncreaseItemQuantityFailed(failure));
            emit(GetAllCartItemSuccess(currentState.cartItems));
          },
          (updatedCartItem) {
            final updatedList = currentState.cartItems.map((item) {
              return item.menuItemId == updatedCartItem.menuItemId
                  ? updatedCartItem
                  : item;
            }).toList();
            emit(GetAllCartItemSuccess(updatedList));
          },
        );
      }
    } catch (e) {
      emit(IncreaseItemQuantityFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _onDecreaseItemQuantity(
    DecreaseItemQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is GetAllCartItemSuccess) {
        final result = await _decreaseItemQuantityUseCase(event.params);
        result.fold(
          (failure) {
            emit(DecreaseItemQuantityFailed(failure));
            emit(GetAllCartItemSuccess(currentState.cartItems));
          },
          (updatedCartItem) {
            List<CartItem> updatedList;
            if (updatedCartItem != null) {
              // Update quantity
              updatedList = currentState.cartItems.map((item) {
                return item.menuItemId == updatedCartItem.menuItemId
                    ? updatedCartItem
                    : item;
              }).toList();
            } else {
              // Remove item
              updatedList = currentState.cartItems
                  .where((item) => item.menuItemId != event.params.menuItemId)
                  .toList();
            }
            emit(GetAllCartItemSuccess(updatedList));
          },
        );
      }
    } catch (e) {
      emit(DecreaseItemQuantityFailed(ExceptionFailure(e.toString())));
    }
  }
}
