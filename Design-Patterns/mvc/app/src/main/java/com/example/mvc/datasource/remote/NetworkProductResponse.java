package com.example.mvc.datasource.remote;

import com.example.mvc.model.Product;

import java.util.List;

public interface NetworkProductResponse {

    void onSuccess(List<Product> products);
    void onFailure(String msg);
}
