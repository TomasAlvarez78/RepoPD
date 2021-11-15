import Tiempo
import System.IO (openFile, hGetContents, IOMode (ReadMode), hClose)
import Data.List (isPrefixOf,union)
import Numeric

main :: IO ()
main = do
    archivo <- openFile "09septiembre2019.txt" ReadMode
    contenido  <- hGetContents archivo
    let lineas = lines contenido
        registros = filter filtrarRenglon lineas
        dia = map (tomarCampo 0) registros
        fecha = map (tomarFecha 1) registros
        entrada = map (tomarCampo 2) registros
        salida = map (tomarCampo 3) registros
        -- Ejercicio 1
        horasentrada = map myHoraConverter entrada
        horassalida = map myHoraConverter salida
        horadiferencia = zipWith getDifHora horasentrada horassalida
        horitas = map show horadiferencia
        stringEjercicio1 = concatenarLineas2 dia fecha horitas
        -- Fin Ejercicio 1
        -- Ejercicio 2
        registros2 = filter filtrarEmpleados lineas
        cantidadEmpleados = length registros2
        -- Fin Ejercicio 2
        -- Ejercicio 3
        horasdiferenciaMin = map getRepMin horadiferencia
        horastotalesMin = sum horasdiferenciaMin
        horastotales = getRepNorFlotante horastotalesMin
        -- Fin Ejercicio 3
        -- Ejercicio 4
        horasporempleado = horastotales / fromIntegral cantidadEmpleados
        -- Fin Ejercicio 4
        -- Ejercicio 5
        -- 21 porque son en promedio 21 dias de trabajo en el mes
        horasporempleadoDia = horasporempleado / 21 
        -- Fin Ejercicio 5

    putStrLn stringEjercicio1
    putStrLn $ mostrarEmpleados cantidadEmpleados
    putStrLn $ mostrarHorasTotales horastotales
    putStrLn $ mostrarHorasPorEmpMensual horasporempleado
    putStrLn $ mostrarHorasPorEmpDiario horasporempleadoDia
    hClose archivo

--Funcion para mostrar texto de Ejercicio 1
mostrarEmpleados :: Int -> [Char]
mostrarEmpleados a = "Cantidad de empleados: " ++ show a

--Funcion para mostrar texto de Ejercicio 2
mostrarHorasTotales :: Float -> [Char]
mostrarHorasTotales a = "Horas totales: " ++ showFFloat (Just 2) a ""

--Funcion para mostrar texto de Ejercicio 3
mostrarHorasPorEmpMensual :: Float -> [Char]
mostrarHorasPorEmpMensual a = "Horas por empleado mensual: " ++ showFFloat (Just 2) a ""

--Funcion para mostrar texto de Ejercicio 4
mostrarHorasPorEmpDiario :: Float -> [Char]
mostrarHorasPorEmpDiario a = "Horas por empleado diario: " ++ showFFloat (Just 2) a ""

--Funcion para contar la cantidad de empleados
filtrarEmpleados :: [Char] -> Bool
filtrarEmpleados xs |  "\"Empleado:" `isPrefixOf` xs = True
                    | otherwise = False

--Esta funcion convierte un char en Horas utilizado en el constructor de Horas
myHoraConverter :: [Char] -> Hora
myHoraConverter dato = Hora (tomarHora dato) (tomarMinuto dato)

--Esta funcion filtra especificamente los dias de la semana
filtrarRenglon :: [Char] -> Bool
filtrarRenglon xs | "\"Lunes" `isPrefixOf` xs = True
                  | "\"Martes" `isPrefixOf` xs = True
                  | "\"Miercoles" `isPrefixOf` xs = True
                  | "\"Jueves" `isPrefixOf` xs = True
                  | "\"Viernes" `isPrefixOf` xs = True
                  | otherwise = False

-- Esta funcion toma el campo de la posicion requerida
tomarCampo :: Int -> String -> [Char]
tomarCampo n = tail . init . (!! n) . words

-- Esta funcion devuelve la fecha especificamente
tomarFecha :: Int -> String -> [Char]
tomarFecha n = (!! n) . words

-- Un concatenar lineas que recibe 4 listas
concatenarLineas :: [[Char]] -> [[Char]] -> [[Char]] -> [[Char]] -> [Char]
concatenarLineas (d:ds) (f:fs) (e:es) (s:ss) = d ++ "\t\t" ++ f ++ "\t" ++ e ++ " \t" ++ s ++ "\n" ++ concatenarLineas ds fs es ss
concatenarLineas _ _ _ _  = ""

-- Un concatenar lineas que recibe 3 listas
concatenarLineas2 :: [[Char]] -> [[Char]] -> [[Char]] -> [Char]
concatenarLineas2 (d:ds) (f:fs) (e:es) = d ++ "\t\t" ++ f ++ "\t" ++ e ++ "\n" ++ concatenarLineas2 ds fs es
concatenarLineas2 _ _ _  = ""

-- Esta funcion extrae la hora de un String, los primeros 2 valores
tomarHora :: [Char] -> Int
tomarHora "" = 0
tomarHora n = read (takeWhile (/= ':') n) :: Int

-- Esta funcion extrae los minutos de un String, los ultimos 2 valores
tomarMinuto :: [Char] -> Int
tomarMinuto "" = 0
tomarMinuto n = read (tail $ dropWhile (/= ':') n) :: Int

