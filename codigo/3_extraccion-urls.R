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

  
