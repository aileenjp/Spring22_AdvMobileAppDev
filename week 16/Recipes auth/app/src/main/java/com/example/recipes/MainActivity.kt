package com.example.recipes

import android.content.ClipData
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.EditText
import android.widget.LinearLayout
import android.widget.Toast
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.recipes.model.Recipe
import com.example.recipes.model.RecipeViewModel
import com.firebase.ui.auth.AuthUI
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar
import java.util.*

class MainActivity : AppCompatActivity() {
    private val viewModel: RecipeViewModel by viewModels()
    private var recipeAdapter: RecipeAdapter? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //get the recycler view
        val recyclerView: RecyclerView = findViewById(R.id.recyclerView)

        //divider line between rows
        recyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))

        //set a layout manager on the recycler view
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)

        //set up options
        val options = viewModel.options
        //create adapter using the options
        recipeAdapter = RecipeAdapter(options, viewModel)
        //set adapter on the recyclerview
        recyclerView.adapter = recipeAdapter

        findViewById<FloatingActionButton>(R.id.fab).setOnClickListener { view ->
//create a vertical linear layout to hold edit texts
            val layout= LinearLayout(this)
            layout.orientation = LinearLayout.VERTICAL

            //create edit texts and add to layout
            val nameEditText = EditText(this)
            nameEditText.setHint(R.string.recipeHint)
            layout.addView(nameEditText)
            val urlEditText = EditText(this)
            urlEditText.setHint(R.string.urlHint)
            layout.addView(urlEditText)

            // create alert dialog
            val dialog = AlertDialog.Builder(this)
            //set dialog title
            dialog.setTitle(R.string.addRecipe)
            //add layout to dialog
            dialog.setView(layout)

            //set OK action
            dialog.setPositiveButton(R.string.add) {dialog, which ->
                val recipeName = nameEditText.text.toString()
                val recipeURL= urlEditText.text.toString()
                if (!recipeName.isEmpty()){
                    //create new recipe item
                    val newRecipe = Recipe(recipeName, recipeURL)
                    //add item
                    viewModel.addRecipe(newRecipe)
                    Snackbar.make(view, R.string.recipeAdded, Snackbar.LENGTH_LONG)
                        .setAction(R.string.action, null).show()
                }
            }
            //sets cancel action
            dialog.setNegativeButton(R.string.cancel) { dialog, which ->
                //cancel
            }
            dialog.show()
        }
    }

    override fun onStart() {
        super.onStart()
        recipeAdapter?.startListening()
    }

    override fun onStop() {
        super.onStop()
        recipeAdapter?.stopListening()
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.options_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        return when (item.itemId) {
            R.id.action_logout -> {
                AuthUI.getInstance()
                    .signOut(this)
                    .addOnCompleteListener {
                        Toast.makeText(this, "${getString(R.string.action_logged_out)}", Toast.LENGTH_LONG).show()
                        finish()
                    }
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

}
