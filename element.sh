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
        echo -e "\n$INFO_BY_NUM"
    fi
else
    echo Please provide an element as an argument.
fi
