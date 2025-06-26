# Los paquetes que vamos a utilizar

library(rvest)
library(dplyr)
library(readr)
library(lubridate)
library(purrr)

# Paso 1: Guardar la url en un objeto y leer el código fuente de esa página

url_noticias <- "https://www.minciencia.gob.cl/noticias/?p=2"

html_noticias <- read_html(url_noticias)

# Paso 2: Extrer los elementos que nos interesan

titulares <- html_noticias  |> 
  html_elements("h3") |> 
  html_text2()

fechas <- html_noticias |> 
  html_elements("small") |> 
  html_text2() |> 
  dmy(locale = "es_ES")

urls <- html_noticias |> 
  html_elements("div.card-body>a") |> 
  html_attr("href")

# Paso 3: Guardar todo esto dentro de una tabla

tabla_noticias <- tibble(fecha = fechas, titular = titulares, url = urls) |> 
  mutate(url = paste0("https://www.minciencia.gob.cl", url))


# Lo que hicimos recién fue probar el código para extraer las urls + fecha + titular de una página. Lo que vamos a hacer ahora es escalar este proceso para extraer estos datos de todas las páginas. Para ello vamos a convertir nuestro código en una función que podamos utilizar. 


extraer_urls <- function(pagina){
  
  # Paso 0: dejar pasar 3 segundos
  
  Sys.sleep(3)
  
  # Paso 1: Guardar la url en un objeto y leer el código fuente de esa página
  
  url_noticias <- paste0("https://www.minciencia.gob.cl/noticias/?p=", pagina)
  
  html_noticias <- read_html(url_noticias)
  
  # Paso 2: Extrer los elementos que nos interesan
  
  titulares <- html_noticias  |> 
    html_elements("h3") |> 
    html_text2()
  
  fechas <- html_noticias |> 
    html_elements("small") |> 
    html_text2() |> 
    dmy(locale = "es_ES")
  
  urls <- html_noticias |> 
    html_elements("div.card-body>a") |> 
    html_attr("href")
  
  # Paso 3: Guardar todo esto dentro de una tabla
  
  tabla_noticias <- tibble(fecha = fechas, titular = titulares, url = urls) |> 
    mutate(url = paste0("https://www.minciencia.gob.cl", url))
  
  return(tabla_noticias)
  
}

# Vamos a probar que nuestro código funciona y extrae datos de distintas páginas

extraer_urls(30)


# ¿Cómo hacer para extraer de varias páginas al mismo tiempo? 
# La función map nos permite indicar lso argumentos por los que queremos que itere nuestra función. En este caso, los número del 1 al 3. Por defecto nos devuelve una lista con tres tablas en su interior (una por cada vez que aplicó la funció). Para que quede todo como una sola tabla, agregamos la función list_rbind()

map(26:29, extraer_urls) |> 
  list_rbind()

# Vamos a extraer los datos de las páginas 1 a 29

noticias_minciencia <- map(1:29, extraer_urls) |> 
  list_rbind()


# Vamos a guardar esto como un archivo csv

write_csv(noticias_minciencia, "datos/noticias-minciencia.csv")



