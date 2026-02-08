package com.example.mvc.products;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.example.mvc.R;
import com.example.mvc.model.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductAdapter extends RecyclerView.Adapter<ProductAdapter.ProductViewHolder> {

    private List<Product> movieList;
    private OnProductClicked onProductClicked;


    public ProductAdapter(OnProductClicked onProductClicked) {
        this.onProductClicked = onProductClicked;
        this.movieList = new ArrayList<>();
    }

    public void setMovieList(List<Product> movieList) {
        this.movieList = movieList;
        notifyDataSetChanged();
    }

    @NonNull
    @Override
    public ProductViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_product, parent, false);
        return new ProductViewHolder(view, onProductClicked);
    }

    @Override
    public void onBindViewHolder(@NonNull ProductViewHolder holder, int position) {
        Product movie = movieList.get(position);
        holder.bind(movie);
    }

    @Override
    public int getItemCount() {
        return movieList != null ? movieList.size() : 0;
    }

    public static class ProductViewHolder extends RecyclerView.ViewHolder {
        private ImageView movieImageView;
        private TextView movieTitleTextView;
        private TextView movieCategoryTextView;
        private Button addToFavoritesButton;
        private OnProductClicked listener;
        public ProductViewHolder(@NonNull View itemView, OnProductClicked onProductClicked) {
            super(itemView);
            this.listener = onProductClicked;
            movieImageView = itemView.findViewById(R.id.iv_poster);
            movieTitleTextView = itemView.findViewById(R.id.tv_name);
            movieCategoryTextView = itemView.findViewById(R.id.tv_category);
            addToFavoritesButton = itemView.findViewById(R.id.btn_addToFav);
        }

        public void bind(Product movie) {
            movieTitleTextView.setText(movie.getTitle());
            Glide.with(itemView)
                    .load(movie.getImgUrl())
                    .into(movieImageView);

            addToFavoritesButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    listener.addToFav(movie);
                }
            });

        }
    }
}
