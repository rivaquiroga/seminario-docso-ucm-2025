# Paquetes que vamos a utilizar

library(httr)
library(jsonlite)
library(dplyr)
library(lubridate)
library(rvest)

# Pegar la url de ejemplo para entender cómo funciona:

"https://www.biobiochile.cl/lista/api/buscador?offset=0&search=ciencia+abierta&intervalo=&orden=ultimas"

# Definir la búsqueda

search_query <- "ciencia abierta"
search_encoded <- URLencode(search_query)
offset = "0"
  
# Construir la URL para la API de Biobio 

url <- paste0("https://www.biobiochile.cl/lista/api/buscador?offset=", 
              offset, 
              "&search=", 
              search_encoded, 
              "&intervalo=&orden=ultimas")


# Traer los resultados con una función que se llama GET

response <- GET(url)
status_code(response) # siempre queremos que sea 200

# convertir a datos brutos

data_raw <- content(response, "text", encoding = "UTF-8")
data_json <- fromJSON(data_raw, flatten = TRUE)

total_resultados <- data_json$total

tabla_resultados <- as_tibble(data_json$notas) |> 
  select(ID, post_title, post_content, post_URL, raw_post_date) |> 
  rowwise() |> 
  mutate(post_content = read_html(post_content) |> html_text2())


writexl::write_xlsx(tabla_resultados, "datos/extraccion-noticias-biobio.xlsx")
