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

url <- paste0("https://www.biobiochile.cl/lista/api/buscador?offset=", offset, 
              "&search=", search_encoded, 
              "&intervalo=&orden=ultimas")


# Traer los resultados con una función que se llama GET

response <- GET(url)
status_code(response) # siempre queremos que sea 200

# extraemos el contenido de la respuesta y procesamos el JSON

data_raw <- content(response, "text", encoding = "UTF-8")
data_json <- fromJSON(data_raw, flatten = TRUE)

total_resultados <- data_json$total # este valor es importante guardarlo en caso de que tengamos más de 20 respuestas (el máximo que entrega por cada petición la API)

# seleccionamos algunas columnas y ajustamos el formato del contenido de cada noticia
tabla_resultados <- as_tibble(data_json$notas) |> 
  select(ID, post_title, post_content, post_URL, raw_post_date) |> 
  rowwise() |> 
  mutate(post_content = read_html(post_content) |> html_text2())

writexl::write_xlsx(tabla_resultados, "datos/extraccion-noticias-biobio.xlsx")

# Para seguir explorando en el futuro: iterar en los casos en que el total de resultados sea mayor a 20.
# Robustecer nuestro código: por ejemplo, hacer que status_code(response) == 200 sea una condición para que el resto del código se siga ejecutando


