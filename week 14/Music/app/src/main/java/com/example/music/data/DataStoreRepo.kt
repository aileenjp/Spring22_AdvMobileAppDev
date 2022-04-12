package com.example.music.data

import android.util.Log
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.emptyPreferences
import androidx.datastore.preferences.core.stringPreferencesKey
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.map
import java.io.IOException

class DataStoreRepo(private val dataStore: DataStore<Preferences>) {
    private object PreferencesKeys {
        val SONG = stringPreferencesKey("song")
        val ARTIST = stringPreferencesKey("artist")
    }

    val readFromDataStore: Flow<Favorite> = dataStore.data
        .catch { exception ->
            if (exception is IOException) {
                Log.d("DataStoreRepository", exception.message.toString())
                emit(emptyPreferences())
            } else {
                throw exception
            }
        }
        .map { preference ->
            val song = preference[PreferencesKeys.SONG] ?: ""
            val artist = preference[PreferencesKeys.ARTIST] ?: ""
            Favorite(song, artist)
        }

    suspend fun saveToDataStore(song: String, artist: String){
        dataStore.edit { preference ->
            preference[PreferencesKeys.SONG] = song
            preference[PreferencesKeys.ARTIST] = artist
            Log.d("data song", preference[PreferencesKeys.SONG].toString())
            Log.d("data artist", preference[PreferencesKeys.ARTIST].toString())
        }
    }
}