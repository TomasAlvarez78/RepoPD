module Tiempo 
( Hora(..),
  getHora,
  getMin,
  getRepMin,
  getRepNor,
  getDifHora,
  getDif,
  getRepNorFlotante) where

data Hora = Hora Int Int deriving (Eq)

instance Show Hora where
  show (Hora h m) 
    | h < 10 && m < 10 =  "0" ++  show h ++ ":0" ++ show m
    | h < 10 = "0" ++  show h ++ ":" ++ show m
    | m < 10 = show h ++ ":0" ++ show m
    | otherwise = show h ++ ":" ++ show m

-- Get de Hora
getHora :: Hora -> Int
getHora (Hora h _) = h

-- Get de Min
getMin :: Hora -> Int
getMin (Hora _ m) = m

-- Convierte una hora y devuelve los minutos totales
getRepMin :: Hora -> Int
getRepMin (Hora h m) = h * 60 + m

-- Convierte minutos totales y devuelve la hora
getRepNor :: Int -> Hora
getRepNor m = Hora (m `div` 60) (m `mod` 60)

getRepNorFlotante :: Int -> Float
getRepNorFlotante m = fromIntegral m / 60

-- Devuelve la diferencia horaria entre dos horas en un formato Hora
getDifHora :: Hora -> Hora -> Hora
getDifHora (Hora h1 m1) (Hora h2 m2) 
  | h1 >= h2 = getRepNor $ getRepMin (Hora h1 m1) - getRepMin (Hora h2 m2)
  | otherwise = getRepNor $ getRepMin (Hora h2 m2) - getRepMin (Hora h1 m1) 

-- Devuelve la diferencia horaria entre dos horas en un formato Minutos totales
getDif :: Hora -> Hora -> Int
getDif (Hora h1 m1) (Hora h2 m2) 
  | h1 >= h2 = getRepMin (Hora h1 m1) - getRepMin (Hora h2 m2)
  | otherwise = getRepMin (Hora h2 m2) - getRepMin (Hora h1 m1) 

