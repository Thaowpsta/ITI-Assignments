package com.example.mvc.presentation.favorites.view;

import android.os.Bundle;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import com.example.mvc.R;
import com.example.mvc.data.products.model.Product;
import com.example.mvc.presentation.favorites.presenter.FavoritesPresenterImp;
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.schedulers.Schedulers;

public class FavoriteActivity extends AppCompatActivity implements OnFavouriteClickListener, FavoriteView {

    RecyclerView recyclerView;
    FavoriteAdapter adapter;
    FavoritesPresenterImp presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fav_products);

        recyclerView = findViewById(R.id.rvFavMovies);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        adapter = new FavoriteAdapter(this);
        recyclerView.setAdapter(adapter);

        presenter = new FavoritesPresenterImp(getApplicationContext());

        presenter.getFavoriteProducts()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(products -> adapter.setList(products));
    }

    @Override
    public void deleteFromFav(Product product) {
        presenter.deleteFavoriteProduct(product)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(this::onDeletedFromFavoriteSuccessfully);
    }

    @Override
    public void onDeletedFromFavoriteSuccessfully() {
        Toast.makeText(this, "Removed from favorite successfully", Toast.LENGTH_SHORT).show();
    }
}