package com.example.mvvm

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.lifecycle.lifecycleScope
import com.example.mvvm.ui.theme.MVVMTheme
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.launch
import kotlin.time.Duration.Companion.seconds

class MainActivity : ComponentActivity() {
    private val tag2 = "day2"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

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

        setContent {
            MVVMTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    MainScreen()
                }
            }
        }
    }
}

@Composable
fun MainScreen() {
    val context = LocalContext.current
    val activity = context as? Activity

    Column(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Button(
            onClick = { context.startActivity(Intent(context, ProductsActivity::class.java)) },
            modifier = Modifier.fillMaxWidth(0.7f).padding(8.dp)
        ) {
            Text("Show Products")
        }

        Button(
            onClick = { context.startActivity(Intent(context, FavoritesActivity::class.java)) },
            modifier = Modifier.fillMaxWidth(0.7f).padding(8.dp)
        ) {
            Text("Show Favorites")
        }

        Button(
            onClick = { activity?.finishAffinity() },
            modifier = Modifier.fillMaxWidth(0.7f).padding(8.dp),
            colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.error)
        ) {
            Text("Quit App")
        }
    }
}