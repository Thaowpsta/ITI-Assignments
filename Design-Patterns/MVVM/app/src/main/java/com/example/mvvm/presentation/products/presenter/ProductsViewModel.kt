package com.example.mvvm.presentation.products.presenter

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.mvvm.data.products.ProductRepository
import com.example.mvvm.data.products.model.Product
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class ProductsViewModel(private val repository: ProductRepository) : ViewModel() {

//TODO Lazem a3mel Factory
    private val _snackbar = MutableSharedFlow<String>()
    val snackbar = _snackbar.asSharedFlow()

    val uiState: StateFlow<ProductsState> = flow {
        emit(ProductsState.Loading)
        try {
            val response = repository.getRemoteProducts()
            emit(ProductsState.Success(response.products))
        } catch (e: Exception) {
            emit(ProductsState.Error(e.toString()))
        }
    }.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000),
        initialValue = ProductsState.Loading
    )

    fun addToFavorite(product: Product) {
        viewModelScope.launch {
            repository.insertProduct(product)
            _snackbar.emit("${product.title} added to favorites")
        }
    }
}