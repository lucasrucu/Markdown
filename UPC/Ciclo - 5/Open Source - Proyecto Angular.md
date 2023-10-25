## Open Source Angular

### Indice

1. [Crear proyecto](#1-crear-proyecto)
2. [Importar librerias](#2-importar-librerias)
3. [Crear Material Module](#3-crear-material-module)
4. [Agregar Imports y Export en _app.module.ts_](#4-agregar-imports-y-export-en-appmodulets)
5. [Crear Componentes](#5-crear-componentes)
6. [Crear Servicios](#6-crear-servicios)
7. [Crear Modelos](#7-crear-modelos)
8. [Extras](#8-extras)

### 1. Crear proyecto

> ng new _nombre-proyecto_
> 
> npm install
> 
> ng serve

En el `app.component.html` donde se encuentra el codigo principal, reemplaza to el codigo con la siguiente linea:

```html
<router-outlet></router-outlet>
```

### 2. Importar librerias

- #### Angular

```
ng add @angular/material
```

- #### Lodash

```
npm i --save-dev @types/lodash
```

- #### Bootstrap

```
npm install bootstrap@3
```

- #### Json Server

```
npm i json-server
```

### 3. Crear Material Module

Crea una carpeta _shared_ en _src_ y dentro de ella crea un archivo _material.module.ts_ con el siguiente contenido:

```typescript
import { NgModule } from "@angular/core";
import { MatButtonModule } from "@angular/material/button";
import { BrowserAnimationsModule } from "@angular/platform-browser/animations";
import { MatTableModule } from "@angular/material/table";
import { MatPaginatorModule } from "@angular/material/paginator";
import { MatSortModule } from "@angular/material/sort";
import { MatInputModule } from "@angular/material/input";
import { MatFormFieldModule } from "@angular/material/form-field";
import { ReactiveFormsModule, FormsModule } from "@angular/forms";
import { MatIconModule } from "@angular/material/icon";
import { MatChipsModule } from "@angular/material/chips";
import { MatGridListModule } from "@angular/material/grid-list";
import { MatCardModule } from "@angular/material/card";
import { MatToolbarModule } from "@angular/material/toolbar";

@NgModule({
  declarations: [],
  imports: [
    MatButtonModule,
    MatIconModule,
    BrowserAnimationsModule,
    MatTableModule,
    MatIconModule,
    MatPaginatorModule,
    MatSortModule,
    MatInputModule,
    MatFormFieldModule,
    MatChipsModule,
    MatGridListModule,
    MatCardModule,
    MatToolbarModule,
    ReactiveFormsModule,
    FormsModule,
  ],
  exports: [
    MatButtonModule,
    MatIconModule,
    BrowserAnimationsModule,
    MatTableModule,
    MatIconModule,
    MatPaginatorModule,
    MatSortModule,
    MatInputModule,
    MatFormFieldModule,
    MatChipsModule,
    MatGridListModule,
    MatCardModule,
    MatToolbarModule,
    ReactiveFormsModule,
    FormsModule,
  ],
})
export class MaterialModule {}
```

### 4. Agregar Imports y Export en _app.module.ts_

```typescript
import { MaterialModule } from "src/app/shared/material.module";
import { HttpClientModule } from "@angular/common/http";
```

Y agregar lo siguiente a la lista de imports:

```typescript
imports: [
    BrowserModule,
    AppRoutingModule,
    MaterialModule,
    HttpClientModule
],
```

### 5. Crear Componentes

- #### Components

> ng g c components/_employee-list_

- #### Views

> ng g c views/_employee-list_

### 6. Crear Servicios

> ng g s services/_employee_

Codigo del servicio:

```typescript
import { Injectable } from "@angular/core";
import {
  HttpClient,
  HttpErrorResponse,
  HttpHeaders,
} from "@angular/common/http";
import { catchError, Observable, retry, throwError } from "rxjs";

@Injectable({
  providedIn: "root",
})
export class HttpDataService {
  base_Url = "http://localhost:3000/api";

  constructor(private http: HttpClient) {}

  //http options
  httpOptions = {
    headers: new HttpHeaders({
      "Content-Type": "application/json",
    }),
  };

  //http API Errors
  handleError(error: HttpErrorResponse) {
    if (error.error instanceof ErrorEvent) {
      // Default Error Handling
      console.log(
        `An error occurred ${error.status}, body was: ${error.error}`
      );
    } else {
      // Unsuccessful Response Error Code returned from Backend
      console.log(
        `Backend returned code ${error.status}, body was: ${error.error}`
      );
    }
    // Return Observable with Error Message to Client
    return throwError(
      "Something happened with request, please try again later."
    );
  }

  createItem(item: any): Observable<any> {
    return this.http
      .post<any>(this.base_Url, JSON.stringify(item), this.httpOptions)
      .pipe(retry(2), catchError(this.handleError));
  }

  getList(): Observable<any> {
    return this.http
      .get<any>(this.base_Url)
      .pipe(retry(2), catchError(this.handleError));
  }

  getItem(id: string): Observable<any> {
    return this.http
      .get<any>(this.base_Url + "/" + id)
      .pipe(retry(2), catchError(this.handleError));
  }

  updateItem(id: string, item: any): Observable<any> {
    return this.http
      .put<any>(
        this.base_Url + "/" + id,
        JSON.stringify(item),
        this.httpOptions
      )
      .pipe(retry(2), catchError(this.handleError));
  }

  deleteItem(id: string): Observable<any> {
    return this.http
      .delete<any>(`${this.base_Url}/${id}`, this.httpOptions)
      .pipe(retry(2), catchError(this.handleError));
  }
}
```

### 7. Crear Modelos

> ng g class models/_employee_ --type=model

Codigo del modelo:

```typescript
export interface Offers {
  id: any;
  title: any;
  description: any;
  points: any;
  businessld: any;
}
```

### 8. Extras

- #### [Page not found](https://freefrontend.com/html-css-404-page-templates/)

  - [404 Cog Wheel](https://codepen.io/1832Manaswini/pen/Vwezyjx)
  - [404 Swinging Light](https://codepen.io/uiswarup/pen/XWdXGGV)

- #### NgForm

Codigo para el html:

```html
<form (submit)="onSubmit()" #movieForm="ngForm">
  <mat-form-field appearance="outline">
    <mat-label>Movie title</mat-label>
    <input
      matInput
      placeholder="Input"
      name="title"
      required
      [(ngModel)]="movieData.title" />
    <mat-icon matSuffix>sentiment_very_satisfied</mat-icon>
  </mat-form-field>
  <mat-form-field appearance="outline">
    <mat-label>Movie rating</mat-label>
    <input
      matInput
      placeholder="Input"
      name="rating"
      required
      [(ngModel)]="movieData.rating" />
    <mat-icon matSuffix>sentiment_very_satisfied</mat-icon>
  </mat-form-field>
  <mat-form-field appearance="outline">
    <mat-label>Movie year</mat-label>
    <input
      matInput
      placeholder="Input"
      name="year"
      required
      [(ngModel)]="movieData.year" />
    <mat-icon matSuffix>sentiment_very_satisfied</mat-icon>
  </mat-form-field>
  <mat-form-field appearance="outline">
    <mat-label>Movie image link</mat-label>
    <input
      matInput
      placeholder="Input"
      name="image"
      required
      [(ngModel)]="movieData.image" />
    <mat-icon matSuffix>sentiment_very_satisfied</mat-icon>
  </mat-form-field>
  <ng-container *ngIf="isEditMode; else elseTemplate">
    <button mat-button color="primary">Update</button>&nbsp;
    <button mat-button color="warn" (click)="cancelEdit()">
      Cancel
    </button> </ng-container
  >&nbsp;
  <ng-template #elseTemplate>
    <button mat-button color="primary">Add</button>
  </ng-template>
</form>
```

Codigo para el ts:

```typescript
import { Component, ViewChild } from "@angular/core";
import { MatTableDataSource } from "@angular/material/table";
import { MovieService } from "src/app/service/movie.service";
import { NgForm } from "@angular/forms";
import { Movie } from "src/app/models/movie.model";
import * as _ from "lodash";

@Component({
  selector: "app-table",
  templateUrl: "./table.component.html",
  styleUrls: ["./table.component.scss"],
})
export class TableComponent {
  //Declaramos el formulario
  @ViewChild("movieForm", { static: false }) movieForm!: NgForm;
  dataSource: MatTableDataSource<any>;

  //Declaramos el modelo de datos
  movieData!: Movie;

  constructor(private movieService: MovieService) {
    this.dataSource = new MatTableDataSource();
    this.movieData = {} as Movie;
  }

  addMovie() {
    this.movieData.id = 0;
    this.movieService.createItem(this.movieData).subscribe((data: any) => {
      this.dataSource.data.push({ ...data });
      this.dataSource.data = this.dataSource.data.map((o) => {
        return o;
      });
    });
  }
}
```

- #### Json Server

Para correr el Json Server existen dos opciones. Ambas opciones se deben correr en la carpeta del proyecto.

1. Correr el comando

```bash
json-server --watch db.json
```

2. Correr el comando que genera rutas personalizadas

```bash
json-server --watch db.json --routes routes.json
```

El archivo \_db.json tendra un codigo similar a este:

```json
[
  {
    "id": 1,
    "title": "The Shawshank Redemption",
    "rating": 9.3
  },
  {
    "id": 2,
    "title": "The Godfather",
    "rating": 9.2,
    "authors": [
      {
        "id": 1,
        "name": "Mario Puzo"
      },
      {
        "id": 2,
        "name": "Francis Ford Coppola"
      }
    ]
  }
]
```

Y el archivo routes.json tendra un codigo similar a este:

```json
{
  "/api/*": "/$1"
}
```

Donde las rutas se pareceran a estas:

```
http://localhost:3000/api/movies
http://localhost:3000/api/movies/1
```

---

[Regresar al inicio](#indice)

//002
