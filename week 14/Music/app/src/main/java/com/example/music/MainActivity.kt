package com.example.music

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView
import androidx.datastore.preferences.preferencesDataStore
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.music.data.DataStoreRepo
import com.example.music.data.FavoriteViewModel
import com.example.music.data.FavoriteViewModelFactory
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar

private val Context.dataStore by preferencesDataStore(name = "favorites")

class MainActivity : AppCompatActivity() {
    private lateinit var viewModel: FavoriteViewModel
    private lateinit var song: TextView
    private lateinit var artist: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        viewModel = ViewModelProvider(this,
            FavoriteViewModelFactory(DataStoreRepo(dataStore)))[FavoriteViewModel::class.java]

        song = findViewById(R.id.editTextSong)
        artist = findViewById(R.id.editTextArtist)

        findViewById<FloatingActionButton>(R.id.fab).setOnClickListener{ view ->
            val mySong = song.text.toString()
            val myArtist = artist.text.toString()
            viewModel.saveFavorites(mySong, myArtist)
            Snackbar.make(view, R.string.favsSaved, Snackbar.LENGTH_LONG).show()
        }

        viewModel.favorites.observe(this, Observer { favorites ->
            song.text = favorites.song
            artist.text = favorites.artist
        })
    }
}