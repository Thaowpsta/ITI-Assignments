package com.example.mvc.datasource.remote;

import com.example.mvc.model.ProductResponse;
import com.example.mvc.network.Network;
import com.example.mvc.network.ProductService;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class ProductsRemoteDatasource {
    private ProductService productService;

    public ProductsRemoteDatasource(){
        productService = Network.getInstance().getProducts();
    }

    public void getProductService(NetworkProductResponse callback) {
        productService.getProducts().enqueue(new Callback<ProductResponse>() {
            @Override
            public void onResponse(Call<ProductResponse> call, Response<ProductResponse> response) {
                if (response.code() == 200)
                    callback.onSuccess(response.body().getResults());
                else
                    callback.onFailure("Error");
            }

            @Override
            public void onFailure(Call<ProductResponse> call, Throwable throwable) {

            }
        });
    }
}
