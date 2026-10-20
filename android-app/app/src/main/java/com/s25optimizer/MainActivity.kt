package com.s25optimizer

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.s25optimizer.service.ScreenOffService
import com.s25optimizer.ui.MainScreen
import com.s25optimizer.ui.S25EdgeTheme
import com.s25optimizer.ui.SurfaceDark

class MainActivity : ComponentActivity() {
    override fun onResume() {
        super.onResume()
        // The app is visible here, so a foreground service start is always permitted —
        // this is the retry for the starts the platform refused in the background.
        ScreenOffService.ensureRunning(this)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        setContent {
            S25EdgeTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = SurfaceDark,
                ) {
                    MainScreen()
                }
            }
        }
    }
}

