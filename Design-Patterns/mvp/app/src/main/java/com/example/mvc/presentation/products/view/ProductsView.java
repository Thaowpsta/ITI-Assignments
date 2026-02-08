package com.example.mvc.presentation.products.view;

import com.example.mvc.data.products.model.Product;

import java.util.List;

public interface ProductsView {

    void showLoading();
    void hideLoading();
    void setProducts(List<Product> products);
    void onAddToFavSuccessfully();
    void showError(String error);
}
