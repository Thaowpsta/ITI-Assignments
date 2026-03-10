package com.example.mvvm

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewmodel.compose.viewModel
import coil.compose.AsyncImage
import com.example.mvvm.data.products.ProductRepository
import com.example.mvvm.data.products.model.Product
import com.example.mvvm.presentation.favorites.presenter.FavoritesViewModel
import com.example.mvvm.presentation.products.presenter.ProductsState
import com.example.mvvm.presentation.products.presenter.ProductsViewModel
import com.example.mvvm.ui.theme.MVVMTheme
import kotlinx.coroutines.flow.collectLatest

class ProductsActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val repository = ProductRepository(applicationContext)

        setContent {
            MVVMTheme {
                val viewModel: ProductsViewModel = viewModel(
                    factory = ProductsViewModelFactory(repository)
                )
                ProductsScreen(viewModel = viewModel)
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProductsScreen(viewModel: ProductsViewModel) {
    val uiState by viewModel.uiState.collectAsState()
    val snackbarHostState = remember { SnackbarHostState() }

    LaunchedEffect(key1 = true) {
        viewModel.snackbar.collectLatest { message ->
            snackbarHostState.showSnackbar(message = message)
        }
    }

    Scaffold(
        snackbarHost = { SnackbarHost(hostState = snackbarHostState) },
        topBar = {
            TopAppBar(
                title = { Text("All Products") },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    titleContentColor = MaterialTheme.colorScheme.onPrimary
                )
            )
        }
    ) { paddingValues ->
        Box(modifier = Modifier.padding(paddingValues).fillMaxSize()) {
            when (uiState) {
                is ProductsState.Loading -> CircularProgressIndicator(modifier = Modifier.align(Alignment.Center))
                is ProductsState.Error -> {
                    val errorMsg = (uiState as ProductsState.Error).message
                    Text(text = errorMsg, color = MaterialTheme.colorScheme.error, modifier = Modifier.align(Alignment.Center))
                }
                is ProductsState.Success -> {
                    val productList = (uiState as ProductsState.Success).products
                    LazyColumn(contentPadding = PaddingValues(vertical = 8.dp)) {
                        items(productList) { product ->
                            ProductListItem(
                                product = product,
                                buttonText = "Add to Favorites",
                                onButtonClick = { viewModel.addToFavorite(product) }
                            )
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun ProductListItem(product: Product, buttonText: String, onButtonClick: () -> Unit) {
    Card(
        modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp),
        shape = RoundedCornerShape(8.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
        colors = CardDefaults.cardColors(containerColor = Color.White)
    ) {
        Row(
            modifier = Modifier.fillMaxWidth().padding(12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            AsyncImage(
                model = product.thumbnail,
                contentDescription = product.title,
                modifier = Modifier.size(100.dp).clip(RoundedCornerShape(8.dp)),
                contentScale = ContentScale.Crop
            )
            Spacer(modifier = Modifier.width(12.dp))
            Column(modifier = Modifier.weight(1f)) {
                Text(text = product.title, fontSize = 18.sp, fontWeight = FontWeight.Bold, color = Color.Black, maxLines = 1, overflow = TextOverflow.Ellipsis)
                Spacer(modifier = Modifier.height(4.dp))
                Text(text = product.description ?: "No description", fontSize = 14.sp, color = Color.DarkGray, maxLines = 2, overflow = TextOverflow.Ellipsis)
                Spacer(modifier = Modifier.height(8.dp))
                Text(text = "Price: $${product.price}", fontSize = 16.sp, fontWeight = FontWeight.Medium, color = Color.Black)
            }
            Spacer(modifier = Modifier.width(8.dp))
            Button(onClick = onButtonClick, shape = RoundedCornerShape(8.dp)) {
                Text(text = buttonText)
            }
        }
    }
}

class ProductsViewModelFactory(
    private val repository: ProductRepository
) : ViewModelProvider.Factory {

    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(ProductsViewModel::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return ProductsViewModel(repository) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}