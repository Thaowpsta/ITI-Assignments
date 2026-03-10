package com.example.mvvm.presentation.products.presenter

import com.example.mvvm.data.products.model.Product

sealed class ProductsState {
    object Loading : ProductsState()
    data class Success(val products: List<Product>) : ProductsState()
    data class Error(val message: String) : ProductsState()
}