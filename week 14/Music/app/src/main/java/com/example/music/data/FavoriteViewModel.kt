package com.example.music.data

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.asLiveData
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class FavoriteViewModel(private val dataStoreRepo: DataStoreRepo):ViewModel() {
    val favorites = dataStoreRepo.readFromDataStore.asLiveData()

    fun saveFavorites(songFavorite: String, artistFavorite: String){
        viewModelScope.launch(Dispatchers.IO) {
            dataStoreRepo.saveToDataStore(songFavorite, artistFavorite)
        }
    }
}

class FavoriteViewModelFactory(private val dataStoreRepo: DataStoreRepo): ViewModelProvider.Factory{
    override fun <T: ViewModel> create(modelClass: Class<T>):T{
        return FavoriteViewModel(dataStoreRepo) as T
    }
}