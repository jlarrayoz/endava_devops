#!/bin/bash

node seeds.js

#El exec se utiliza para remplazar el proceso actual (bash -PID 1) con otra app diferente.Esto se usa para que nginx quede con el PID 1 y reciva todas las seniales que se le mandan al contenedor
exec npm start