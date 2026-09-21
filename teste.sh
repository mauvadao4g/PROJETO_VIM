#!/usr/bin/env bash

echo 'Ola tudo bem'

if [[ -z $TESTE ]]; then
  echo 'Ola, tudo bem com voce?'
  echo 'Vamos ver até onde vai isso.'
fi

while [[ 12 == 10 ]]; do
  echo 'COntinuando o script'
done

[[ -z $COMANDO ]] && {
  echo 'Teste'
  exit 0

}
