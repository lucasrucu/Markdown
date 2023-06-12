## Applicaciones Web - DB en MySQL

### Indice

1. [Crear Arquitectura de la Solucion](#1-crear-arquitectura-de-la-solucion)

2. [Capa Infrastructure](#2-capa-infrastructure)

   2.1. [Models](#21-models)

   2.2. [Context](#22-context)

   2.3. [Infrastructure](#23-infrastructure)

3. [Capa Domain](#3-capa-domain)

4. [Capa API](#4-capa-api)

   4.1. [Inyecciones y Base de datos](#41-inyecciones-y-base-de-datos)

   4.2. [Controladores](#42-controladores)

5. [Glossary](#glossary)

### 1. Crear Arquitectura de la Solucion

En Jetbrians Rider, crear una solucion vacia, _Empty Soluction_.
Haces click derecho sobre la solucion y seleccionas _Add Project_.
Escoges _ASP.NET Core Web Application_ y le das un nombre a la solucion. Recordar que el _Type_ debe ser _Web API_ y el nombre debe terminar con _.API_ por buenas practicas.

Creas otro proyecto, esta vez de tipo _Class Library_ y le das el mismo nombre que al proyecto anterior pero reemplzando _.API_ por _.Domain_. Asegurense de tener las configuraciones adecuadas:

- SDK: 7.0
- Language: C#
- Framework: net7.0

Realizas este ultimo procedimiento de nuevo pero en vez de _.Domain_ le pones _.Infrastructure_.

Ahora se deben agregar las referencias de los proyectos _Domain_ e _Infrastructure_ al proyecto _API_. Haces click derecho en el _,API_ y seleccionas _Add Reference_. En la ventana que se abre, seleccionas ambos _.Domain_ e _.Infrastructure_ y le das _Add_.
Realiza el mismo paso con la capa de _Domain_ pero solo llama a la capa de _Infrastructure_.

Las 3 carpetas que deben existir deberian parecer algo asi:

![img](/Assets/Images/db_architecture.png)

Por ultimo se debera asegurar de tener los paquetes de NuGet instalados. Para ello, haces click derecho en la solucion y seleccionas _Manage NuGet Packages for Solution..._. En la ventana que se abre, seleccionas _Browse_ y buscas los siguientes paquetes y los instalas a:

- Microsoft.EntityFrameworkCore
  - API
  - Infrastructure
- Microsoft.EntityFrameworkCore.Design
  - API
- Microsoft.EntityFrameworkCore.Relational.Design
  - API
- Pomelo.EntityFrameworkCore.MySql
  - API
  - Infrastructure

### 2. Capa Infrastructure

En esta capa se van a crear dos carpetas, una con el nombre de ` models` y otra con el nombre de `context`.

#### 2.1. Models

Dentro de `models` se creara las clases de las tablas que se usaran. Aqui esta un ejemplo de como se vera el codigo:

```csharp
namespace LeadYourWay.Infrastructure.Models;

public class User
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public string Password { get; set; }
    public string Phone { get; set; }
    public DateTime BirthDate { get; set; }
    public virtual List<Bicycle> Bicycles { get; set; }
}
```

Adicionalmente se puede crear un modelo con nombre `BaseModel` que tenga los campos de `Id` y `CreatedAt`, que se consideran genericos. De esta manera, todos los modelos que se creen tendran estos dos campos. El codigo se vera algo asi:

```csharp

```

#### 2.2. Context

Dentro de la carpeta `context` se realiza la conexion con la base de datos y se le agregan restricciones a los datos que quieras. El codigo se vera algo asi:

```csharp
using LeadYourWay.Infrastructure.Models;
using Microsoft.EntityFrameworkCore;

namespace LeadYourWay.Infrastructure.Context;

public class LeadYourWayContext : DbContext
{
    public LeadYourWayContext()
    {

    }

    public LeadYourWayContext(DbContextOptions<LeadYourWayContext> options) : base(options)
    {
    }
    public DbSet<User> Users { get; set; }
    public DbSet<Bicycle> Bicycles { get; set; }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            var serverVersion = new MySqlServerVersion(new Version(8, 0, 29));
            optionsBuilder.UseMySql("Server=localhost,3306;Uid=root;Pwd=1234;Database=db_leadyourway_appsweb;", serverVersion);
        }
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {

        base.OnModelCreating(builder);

        // User
        builder.Entity<User>().ToTable("Users");
        builder.Entity<User>().HasKey(p => p.Id);
        builder.Entity<User>().Property(p => p.Id).IsRequired().ValueGeneratedOnAdd();
        builder.Entity<User>().Property(c => c.Name).IsRequired().HasMaxLength(60);
        builder.Entity<User>().Property(c => c.Email).IsRequired().HasMaxLength(60);
        builder.Entity<User>().Property(c => c.Password).IsRequired().HasMaxLength(60);
        builder.Entity<User>().Property(c => c.Phone).IsRequired().HasMaxLength(60);
        builder.Entity<User>().Property(c => c.BirthDate).IsRequired();

        // Bicycle
        builder.Entity<Bicycle>().ToTable("Bicycles");
        builder.Entity<Bicycle>().HasKey(p => p.Id);
        builder.Entity<Bicycle>().Property(p => p.Id).IsRequired().ValueGeneratedOnAdd();
        builder.Entity<Bicycle>().Property(p => p.Name).IsRequired().HasMaxLength(60);
        builder.Entity<Bicycle>().Property(p => p.Description).IsRequired().HasMaxLength(60);
        builder.Entity<Bicycle>().Property(p => p.Price).IsRequired();
        builder.Entity<Bicycle>().Property(p => p.Size).IsRequired().HasMaxLength(60);
        builder.Entity<Bicycle>().Property(p => p.Model).IsRequired().HasMaxLength(60);
        builder.Entity<Bicycle>().Property(p => p.Image).IsRequired().HasMaxLength(60);
        builder.Entity<Bicycle>().Property(p => p.UserId).IsRequired();

        // Connections
        builder.Entity<Bicycle>()
            .HasOne(c => c.User)
            .WithMany(e => e.Bicycles)
            .HasForeignKey(e => e.UserId);
    }
}
```

> Nota: Tomar nota de la base de datos que esta llamando en `override void OnConfiguring()`. El nombre de la base de datos es `db_leadyourway_appsweb` y esta en el puerto `3306` con el usuario `root` y la contraseña `1234`. Si usted tiene algun datos distinto cambielo aqui y anotalo porque se usara mas adelante.

#### 2.3. Infrastructure

Fuera de las carpetas `models` y `context` se crearan los archis para poder realizar las funciones de get, save, update & delete. Para ello se crean dos archivos, uno de tipo _Interface_ y otro de tipo _Class_. El archivo de tipo _Interface_ se llamara `IUserInfrastructure` y el de tipo _Class_ se llamara `UserMySQLInfrastructure`.
El codigo para `IUserInfrastructure` se vera algo asi:

```csharp
using LeadYourWay.Infrastructure.Models;

namespace LeadYourWay.Infrastructure;

public interface IUserInfrastructure
{
    List<User> GetAll();
    public User GetById(int id);
    public bool save(User value);
    public bool update(int id, User value);
    public bool delete(int id);
}
```

Y el codigo para `UserMySQLInfrastructure` se vera algo asi:

```csharp
using LeadYourWay.Infrastructure.Context;
using LeadYourWay.Infrastructure.Models;

namespace LeadYourWay.Infrastructure;

public class UserMySQLInfrastructure : IUserInfrastructure
{
    private LeadYourWayContext _leadYourWayContext;

    public UserMySQLInfrastructure(LeadYourWayContext leadYourWayContext)
    {
        _leadYourWayContext = leadYourWayContext;
    }

    public List<User> GetAll()
    {
        return _leadYourWayContext.Users.ToList();
    }

    public User GetById(int id)
    {
        return _leadYourWayContext.Users.Find(id);
    }

    public bool save(User value)
    {
        _leadYourWayContext.Users.Add(value);
        _leadYourWayContext.SaveChanges();

        return true;
    }

    public bool update(int id, User value)
    {
        User user = value;
        user.Id = id;

        _leadYourWayContext.Users.Update(user);
        _leadYourWayContext.SaveChanges();

        return true;
    }

    public bool delete(int id)
    {
        User user =  _leadYourWayContext.Users.Find(id);

        _leadYourWayContext.Users.Remove(user);
        _leadYourWayContext.SaveChanges();

        return true;
    }
}
```

> Nota: Hay una cadena que se empieza a formar y empieza todo en context. De alli en infrastructure se llama a context y el los siguientes pasos se vera como domain llama a infrastructure y como api llama a domain.
> Ver tambien que Interface esta solo para instanciar los metodos que se usaran en la clase que implementa la interfaz.

### 3. Capa Domain

En la capa de _Domain_ se sigue una arquitectura similar a los archivos `IUserInfrastructure` y `UserMySQLInfrastructure`. Se crean dos archivos, uno de tipo _Interface_ y otro de tipo _Class_. El archivo de tipo _Interface_ se llamara `IUserDomain` y el de tipo _Class_ se llamara `UserDomain`.

El codigo para `IUserDomain` se vera algo asi:

```csharp
using LeadYourWay.Infrastructure.Models;

namespace LeadYourWay.Domain;

public interface IUserDomain
{
    public bool save(User value);
    public bool update(int id, User value);
    public bool delete(int id);
}
```

Y el codigo para `UserDomain` se vera algo asi:

```csharp
using LeadYourWay.Infrastructure;
using LeadYourWay.Infrastructure.Models;

namespace LeadYourWay.Domain;

public class UserDomain : IUserDomain
{
    public IUserInfrastructure _userInfrastructure;

    public UserDomain(IUserInfrastructure userInfrastructure)
    {
        _userInfrastructure = userInfrastructure;
    }

    public bool save(User value)
    {
        // realizar validaciones aqui
        return _userInfrastructure.save(value);
    }

    public bool update(int id, User value)
    {
        // realizar validaciones aqui
        return _userInfrastructure.update(id, value);
    }

    public bool delete(int id)
    {
        return _userInfrastructure.delete(id);
    }
}
```

> Nota: Como se observa en el codigo ahora se llama a infrastructure y se le pasa la interfaz que se creo en la capa de _Infrastructure_.

### 4. Capa API

#### 4.1. Inyecciones y Base de datos

En esta ultima parte configuraremos los archivos `Program.cs` y `appsettings.json` para que se pueda realizar la conexion a la base de datos y se pueda realizar las peticiones HTTP.

Dentro de `appsettings.json` se debe agregar la siguiente linea de codigo:

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "ConnectionStrings": {
    "LeadYourWayConnection": "Server=localhost,3306;Uid=root;Pwd=1234;Database=db_leadyourway_appsweb;"
  },
  "AllowedHosts": "*"
}
```

> Nota: Aqui se esta usando la misma conexion que se uso en el archivo `LeadYourWayContext.cs` en la capa de _Infrastructure_.

Ahora se debe modificar el archivo `Program.cs` para que se pueda realizar la conexion a la base de datos.
Para lograr aquello, se van a agregar 3 grupos de codigo.

- Las Inyecciones de Dependencias
- La configuracion de la base de datos
- La configuracion en que la base de datos no exista

El codigo del archivo se vera algo asi:

```csharp
using LeadYourWay.Domain;
using LeadYourWay.Infrastructure;
using LeadYourWay.Infrastructure.Context;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// ---------------------------------------- Se agrego esto
// Dependency Injection
builder.Services.AddScoped<IUserInfrastructure, UserMySQLInfrastructure>();
builder.Services.AddScoped<IUserDomain, UserDomain>();
builder.Services.AddScoped<IBicycleInfrastructure, BicycleMySQLInfrastructure>();
builder.Services.AddScoped<IBicycleDomain, BicycleDomain>();

// MySQL Connection
var connectionString = builder.Configuration.GetConnectionString("LeadYourWayConnection");
var serverVersion = new MySqlServerVersion(new Version(8, 0, 29));

builder.Services.AddDbContext<LeadYourWayContext>(
    dbContextOptions =>
    {
        dbContextOptions.UseMySql(connectionString,
            ServerVersion.AutoDetect(connectionString),
            options => options.EnableRetryOnFailure(
                maxRetryCount: 5,
                maxRetryDelay: System.TimeSpan.FromSeconds(30),
                errorNumbersToAdd: null)
        );
    });
// ---------------------------------------- Hasta aqui

var app = builder.Build();

// ---------------------------------------- Y se agrego esto
// Create database if not exists
using (var scope = app.Services.CreateScope())
using (var context = scope.ServiceProvider.GetService<LeadYourWayContext>())
{
    context.Database.EnsureCreated();
}
// ---------------------------------------- Hasta aqui

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
```

> Nota: Se esta inyectando ambas infraestructuras y domain.

#### 4.2. Controladores

Para crear u controlador se hace click derecho en la carpeta `Controllers`, esocges `Add` > `Scaffolded Item...`. En la ventana escoges la opcion `API Controller with read/write actions` y le das un nombre. El nombre debe tener el sufijo `Controller`. Ejemplo: `UserController`.
El codigo se vera algo asi:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LeadYourWay.Domain;
using LeadYourWay.Infrastructure;
using LeadYourWay.Infrastructure.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace LeadYourWay.API
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        // Injections
        private IUserInfrastructure _userInfrastructure;
        private IUserDomain _userDomain;

        public UserController(IUserInfrastructure userInfrastructure, IUserDomain userDomain)
        {
            _userInfrastructure = userInfrastructure;
            _userDomain = userDomain;
        }

        // GET: api/User
        [HttpGet (Name = "GetUser")]
        public List<User> Get()
        {
            return _userInfrastructure.GetAll();
        }

        // GET: api/User/5
        [HttpGet("{id}", Name = "GetUserById")]
        public User Get(int id)
        {
            return _userInfrastructure.GetById(id);
        }

        // POST: api/User
        [HttpPost (Name = "PostUser")]
        public void Post([FromBody] User value)
        {
            _userDomain.save(value);
        }

        // PUT: api/User/5
        [HttpPut("{id}", Name = "PutUser")]
        public void Put(int id, [FromBody] User value)
        {
            _userDomain.update(id, value);
        }

        // DELETE: api/User/5
        [HttpDelete("{id}", Name = "DeleteUser")]
        public void Delete(int id)
        {
            _userDomain.delete(id);
        }
    }
}
```

### Glossary

- **Interfaz**: Es un contrato que se debe cumplir. En este caso, la interfaz `IUserInterface` tiene un metodo llamado `GetAllUsers` que debe ser implementado en la clase `UserMySQLInterface`. En el interfaz no se realiza la implementacion del metodo, solo se declara para que quienes lo implementen sepan que deben hacer.

- **Inyeccion de Dependencias**: Es un patron de diseño que permite que una clase dependa de otra clase sin que esta ultima sea instanciada dentro de la primera. En la vida real, en la capa de Infrastructure, sepodria tener uno para SQL otro para Oracle, y asi para las distintas bases de datos. En nuestro `Controller` entonces en vez de instanciar cada una por separado, se inyecta la dependencia de la interfaz y se usa esta para llamar a los metodos que se necesiten. La modificacion que se realizar dentro el archivo `Program.cs` es quien permite asegurar cual implementacion se usara.

- **Workbench DB**: Al momento de crear una base de datos en Workbench, siempre acuerdate y manten segura tu contraseña. Cuando crees una base de datos tienes la opcione de cambiar el `Character Set` y el `Collation`. El `Character Set` es el conjunto de caracteres que se usaran en la base de datos. Si estarass trabajando con varios tipos de caracteres, usa la opcion `Character Set` y selecciona `uft16`, y en `Collation` escoge la opcion `utf16_unicode_ci`. Esto te permitira trabajar con varios tipos de caracteres.

---

[Regresar al inicio](#indice)

//002
