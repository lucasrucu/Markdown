# Configuración de Applicaciones Móviles con Jetpack Compose

## Indice

- [Configuración de Applicaciones Móviles con Jetpack Compose](#configuración-de-applicaciones-móviles-con-jetpack-compose)
  - [Indice](#indice)
  - [Arquitectura del Proyecto](#arquitectura-del-proyecto)
  - [Configuración del Proyecto](#configuración-del-proyecto)
    - [Dependencias](#dependencias)
    - [Versiones](#versiones)
    - [Permisos](#permisos)
  - [Data Class (Model)](#data-class-model)
  - [Remote Configurations](#remote-configurations)
  - [Base de Datos](#base-de-datos)
  - [Activities](#activities)
  - [Components](#components)
  - [Navigation](#navigation)

## Arquitectura del Proyecto

![Jetpack compose architecture](/Assets/Images/jc_architecture.png)

## Configuración del Proyecto

### Dependencias

Agregar las siguientes dependencias al archivo `build.gradle` del proyecto:

```gradle
// START - CUSTOM DEPENDENCIES
// NAVIGATION
val navVersion = "2.7.2"
implementation("androidx.navigation:navigation-fragment-ktx:$navVersion")
implementation("androidx.navigation:navigation-ui-ktx:$navVersion")
implementation("androidx.navigation:navigation-compose:$navVersion")

// HTTP CLIENT: Retrofit
val retrofitVersion = "2.9.0"
implementation("com.squareup.retrofit2:retrofit:$retrofitVersion")
implementation("com.squareup.retrofit2:converter-gson:$retrofitVersion")

// IMAGE
val glideVersion = "2.2.8"
implementation("com.github.skydoves:landscapist-glide:$glideVersion")

// ROOM - ORM FRAMEWORK
val room_version = "2.5.2"
implementation("androidx.room:room-runtime:$room_version")
annotationProcessor("androidx.room:room-compiler:$room_version")
// To use Kotlin annotation processing tool (kapt)
kapt("androidx.room:room-compiler:$room_version")
// optional - Kotlin Extensions and Coroutines support for Room
implementation("androidx.room:room-ktx:$room_version")

// END - CUSTOM DEPENDENCIES
```

Actualizar tambien al inicio del archivo los pulgins y agregar el de kotlin-kapt:

```gradle
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("kotlin-kapt")
}
```

### Versiones

Actualizar tambien las versiones de Sdk en:

> compileSdk = `34`
>
> sourceCompatibility = `JavaVersion.VERSION_17`
>
> targetCompatibility = `JavaVersion.VERSION_17`

> jvmTarget = `"17"`

### Permisos

Por ultimo, agregar el permiso de internet en el archivo `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## Data Class (Model)

En caso el nombre del API que se intenta mapear esdistinto, hacer uso de la anotación `@SerializedName`:

```kotlin
data class PokemonDetail(
    val id: Int,
    val abilities: List<Ability>,
    val name: String,
    val sprites: Sprites,
    var isFavorite: Boolean = false
)

data class Ability(
    @SerializedName("ability")
    val abilityInfo: AbilityInfo,
    @SerializedName("is_hidden")
    val isHidden: Boolean,
    val slot: Int
)
```

## Remote Configurations

Configurar 1ero el ApiClient:

```kotlin
object ApiClient {
    private const val API_BASE_URL = "https://pokeapi.co/api/v2/"
    private var pokemonService:PokemonService? = null

    fun getInstance (): PokemonService {
        if (pokemonService ==null){
            val retrofit = Retrofit
                .Builder()
                .baseUrl(API_BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
            pokemonService = retrofit.create(PokemonService::class.java)
        }

        return pokemonService as PokemonService
    }
}
```

Despues el service:

```kotlin
interface PokemonService {
    @GET("pokemon")
    fun getAll(): Call<PokemonResponse>

    @GET()
    fun getDetail(@Url pokemonUrl: String): Call<PokemonDetail>

    @GET("pokemon/{id}")
    fun getPokemon(@Path("id") id: Int) : Call<PokemonDetail>

    @GET(pokemon/)
    fun getDetail(@Query("page") pokemonUrl: String): Call<PokemonDetail>
}
```

Y por ultimo el repository. Aqui se presentaran 2 formas de hacerlo, una con callbacks y de forma mas simple:

```kotlin
class CharacterRepository(
    private val characterService: CharacterService = ApiClient.getCharacterService()
) {

    fun getCharacters(page: String, callback: (Result<List<Character>>) ->Unit){
        val getCharacters = characterService.getCharacters(page = page)

        getCharacters.enqueue(object: Callback<CharacterResponse>{
            override fun onResponse(
                call: Call<CharacterResponse>,
                response: Response<CharacterResponse>
            ) {
                if (response.isSuccessful){
                    callback(Result.Success(response.body()!!.characters))
                }
            }

            override fun onFailure(call: Call<CharacterResponse>, t: Throwable) {
                callback(Result.Error(t.localizedMessage as String))
            }
        })
    }
}
```

Este 1er ejemplo hace uso de Result, que es una clase que se creo para poder manejar los resultados de las llamadas a los APIs. Esta clase se encuentra en el archivo `utils/Result.kt`:

```kotlin
sealed class Result<T>(val data: T? = null, val message: String? = null) {
    class Success<T>(data: T) : Result<T>(data)
    class Error<T>(message: String, data: T? = null) : Result<T>(data, message)
}
```

Esta es la 2nda forma mas sencilla.

```kotlin
class PokemonRepository(
    private val pokemonService: PokemonService = ApiClient.getInstance(),
    private val pokemonDao: PokemonDao
) {
    suspend fun getAll(): List<PokemonDetail> {
        val pokemonsPreview = pokemonService.getAll().await()
        val pokemonDetails = mutableListOf<PokemonDetail>()
        pokemonsPreview.pokemons.forEach { pokemonPreview ->
            val pokemonDetail = getDetail(pokemonPreview.url)
            pokemonDetail.isFavorite = pokemonDao.getById(pokemonDetail.id) != null
            pokemonDetails.add(getDetail(pokemonPreview.url))
        }
        return pokemonDetails
    }
    private suspend fun getDetail(url: String): PokemonDetail {
        return pokemonService.getDetail(url).await()
    }
    suspend fun getPokemon(id: Int): PokemonDetail {
        return pokemonService.getPokemon(id).await()
    }
}
```

Tomar en cuenta que aqui se esta implementando el uso un Dao para poder hacer uso de la base de datos local. Y tambien que en layoria de los APIs, el resultado viene dentro de un response. De ser el caso se tendria que crear otro data class para poder mapear el resultado:

```kotlin
data class PokemonResponse(
    @SerializedName("results")
    var pokemons: List<PokemonPreview>
)
```

## Base de Datos

Antes de empezar a mostrar y hacer uso de la informacion, se debe de crear la base de datos local. Para esto se debe de crear un data class por cada tabla que se quiera crear:

```kotlin
@Entity(tableName = "pokemons")
data class PokemonEntity(
    @PrimaryKey
    val id: Int
)
```

Y despues crear el Dao:

```kotlin
@Dao
interface PokemonDao {
    @Insert
    fun save (pokemon: PokemonEntity)

    @Delete
    fun delete (pokemon: PokemonEntity)

    @Query("select * from pokemons where id = :id")
    fun getById(id: Int) : PokemonEntity?
}
```

Por ultimo, crear la base de datos:

```kotlin
@Database(entities = [PokemonEntity::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun pokemonDao(): PokemonDao
    companion object {
        fun getInstance(context: Context) : AppDatabase {
            return Room.databaseBuilder(context, AppDatabase::class.java, "pokemon.db")
                .allowMainThreadQueries()
                .build()
        }
    }
}
```

Al final esto se puede implementar en el repository.

## Activities

Aqui crea todos los datos que necesitaras, context, dao, repository y las variables que necesitaras para mostrar la informacion. Aqui tambien se puede llamar el repositorio de ser necesario.

```kotlin
val context = LocalContext.current
val pokemonDao = AppDatabase.getInstance(context).pokemonDao()
val pokemonRepository = PokemonRepository(pokemonDao = pokemonDao)
val (pokemonDetails, setDetails) = remember { mutableState(listOf<PokemonDetail>()) }
val (pokemons, setPokemons) = remember { mutableStateOf(listOf<PokemonPrevie()) }

// 1st way
repository.getCharacters(textQuery.value) { result ->
    if (result is Result.Success) {
        characters.value = result.data!!
    } else {
        Toast.makeText(context, result.message!!, Toast.LENGTH_SHORT).show()
    }
}

// 2nd way
LaunchedEffect(Unit) {
    val result = pokemonRepository.getAll()
    setDetails(result)
}
```

Ejemplo de un HomeViewModel:

```kotlin
@Composable
fun Home(navController: NavHostController) {
    val context = LocalContext.current
    val pokemonDao = AppDatabase.getInstance(context).pokemonDao()
    val pokemonRepository = PokemonRepository(pokemonDao = pokemonDao)
    val (pokemonDetails, setDetails) = remember { mutableStateOf(listOf<PokemonDetail>()) }
    val (pokemons, setPokemons) = remember { mutableStateOf(listOf<PokemonPreview>()) }

    LaunchedEffect(Unit) {
        val result = pokemonRepository.getAll()
        setDetails(result)
    }

    PokemonList(pokemons = pokemonDetails, navController)
}

// Otro home
@Composable
fun CharacterBrowser(navController: NavHostController) {
    val characters = remember { mutableStateOf(listOf<Character>()) }
    val textQuery = remember { mutableStateOf("") }

    Column {
        SearchBar(textQuery, characters)
        CharacterList(characters)
    }
}
```

## Components

> CharacterList.kt

```kotlin
@Composable
fun CharacterList(characters: MutableState<List<Character>>) {
    LazyColumn{
        items(characters.value){character ->
            CharacterCard(character)
        }
    }
}
```

> CharacterCard.kt

```kotlin
@Composable
fun CharacterCard(character: Character) {
    Card(
        shape = RoundedCornerShape(10), modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp)
    ) {
        Row {
            Row(
                modifier = Modifier.weight(1f),
                .clickable {
                    navController.navigate(
                        Routes.PokemonDetail.getRouteWithArgument(
                            pokemon.id
                        )
                    )
                },
                horizontalArrangement = Arrangement.Center,
                verticalAlignment = Alignment.CenterVertically
            ) {
                CharacterImage(character)
                CharacterData(character)
            }
            FavoriteButton()
        }
    }
}

@Composable
fun CharacterData(character: Character) {
    val characterColor = when (character.status) {
        "Alive" -> Color.Green
        "Dead" -> Color.Red
        else -> Color.Gray
    }

    Column(
        modifier = Modifier.padding(16.dp)
    ) {
        Text(text = character.name, fontSize = 13.sp, fontWeight = FontWeight.Bold, maxLines = 1)
        Row(
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = character.status,
                fontSize = 11.sp,
                fontWeight = FontWeight.Bold,
                color = characterColor
            )
            Text(
                text = " - " + character.species,
                fontSize = 11.sp,
            )
        }
        Text(text = "Origin:", fontSize = 11.sp)
        Text(text = character.origin.name, fontSize = 11.sp)
    }
}

@Composable
fun CharacterImage(character: Character) {
    GlideImage(
        imageModel = { character.image },
        imageOptions = ImageOptions(contentScale = ContentScale.Fit),
        modifier = Modifier.size(100.dp)
    )
}

@Composable
fun FavoriteButton() {
    IconButton(onClick = {}) {
        Icon(Icons.Default.Favorite, "Favorite Icon")
    }
}
```

```kotlin
val (favorite, setFavorite) = remember { mutableStateOf(pokemon.isFavorite) }

IconButton(onClick = {
    if (favorite) {
        pokemonDao.delete(PokemonEntity(pokemon.id))
    } else {
        pokemonDao.save(PokemonEntity(pokemon.id))
    }
    setFavorite(!favorite)
}) {
    Icon(
        Icons.Default.Favorite,
        "Favorite Icon",
        tint =
        if (favorite) MaterialTheme.colorScheme.primary
        else MaterialTheme.colorScheme.onSurface
    )
}
```

> SearchBar.kt

```kotlin
@Composable
fun SearchBar(textQuery: MutableState<String>, characters: MutableState<List<Character>>) {
    val repository = CharacterRepository()
    val context = LocalContext.current
    OutlinedTextField(
        value = textQuery.value,
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 24.dp, horizontal = 115.dp),
        placeholder = { Text("Page Number") },
        onValueChange = {
            if (it.isEmpty()) textQuery.value = it
            else {
                if (it.isDigitsOnly()) {
                    if (it.toInt() <= 42) textQuery.value = it
                    else Toast.makeText(context, "Max page is 42", Toast.LENGTH_SHORT).show()
                }
            }
        },
        keyboardOptions = KeyboardOptions(
            keyboardType = KeyboardType.Number,
            imeAction = ImeAction.Search
        ),
        keyboardActions = KeyboardActions(
            onSearch = {
                repository.getCharacters(textQuery.value) { result ->
                    if (result is Result.Success) {
                        characters.value = result.data!!
                    } else {
                        Toast.makeText(context, result.message!!, Toast.LENGTH_SHORT).show()
                    }
                }
            }
        )
    )
//    OutlinedTextField(
//        value = textQuery.value,
//        onValueChange = { textQuery.value = it },
//        leadingIcon = {Icon(Icons.Filled.Search, null)},
//        keyboardOptions = KeyboardOptions(
//                keyboardType = KeyboardType.Text,
//            imeAction = ImeAction.Search
//        ),
//        keyboardActions = KeyboardActions(
//            onSearch = {
//                repository.getCharacters(textQuery.value){result ->
//                    if (result is Result.Success) {
//                        characters.value = result.data!!
//                    } else {
//                        Toast.makeText(context, result.message!!, Toast.LENGTH_SHORT).show()
//                    }
//                }
//            }
//        )
//    )
}
```

## Navigation

```kotlin
sealed class Routes(val route: String) {
    object CharacterBrowser : Routes("CharacterBrowser")
    object CharacterDetail : Routes("CharacterDetail") {
        const val routeWithArgument = "CharacterDetail/{id}"
        const val argument = "id"
        fun passId(id: String): String {
            return "CharacterDetail/${id}"
        }
    }
}

@Composable
fun Navigation() {
    val navController = rememberNavController()

    NavHost(
        navController = navController,
        startDestination = Routes.CharacterBrowser.route
    ) {
        composable(Routes.CharacterBrowser.route) {
            CharacterBrowser(navController)
        }

        composable(
            route = Routes.CharacterDetail.routeWithArgument,
            arguments = listOf(navArgument(Routes.CharacterDetail.argument){type = NavType.StringType})
        ){ backStackEntry ->
            val id = backStackEntry.arguments?.getString("id") as String
            CharacterDetail(id = id)
        }
    }
}
```
