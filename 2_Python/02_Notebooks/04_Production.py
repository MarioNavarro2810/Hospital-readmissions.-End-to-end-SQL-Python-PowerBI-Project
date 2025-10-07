#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd
from sqlalchemy import create_engine
import pymysql

# Funcion de cálculo del RSC

def calcular_scoring(registro):
    scoring = 0  # Inicializamos el scoring en 0
    
    # Reglas para calcular el puntaje basado en la tabla dada
    if registro.get("cardiomiopatia_previa") == 1:
        scoring += 52
    else:
        scoring += 8

    if registro.get("dm") == 1:
        scoring += 49
    else:
        scoring += 11

    if "duracion_estancia_ci_disc" in registro:
        duracion_estancia_ci_disc = registro["duracion_estancia_ci_disc"]
        if duracion_estancia_ci_disc in ["(-1, 0]", "(0, 10]"]:
            scoring += 19 if duracion_estancia_ci_disc == "(-1, 0]" else 23
        elif duracion_estancia_ci_disc == "(10, 20]":
            scoring += 30
        elif duracion_estancia_ci_disc == "(20, 28]":
            scoring += 42
        elif duracion_estancia_ci_disc == "(28, 35]":
            scoring += 27
        elif duracion_estancia_ci_disc == "(35, 100]":
            scoring += 33

    if "duracion_estancia_disc" in registro:
        duracion_estancia_disc = registro["duracion_estancia_disc"]
        if duracion_estancia_disc == "(0, 10]":
            scoring += 22
        elif duracion_estancia_disc == "(10, 25]":
            scoring += 29
        elif duracion_estancia_disc == "(25, 60]":
            scoring += 30
        elif duracion_estancia_disc == "(60, 100]":
            scoring += 100

    if "edad_disc" in registro:
        edad_disc = registro["edad_disc"]
        if edad_disc == "(0, 20]":
            scoring += 13
        elif edad_disc == "(20, 50]":
            scoring += 17
        elif edad_disc == "(50, 80]":
            scoring += 23
        elif edad_disc == "(80, 150]":
            scoring += 31

    if registro.get("erc") == 1:
        scoring += 51
    else:
        scoring += 10
    
    if registro.get("iamcest") == 1:
        scoring += 47
    else:
        scoring += 12
    
    if registro.get("icfen") == 1:
        scoring += 53
    else:
        scoring += 8
    
    if registro.get("icfer") == 1:
        scoring += 54
    else:
        scoring += 7
    
    if registro.get("insuficiencia_cardiaca") == 1:
        scoring += 54
    else:
        scoring += 6
    
    if registro.get("lra") == 1:
        scoring += 50
    else:
        scoring += 10
    
    if registro.get("sca") == 1:
        scoring += 47
    else:
        scoring += 12
    
    return scoring


# Acceso a la fuente de datos
usuario = 'root'  
contrasena = 'DS4B'  
host = 'localhost'  
puerto = '3306'  
base_datos = 'dm_cardiologia'  
con = create_engine(f"mysql+pymysql://{usuario}:{contrasena}@{host}:{puerto}/{base_datos}")

# Carga de los datos
admisiones = pd.read_sql("SELECT * FROM admisiones", con.connect())
diagnosticos = pd.read_sql("SELECT * FROM diagnosticos", con.connect())
factores_riesgo = pd.read_sql("SELECT * FROM factores_riesgo", con.connect())
pacientes = pd.read_sql("SELECT * FROM pacientes", con.connect())
pruebas_laboratorio = pd.read_sql("SELECT * FROM pruebas_laboratorio", con.connect())
con.dispose()

# Integracion
df = pacientes.merge(
    admisiones.drop(columns=['id_paciente']),
    on="id_admision",
    how="left"
).merge(
    factores_riesgo,
    on=["id_admision", "id_paciente"],
    how="left"
).merge(
    pruebas_laboratorio,
    on="id_admision",
    how="left"
).merge(
    diagnosticos,
    on="id_admision",
    how="left"
)

# Transformacion de datos
df.loc[df['duracion_estancia_ci'] > df['duracion_estancia'], 'duracion_estancia_ci'] = df['duracion_estancia']

# Creacion de la variable 'reingreso'
df = df.sort_values(by=['id_paciente','fecha_admision'])
df['reingreso'] = (df['id_paciente'] == df['id_paciente'].shift(1)).astype(int)

# Calculo del scoring
df['scoring'] = df.apply(calcular_scoring, axis=1)

#Cambio de escala
df['scoring'] = (df['scoring'] - df['scoring'].min()) / (df['scoring'].max() - df['scoring'].min()) * 10
df['scoring'] = df['scoring'].astype('int')


# In[ ]:




