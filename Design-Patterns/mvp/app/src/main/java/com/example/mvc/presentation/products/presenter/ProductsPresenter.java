package com.example.mvc.presentation.products.presenter;

import com.example.mvc.data.products.model.Product;

public interface ProductsPresenter {

    void getProducts();
    void addToFavorite(Product product);
}
