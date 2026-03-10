package com.example.day1.presentatiom.product.view

import android.content.res.Configuration
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.VerticalDivider
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.unit.dp
import androidx.lifecycle.lifecycleScope
import coil.compose.AsyncImage
import com.example.day1.ui.theme.Day1Theme
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.take
import kotlinx.coroutines.launch
import kotlin.time.Duration.Companion.seconds
import com.example.day1.data.product.model.Product
import com.example.day1.data.ProductRepository
import com.example.day1.presentatiom.product.viewModel.ProductState
import com.example.day1.presentatiom.product.viewModel.ProductViewModel
import com.example.day1.data.network.RetrofitClient


class MainActivity : ComponentActivity() {

    private val tag = "lab1"
    private val tag2 = "day2"

    //    private val stateChannel = Channel<ProductState>(capacity = Channel.UNLIMITED)
    private val viewModel: ProductViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        lifecycleScope.launch {
            val sharedFlow = MutableSharedFlow<Int>()

            launch {
                sharedFlow.collect { Log.i(tag2, "SharedFlow first collector: $it") }
            }

            launch {
                sharedFlow.collect { Log.i(tag2, "SharedFlow secind collector: $it") }
            }

            delay(1)
            sharedFlow.emit(5)
            delay(1.seconds)
            sharedFlow.emit(3)
        }

        lifecycleScope.launch {
            val stateFlow = MutableStateFlow("0")

            launch {
                stateFlow.collect { Log.i(tag2, "StateFlow collector: $it") }
            }

            delay(100)
            stateFlow.value = "1"
            stateFlow.value = "2"
            stateFlow.value = "3"
        }

        //////////////////
        lifecycleScope.launch {
            val names = listOf("Thaowpsta", "Ahmed", "Nardeen", "Saiid", "Angie", "Fady")
            val searchFlow = MutableSharedFlow<String>()

            launch {
                searchFlow.collect { query ->
                    val filteredNames = names.filter { it.startsWith(query, ignoreCase = true) }
                    if (filteredNames.isEmpty()) {
                        Log.i(tag2, "Search query '$query' results: no name found")
                    } else {
                        Log.i(
                            tag2,
                            "Search query '$query' results: ${filteredNames.joinToString(", ")}"
                        )
                    }
                }
            }

            delay(2.seconds)
            Log.i(tag2, "Filter for 'a'")
            searchFlow.emit("a")

            delay(3.seconds)
            Log.i(tag2, "Filter for 'b'")
            searchFlow.emit("b")

            delay(4.seconds)
            Log.i(tag2, "Filter for 'c'")
            searchFlow.emit("c")
        }


        ///Day 1
        val evenNumbers = flow {
            for (i in 0..38 step 2) {
                emit(i)
                delay(1000)
            }
        }

        lifecycleScope.launch {
            Log.i(tag, "Collecting the first 10 even numbers:")
            evenNumbers.take(10).collect { num -> Log.i(tag, num.toString()) }
            Log.i(tag, "Done")
        }

//        lifecycleScope.launch {
//            repository.fetchProductsFlow().collect { state ->
//                stateChannel.send(state)
//            }
//        }

        setContent {
            Day1Theme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    val currentState by viewModel.uiState.collectAsState()

                    ProductScreen(
                        uiState = currentState,
                        modifier = Modifier.padding(innerPadding)
                    )
                }
            }
        }
    }
}

@Composable
fun ProductScreen(uiState: ProductState, modifier: Modifier = Modifier) {
    var selectedProductId by rememberSaveable { mutableStateOf<Int?>(null) }

    val configuration = LocalConfiguration.current
    val isLandscape = configuration.orientation == Configuration.ORIENTATION_LANDSCAPE

    Box(modifier = modifier.fillMaxSize()) {
        when (uiState) {
            is ProductState.Loading -> {
                Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
                    CircularProgressIndicator()
                }
            }

            is ProductState.Success -> {
                val selectedProduct = uiState.products.find { it.id == selectedProductId }

                if (isLandscape) {
                    Row(modifier = Modifier.fillMaxSize()) {
                        ProductList(
                            products = uiState.products,
                            onProductClick = { selectedProductId = it.id },
                            modifier = Modifier.weight(1f)
                        )

                        VerticalDivider()

                        ProductDetails(
                            product = selectedProduct,
                            onBack = null,
                            modifier = Modifier.weight(1f)
                        )
                    }
                } else {
                    if (selectedProduct == null) {
                        ProductList(
                            products = uiState.products,
                            onProductClick = { selectedProductId = it.id },
                            modifier = Modifier.fillMaxSize()
                        )
                    } else {
                        ProductDetails(
                            product = selectedProduct,
                            onBack = { selectedProductId = null },
                            modifier = Modifier.fillMaxSize()
                        )
                    }
                }
            }

            is ProductState.Error -> {
                Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
                    Text(text = "Error: ${uiState.message}", color = MaterialTheme.colorScheme.error)
                }
            }
        }
    }
}

@Composable
fun ProductList(
    products: List<Product>,
    onProductClick: (Product) -> Unit,
    modifier: Modifier = Modifier
) {
    LazyColumn(modifier = modifier.fillMaxSize()) {
        items(products) { product ->
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(8.dp)
                    .clickable { onProductClick(product) },
                elevation = CardDefaults.cardElevation(4.dp)
            ) {
                AsyncImage(
                    model = product.thumbnail,
                    contentDescription = "Thumbnail for ${product.title}",
                    modifier = Modifier
                        .size(64.dp)
                        .clip(RoundedCornerShape(8.dp)),
                    contentScale = ContentScale.Crop
                )

                Spacer(modifier = Modifier.width(16.dp))

                Column(modifier = Modifier.padding(16.dp)) {
                    Text(text = product.title, style = MaterialTheme.typography.titleMedium)
                    Text(
                        text = "$${product.price}",
                        style = MaterialTheme.typography.bodyLarge
                    )
                }
            }
        }
    }
}

@Composable
fun ProductDetails(product: Product?, onBack: (() -> Unit)?, modifier: Modifier = Modifier) {
    if (product == null) {
        Box(contentAlignment = Alignment.Center, modifier = modifier.fillMaxSize()) {
            Text("Select a product to view details", style = MaterialTheme.typography.titleMedium)
        }
    } else {
        Column(
            modifier = modifier
                .fillMaxWidth()
                .padding(16.dp)
        ) {

            if (onBack != null) {
                Button(onClick = onBack, modifier = Modifier.padding(bottom = 16.dp)) {
                    Text("Back to List")
                }
            }

            AsyncImage(
                model = product.thumbnail,
                contentDescription = "Thumbnail for ${product.title}",
                modifier = Modifier
                    .fillMaxWidth()
                    .height(300.dp)
                    .clip(RoundedCornerShape(8.dp)),
                contentScale = ContentScale.Crop
            )

            Text(text = product.title, style = MaterialTheme.typography.headlineMedium)
            Spacer(modifier = Modifier.height(8.dp))

            Text(
                text = "Price: $${product.price}",
                style = MaterialTheme.typography.titleLarge,
                color = MaterialTheme.colorScheme.primary
            )
            Spacer(modifier = Modifier.height(16.dp))

            Text(text = product.description, style = MaterialTheme.typography.bodyLarge)
        }
    }
}