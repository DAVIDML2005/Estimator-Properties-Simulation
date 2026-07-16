# Simulación de las Propiedades de los Estimadores

## Descripción General

Este repositorio presenta una colección de simulaciones desarrolladas en R para estudiar y visualizar las propiedades fundamentales de los estimadores estadísticos mediante experimentos de Monte Carlo. En lugar de centrarse únicamente en las demostraciones matemáticas, este proyecto utiliza simulaciones computacionales para mostrar cómo se comportan los estimadores bajo muestreo repetido, permitiendo verificar de forma empírica los conceptos teóricos de la estadística inferencial.

## Objetivos

- Estudiar el comportamiento de los estimadores estadísticos mediante simulaciones.
- Verificar empíricamente los resultados teóricos de la estadística inferencial.
- Ilustrar los conceptos de insesgadez, consistencia y eficiencia.
- Comparar distintos estimadores mediante muestreo aleatorio repetido.
- Fortalecer la intuición estadística a través de experimentos computacionales en R.

## Conceptos Estadísticos Abordados

Este repositorio explora tres propiedades fundamentales que determinan la calidad de los estimadores estadísticos.

### Insesgadez

Un estimador es insesgado si su valor esperado es igual al verdadero valor del parámetro poblacional.

Matemáticamente,

$$E(\hat{\theta}) = \theta$$

El sesgo de un estimador se define como:

$$\text{Sesgo}(\hat{\theta}) = E(\hat{\theta}) - \theta$$

Un estimador insesgado tiene sesgo igual a cero, lo que significa que, en promedio y considerando un número infinito de muestras aleatorias, estima correctamente el verdadero valor del parámetro.

### Consistencia

Un estimador es consistente si converge al verdadero parámetro poblacional a medida que aumenta el tamaño de la muestra.

Formalmente,

$$\hat{\theta} \xrightarrow{P} \theta, \quad \text{cuando } n \to \infty$$

Un estimador consistente satisface dos condiciones importantes:

#### El valor esperado converge

$$\lim_{n \to \infty} E(\hat{\theta}) = \theta$$

#### La varianza converge a cero

$$\lim_{n \to \infty} \text{Var}(\hat{\theta}) = 0$$

A medida que se dispone de muestras más grandes, el estimador se concentra cada vez más alrededor del verdadero valor del parámetro.

### Eficiencia

Al comparar dos estimadores insesgados de un mismo parámetro, se prefiere aquel que presenta la menor varianza.

Si se cumple que:

$$\text{Var}(\hat{\theta}_1) < \text{Var}(\hat{\theta}_2)$$

entonces se considera que $\hat{\theta}_1$ es más eficiente que $\hat{\theta}_2$.

La eficiencia relativa ($RE$) se define como:

$$ER = \frac{\text{Var}(\hat{\theta}_2)}{\text{Var}(\hat{\theta}_1)}$$

Una mayor eficiencia relativa indica una mayor precisión para un mismo tamaño de muestra.

## Metodología

Las simulaciones se desarrollan completamente en R utilizando métodos de Monte Carlo. Cada experimento sigue el mismo flujo general de trabajo:

1. Definir el modelo poblacional.
2. Generar un gran número de muestras aleatorias.
3. Calcular uno o más estimadores.
4. Analizar sus distribuciones empíricas.
5. Estimar el sesgo y la varianza.
6. Comparar los resultados empíricos con las expectativas teóricas.
7. Visualizar el comportamiento de los estimadores mediante gráficos estadísticos.

## Propósito

El objetivo principal de este repositorio es educativo. Al combinar conceptos teóricos de la estadística con simulaciones computacionales, el proyecto proporciona una comprensión intuitiva de cómo se comportan los estimadores bajo muestreo repetido y por qué sus propiedades teóricas son fundamentales en la inferencia estadística. Este repositorio sirve como complemento práctico para cursos de probabilidad, estadística matemática, estadística inferencial y ciencia de datos.
