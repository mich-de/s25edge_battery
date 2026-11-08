package com.s25optimizer.data

import android.content.Context
import java.io.File
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/**
 * Copy of the in-app log on disk, so a failed toggle can still be read after the app
 * restarts (`adb shell run-as com.s25optimizer cat files/app_log.txt` on debug builds).
 */
object AppLog {
    private const val MAX_BYTES = 512 * 1024
    private val stamp = SimpleDateFormat("MM-dd HH:mm:ss", Locale.ROOT)

    @Synchronized
    fun append(context: Context, message: String) {
        val file = File(context.filesDir, "app_log.txt")
        // shortcut: drops the whole file past 512 KB instead of rotating; enough for a support log.
        if (file.length() > MAX_BYTES) file.delete()
        val time = stamp.format(Date())
        file.appendText(message.lines().joinToString("\n") { "$time $it" } + "\n")
    }
}
