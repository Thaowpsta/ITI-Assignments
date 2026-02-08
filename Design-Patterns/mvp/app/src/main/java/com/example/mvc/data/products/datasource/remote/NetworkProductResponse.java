package com.example.mvc.data.products.datasource.remote;

import com.example.mvc.data.products.model.Product;

import java.util.List;

public interface NetworkProductResponse {

    void onSuccess(List<Product> products);
    void onFailure(String msg);
}
