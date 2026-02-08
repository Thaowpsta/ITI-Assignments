package com.example.mvc.products;

import static android.view.View.GONE;
import static android.view.View.INVISIBLE;
import static android.view.View.VISIBLE;

import android.os.Bundle;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import com.example.mvc.R;
import com.example.mvc.datasource.local.ProductsLocalDatasource;
import com.example.mvc.datasource.remote.NetworkProductResponse;
import com.example.mvc.datasource.remote.ProductsRemoteDatasource;
import com.example.mvc.model.Product;
import com.example.mvc.network.Network;
import com.example.mvc.network.ProductService;

import java.util.List;

public class ProductsActivity extends AppCompatActivity implements OnProductClicked{

    private RecyclerView recyclerView;
    private ProductAdapter adapter;
    ProductService productService;
    private ProgressBar progressBar;
    private TextView errorTxt;
    ProductsRemoteDatasource productsRemoteDatasource;
    ProductsLocalDatasource productsLocalDatasource;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_all_products);
        recyclerView = findViewById(R.id.rv_movies);
        progressBar = findViewById(R.id.progress_circular);
        errorTxt = findViewById(R.id.tv_error);

        progressBar.setVisibility(INVISIBLE);
        errorTxt.setVisibility(GONE);

        adapter = new ProductAdapter(this);
        recyclerView.setAdapter(adapter);

        productsRemoteDatasource = new ProductsRemoteDatasource();
        productsLocalDatasource = new ProductsLocalDatasource(getApplicationContext());

        productService = Network.getInstance().getProducts();
        productsRemoteDatasource.getProductService(new NetworkProductResponse() {
            @Override
            public void onSuccess(List<Product> products) {
                progressBar.setVisibility(GONE);
                errorTxt.setVisibility(GONE);
                adapter.setMovieList(products);

            }

            @Override
            public void onFailure(String msg) {
                progressBar.setVisibility(GONE);
                errorTxt.setVisibility(VISIBLE);
                errorTxt.setText("Error code:" + msg);
            }
        });
    }

    @Override
    public void addToFav(Product product) {
        productsLocalDatasource.insertProduct(product);
        Toast.makeText(this, "Added to favs", Toast.LENGTH_SHORT).show();
    }
}
