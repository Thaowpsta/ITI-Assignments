package com.example.mvc.favorites;

import android.os.Bundle;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.lifecycle.Observer;
import androidx.recyclerview.widget.RecyclerView;

import com.example.mvc.R;
import com.example.mvc.datasource.local.ProductsLocalDatasource;
import com.example.mvc.model.Product;

import java.util.List;

public class FavoriteActivity extends AppCompatActivity implements OnFavouriteClickListener{

    RecyclerView recyclerView;
    FavoriteAdapter adapter;
    ProductsLocalDatasource productsLocalDatasource;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fav_products);

        recyclerView = findViewById(R.id.rvFavMovies);

        recyclerView.setLayoutManager(new androidx.recyclerview.widget.LinearLayoutManager(this));

        adapter = new FavoriteAdapter(this);

        recyclerView.setAdapter(adapter);

        productsLocalDatasource = new ProductsLocalDatasource(this);
        productsLocalDatasource.getAllProducts().observe(this, new Observer<List<Product>>() {
            @Override
            public void onChanged(List<Product> products) {
                adapter.setList(products);
            }
        });
    }
    @Override
    public void deleteFromFav(Product product) {
        productsLocalDatasource.deleteProduct(product);
        Toast.makeText(this, "Removed", Toast.LENGTH_SHORT).show();
    }
}