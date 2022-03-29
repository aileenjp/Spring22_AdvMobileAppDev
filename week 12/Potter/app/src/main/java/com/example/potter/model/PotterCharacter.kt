package com.example.potter.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class PotterCharacter(val name: String, val info: String):Parcelable{}