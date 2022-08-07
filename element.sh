#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

## arguments use ATOMIC NUMBER, SYMBOL, OR NAME

#making variables to check string length later on -- to know what to search by
STRING=$1
LENGTH=$(echo $STRING | wc -c)
#IF ARG IS A NUMBER --- SEARCH BY ATOMIC NUMBER
if [[ $1 =~ ^[0-9]+$ ]]; then
    # get info by ATOM #
    INFO_BY_NUM=$($PSQL "SELECT atomic_number, name, type, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$1")
    echo $INFO_BY_NUM | while IFS=\| read ATOMIC_NUMBER NAME TYPE SYMBOL MASS MP BP; do
        if [[ -z $ATOMIC_NUMBER ]]; then
            echo -e "I could not find that element in the database."
        else
            echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ("$SYMBOL"). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius." | tr -s " " | sed 's/( /(/g' | sed 's/ )/)/g' | sed 's/ ,/,/g'
        fi
    done
#IF ARG IS A STRING OF 1 OR 2 CHARS -- SEARCH BY SYMBOL
elif [[ $LENGTH -le 3 && $LENGTH -ne 1 ]]; then
    # get atomic number by symbol
    INFO_BY_SYMBOL=$($PSQL "SELECT atomic_number, name, type, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol ILIKE '$1'")
    echo $INFO_BY_SYMBOL | while IFS=\| read ATOMIC_NUMBER NAME TYPE SYMBOL MASS MP BP; do
        if [[ -z $ATOMIC_NUMBER ]]; then
            echo -e "I could not find that element in the database."
        else
            echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ("$SYMBOL"). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius." | tr -s " " | sed 's/( /(/g' | sed 's/ )/)/g' | sed 's/ ,/,/g'
        fi
    done
#IF ARG IS LONGER THAN 2 CHARS -- SEARCH BY NAME
elif [[ $LENGTH -gt 3 ]]; then
    # get atomic number by name
    INFO_BY_NAME=$($PSQL "SELECT atomic_number, name, type, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE name ILIKE '$1'")
    echo $INFO_BY_NAME | while IFS=\| read ATOMIC_NUMBER NAME TYPE SYMBOL MASS MP BP; do
        if [[ -z $ATOMIC_NUMBER ]]; then
            echo -e "I could not find that element in the database."
        else
            echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ("$SYMBOL"). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius." | tr -s " " | sed 's/( /(/g' | sed 's/ )/)/g' | sed 's/ ,/,/g'
        fi
    done
else
    echo Please provide an element as an argument.
fi
