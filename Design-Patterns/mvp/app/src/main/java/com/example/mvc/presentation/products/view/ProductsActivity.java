package com.example.mvc.presentation.products.view;

import static android.app.ProgressDialog.show;
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
import com.example.mvc.data.products.model.Product;
import com.example.mvc.data.network.Network;
import com.example.mvc.data.network.ProductService;
import com.example.mvc.presentation.products.presenter.ProductsPresenter;
import com.example.mvc.presentation.products.presenter.ProductsPresenterImp;

import java.util.List;

public class ProductsActivity extends AppCompatActivity implements OnProductClicked, ProductsView{

    private RecyclerView recyclerView;
    private ProductAdapter adapter;
    ProductService productService;
    private ProgressBar progressBar;
    private TextView errorTxt;
    private ProductsPresenter presenter;

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


        productService = Network.getInstance().getProducts();
        presenter = new ProductsPresenterImp(getApplicationContext(), this);
        presenter.getProducts();
    }

    @Override
    public void showLoading() {
        progressBar.setVisibility(VISIBLE);
    }

    @Override
    public void hideLoading() {
        progressBar.setVisibility(INVISIBLE);
    }

    @Override
    public void setProducts(List<Product> products) {
        adapter.setMovieList(products);
    }


    @Override
    public void onAddToFavSuccessfully() {
        Toast.makeText(this, "Added to favorites successfully", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showError(String error) {
        errorTxt.setText(error);
    }


    @Override
    public void addToFav(Product product) {
        presenter.addToFavorite(product);
    }
}
