package com.example.sfl

import io.flutter.embedding.android.FlutterActivity 

import android.os.Build
import android.content.Intent
import android.view.ViewTreeObserver
import android.view.WindowManager
import android.os.Bundle 
import android.os.Environment;
import android.Manifest
import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.app.DownloadManager
import android.content.Context
import android.content.pm.PackageManager
import android.database.Cursor
import android.net.Uri
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import java.io.File
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.VisibleForTesting;
import androidx.core.content.res.ResourcesCompat;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;
import androidx.lifecycle.LifecycleRegistry;
import androidx.lifecycle.Lifecycle.Event;
import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity.CachedEngineIntentBuilder;
import io.flutter.embedding.android.FlutterActivity.NewEngineIntentBuilder;
import io.flutter.embedding.android.FlutterActivityLaunchConfigs.BackgroundMode;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterShellArgs;
import io.flutter.embedding.engine.plugins.util.GeneratedPluginRegister;
import io.flutter.plugin.platform.PlatformPlugin;
import io.flutter.util.ViewUtils;
import io.flutter.plugin.common.MethodChannel;
class MainActivity: FlutterActivity() {

    private var CHANNEL = "sfl.flutter.dev/downloadf"
    private var DOWNLOAD_M = "downloadImage"
    private var GET_PATH_M = "getpath"
    private var OPEN_PATH_M = "openimage"
   
   override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
      super.configureFlutterEngine(flutterEngine)
      MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
              { call, result -> 
                if(call.method==DOWNLOAD_M)
               downloadImage (call.argument<String>("furl"), call.argument<String>("id"),result)
               if(call.method==OPEN_PATH_M)
               openImage (call.argument<String>("path")?:"",result)
               if(call.method==GET_PATH_M)
               {
                val directory =  Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES);
                if (!directory.exists()) {
                    directory.mkdirs()
                }
              result.success( directory.absolutePath);
               }
              }
      )
  }
   fun openImage(path:String,result:MethodChannel.Result)
   {
try{
    var file =   File(path);
var uri=Uri.parse("file://" +path);
if (Build.VERSION.SDK_INT < 24) {
    uri = Uri.fromFile(file);
} else {
    uri = Uri.parse(file.getPath()); // My work-around for SDKs up to 29.
}
    var intr= Intent(Intent.ACTION_VIEW);
    intr.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
    intr.setDataAndType(uri, "image/png")
    intr.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
    startActivity(Intent.createChooser(intr, "Open image"));
    
result.success(0)
}catch(t:Exception){
    
result.error(t.message, t.message, t);
}  

}
   private var msg: String? = ""
   private var lastMsg = ""

   @SuppressLint("Range")
   private fun downloadImage(url: String?,name: String?,result:MethodChannel.Result) {
       val directory = File(Environment.DIRECTORY_PICTURES)

       if (!directory.exists()) {
           directory.mkdirs()
       }

       val downloadManager = this.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager

       val downloadUri = Uri.parse(url)

       val request = DownloadManager.Request(downloadUri).apply {
           setAllowedNetworkTypes(DownloadManager.Request.NETWORK_WIFI or DownloadManager.Request.NETWORK_MOBILE)
               .setAllowedOverRoaming(false)
               .setTitle(name)
               .setDescription("")
               .setDestinationInExternalPublicDir(
                   directory.toString(),name)
               
       }

       val downloadId = downloadManager.enqueue(request)
       val query = DownloadManager.Query().setFilterById(downloadId)
       Thread(Runnable {
           var downloading = true
           while (downloading) {
               val cursor: Cursor = downloadManager.query(query)
               cursor.moveToFirst()
               if (cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS)) == DownloadManager.STATUS_SUCCESSFUL) {
                   downloading = false
               }
               val status = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS))
               if(status==DownloadManager.STATUS_FAILED)
               {downloading = false}
               msg = statusMessage(name?:"", directory, status)
               if (msg != lastMsg) {
                   this.runOnUiThread {
                       Toast.makeText(this, msg, Toast.LENGTH_LONG).show()
                   }
                   lastMsg = msg ?: ""
               }
               cursor.close()
           }
           result.success(0)
       }).start()
   }

   private fun statusMessage(url: String, directory: File, status: Int): String? {
      var msg =   when (status) {
          DownloadManager.STATUS_FAILED -> "Download has failed, please try again"
          DownloadManager.STATUS_PAUSED -> "Paused"
          DownloadManager.STATUS_PENDING -> "Pending"
          DownloadManager.STATUS_RUNNING -> "Downloading..."
          DownloadManager.STATUS_SUCCESSFUL -> "Image downloaded successfully in $directory" + File.separator + url
          else -> "There's nothing to download"
      }
      return msg
  }
   override fun onCreate(savedInstanceState: Bundle?) {
 super.onCreate(savedInstanceState);
    getWindow().setStatusBarColor(0x00000000);
}
}
