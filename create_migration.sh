#!/bin/bash

# Verifica se o nome da migração foi fornecido como argumento
if [ $# -eq 0 ]; then
  echo "Por favor, forneça o nome da migração como argumento."
  exit 1
fi

# Executa o comando mix ecto.gen.migration com o nome da migração fornecido
mix ecto.gen.migration $1
