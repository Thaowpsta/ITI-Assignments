package com.example.mvvm.presentation.favorites.presenter

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.mvvm.data.products.ProductRepository
import com.example.mvvm.data.products.model.Product
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class FavoritesViewModel(private val repository: ProductRepository) : ViewModel() {

    private val _snackbar = MutableSharedFlow<String>()
    val snackbar = _snackbar.asSharedFlow()

    val favorites: StateFlow<List<Product>> = repository.getFavoriteProducts()
        .stateIn(
            scope = viewModelScope,
            started = SharingStarted.WhileSubscribed(5000),
            initialValue = emptyList()
        )

    fun removeFromFavorite(product: Product) {
        viewModelScope.launch {
            repository.deleteProduct(product)
            _snackbar.emit("${product.title} removed from favorites")
        }
    }
}