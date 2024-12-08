#!/bin/bash

# Archivo que contiene las URLs
url_file="blackLists.txt"

# Archivo de salida
output_file="combined.txt"

# Eliminar archivo de salida si existe
if [ -f ${output_file} ]; then
    rm ${output_file}
fi

# Descargar y combinar las listas
while IFS= read -r url
do
    # Eliminar espacios en blanco y caracteres no deseados
    url=$(echo $url | tr -d '\r\n')
    echo "Descargando: ${url}"
    response=$(curl -s -f "${url}")
    if [ $? -ne 0 ]; then
        echo "Error al descargar $url (Código de error: $?)"
    else
        echo "$response" >> ${output_file}
        echo "" >> ${output_file}
    fi
done < ${url_file}

# Eliminar duplicados
sort -u ${output_file} -o ${output_file}

echo "Listas combinadas y guardadas en ${output_file}"

