package com.example.mvc.data.products.datasource.remote;

import com.example.mvc.data.products.model.Product;
import com.example.mvc.data.products.model.ProductResponse;
import com.example.mvc.data.network.Network;
import com.example.mvc.data.network.ProductService;

import java.util.List;

import io.reactivex.rxjava3.core.Single;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class ProductsRemoteDatasource {
    private ProductService productService;

    public ProductsRemoteDatasource(){
        productService = Network.getInstance().getProducts();
    }

    public Single<List<Product>> getProductsService() {
        return productService.getProducts()
                .map(ProductResponse::getResults);
    }
}
