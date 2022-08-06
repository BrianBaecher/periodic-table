#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

## arguments use ATOMIC NUMBER, SYMBOL, OR NAME

# get atomic number by name
ATOM_NUM_BY_NAME=$($PSQL "SELECT atomic_number FROM elements WHERE name LIKE '$1'")
# get atomic number by symbol

# get info by ATOM #
INFO_BY_NUM=$($PSQL "SELECT atomic_number, name, type, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$1")

# get symbol

# get type

# get mass

# get melting point

# get boiling point
if [[ $1 ]]; then
    if [[ $1 =~ ^[0-9]+$ ]]; then
        echo $INFO_BY_NUM | while IFS=\| read ATOMIC_NUMBER NAME TYPE SYMBOL MASS MP BP
        do
        echo -e "\n The element with atomic number $ATOMIC_NUMBER is $NAME ("$SYMBOL"). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP."| tr -s " " | sed 's/( /(/g' | sed 's/ )/)/g'
        done
    fi
else
    echo Please provide an element as an argument.
fi
