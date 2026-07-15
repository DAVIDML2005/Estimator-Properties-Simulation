# =====================================================================
# SIMULACIÓN DE PROPIEDADES DE ESTIMADORES
# =====================================================================
# Objetivo: Demostrar mediante simulación las propiedades de los
# estimadores: insesgadez, consistencia y eficiencia
# =====================================================================

# =====================================================================
# PARTE 1: INSESGADEZ DE ESTIMADORES
# =====================================================================

# 1.1 Configuración de parámetros para la simulación
# --------------------------------------------------
mu <- 10        # Media poblacional (parámetro verdadero)
sigma <- 2      # Desviación estándar poblacional
n <- 500        # Tamaño de cada muestra
M <- 1000       # Número de muestras a generar


# 1.2 Simulación de estimadores insesgados
# -----------------------------------------
# Inicializar vectores para almacenar los estimadores
xbar <- rep(NA, M)   # Vector para medias muestrales
s2 <- rep(NA, M)     # Vector para varianzas muestrales

# Bucle para generar M muestras y calcular estimadores
for (i in 1:M) {
  # Generar una muestra aleatoria de distribución normal
  x <- rnorm(n, mean = mu, sd = sigma)
  
  # Calcular y almacenar la media muestral
  xbar[i] <- mean(x)
  
  # Calcular y almacenar la varianza muestral (cuasi-varianza)
  s2[i] <- var(x)
}


# 1.3 Cálculo del valor esperado de los estimadores
# --------------------------------------------------
# Valor esperado de la media muestral (promedio de las medias)
E_xbar <- mean(xbar)

# Valor esperado de la varianza muestral (promedio de las varianzas)
E_s2 <- mean(s2)


# 1.4 Cálculo del sesgo de los estimadores
# -----------------------------------------
# Sesgo de la media muestral: E(xbar) - μ
sesgo_xbar <- E_xbar - mu

# Sesgo de la varianza muestral: E(s²) - σ²
sesgo_s2 <- E_s2 - sigma^2


# 1.5 Visualización de la distribución de los estimadores
# --------------------------------------------------------
# Configurar gráficos en una fila con 2 columnas
par(mfrow = c(1, 2))

# Histograma de las medias muestrales
hist(xbar, 
     freq = FALSE,
     main = paste('Sesgo de xbar =', round(sesgo_xbar, 2)),
     xlab = "Media muestral",
     col = "lightblue",
     border = "darkblue")
abline(v = mu, col = "red", lwd = 2)        # Línea: valor verdadero del parámetro
abline(v = E_xbar, col = "green", lwd = 2)  # Línea: valor esperado del estimador
legend("topright", 
       legend = c("μ verdadero", "E(xbar)"),
       col = c("red", "green"),
       lwd = 2)

# Histograma de las varianzas muestrales
hist(s2, 
     freq = FALSE,
     main = paste('Sesgo de s² =', round(sesgo_s2, 2)),
     xlab = "Varianza muestral",
     col = "lightgreen",
     border = "darkgreen")
abline(v = sigma^2, col = "red", lwd = 2)        # Línea: valor verdadero del parámetro
abline(v = E_s2, col = "green", lwd = 2)         # Línea: valor esperado del estimador
legend("topright",
       legend = c("σ² verdadero", "E(s²)"),
       col = c("red", "green"),
       lwd = 2)

# Interpretación:
# - Si el sesgo es cercano a 0, el estimador es insesgado
# - La media muestral es insesgada para μ
# - La varianza muestral (con n-1) es insesgada para σ²


# =====================================================================
# PARTE 2: CONSISTENCIA DEL ESTIMADOR
# =====================================================================

# 2.1 Configuración para el estudio de consistencia
# -------------------------------------------------
# Parámetros poblacionales
mu <- 10
sigma <- 2

# Número de muestras para cada tamaño
M <- 1000

# Tamaños de muestra crecientes (de 10 a 1000)
nn <- floor(seq(10, 1000, length.out = 50))


# 2.2 Estudio del estimador: v² = ((n-1)/n) * s²
# -----------------------------------------------
# Este estimador es la varianza muestral corregida (no insesgada)
# pero es consistente: converge a σ² cuando n → ∞

# Inicializar vectores para almacenar resultados
E_v2 <- rep(NA, length(nn))     # Esperanza de v² para cada n
var_v2 <- rep(NA, length(nn))   # Varianza de v² para cada n

# Bucle para probar diferentes tamaños de muestra
for (i in 1:length(nn)) {
  n <- nn[i]
  
  # Generar matriz con M muestras de tamaño n
  x <- matrix(rnorm(n * M, mean = mu, sd = sigma), n, M)
  
  # Calcular v² para cada muestra: ((n-1)/n) * s²
  # apply(x, 2, sd) calcula la desviación estándar de cada columna
  v2 <- ((n - 1) / n) * apply(x, 2, sd)^2
  
  # Almacenar la media y varianza de los estimadores
  E_v2[i] <- mean(v2)
  var_v2[i] <- sd(v2)^2
}


# 2.3 Visualización de la consistencia
# -------------------------------------
par(mfrow = c(1, 2))

# Gráfico 1: Convergencia de la esperanza a σ²
plot(nn, E_v2, 
     main = 'E(((n-1)/n)·s²) ---> σ²',
     xlab = "Tamaño de muestra (n)",
     ylab = "Esperanza del estimador",
     type = "b",
     col = "blue",
     pch = 19)
abline(h = sigma^2, col = "red", lwd = 2)  # Línea del valor verdadero
legend("bottomright",
       legend = c("Estimación", "σ² verdadero"),
       col = c("blue", "red"),
       lwd = c(1, 2))

# Gráfico 2: Convergencia de la varianza a 0
plot(nn, var_v2, 
     main = 'var(((n-1)/n)·s²) ---> 0',
     xlab = "Tamaño de muestra (n)",
     ylab = "Varianza del estimador",
     type = "b",
     col = "blue",
     pch = 19)
abline(h = 0, col = "red", lwd = 2)  # Línea del valor límite

# Interpretación:
# - La esperanza del estimador tiende a σ² (convergencia en media)
# - La varianza del estimador tiende a 0 (convergencia en probabilidad)
# - Esto demuestra que el estimador es CONSISTENTE


# =====================================================================
# PARTE 3: CONSISTENCIA DEL ESTIMADOR MÁXIMO VEROSÍMIL PARA EXPONENCIAL
# =====================================================================

# 3.1 Configuración para distribución exponencial
# ------------------------------------------------
theta <- 2      # Parámetro de la distribución exponencial (tasa)
M <- 1000       # Número de muestras
nn <- floor(seq(10, 1000, length.out = 50))  # Tamaños de muestra


# 3.2 Estudio del estimador: θ_est = 1/X̄
# -------------------------------------
# Para la distribución exponencial, el estimador máximo verosímil
# de θ es 1/Media muestral

# Inicializar vectores
E_theta_hat <- rep(NA, length(nn))
var_theta_hat <- rep(NA, length(nn))

# Bucle para diferentes tamaños de muestra
for (i in 1:length(nn)) {
  n <- nn[i]
  
  # Generar matriz con M muestras de distribución exponencial
  x <- matrix(rexp(n * M, rate = theta), n, M)
  
  # Calcular la media de cada muestra
  x_mean <- apply(x, 2, mean)
  
  # Estimar θ usando el EMV
  theta_hat <- 1 / x_mean
  
  # Almacenar resultados
  E_theta_hat[i] <- mean(theta_hat)
  var_theta_hat[i] <- sd(theta_hat)^2
}


# 3.3 Visualización de la consistencia del EMV
# ---------------------------------------------
par(mfrow = c(1, 2))

# Gráfico 1: Convergencia a θ
plot(nn, E_theta_hat, 
     main = 'E(1/X̄) ---> θ',
     xlab = "Tamaño de muestra (n)",
     ylab = "Esperanza del estimador",
     type = "b",
     col = "blue",
     pch = 19,
     ylim = c(theta - 0.5, theta + 0.5))  # Ajustar escala para mejor visualización
abline(h = theta, col = "red", lwd = 2)   # Valor verdadero
legend("bottomright",
       legend = c("Estimación", "θ verdadero"),
       col = c("blue", "red"),
       lwd = c(1, 2))

# Gráfico 2: Convergencia de la varianza a 0
plot(nn, var_theta_hat, 
     main = 'var(1/X̄) ---> 0',
     xlab = "Tamaño de muestra (n)",
     ylab = "Varianza del estimador",
     type = "b",
     col = "blue",
     pch = 19)
abline(h = 0, col = "red", lwd = 2)

# Interpretación:
# - El EMV para la exponencial es consistente
# - Aunque puede tener sesgo para muestras pequeñas (observar la convergencia)
# - La varianza tiende a 0 cuando n crece


# =====================================================================
# PARTE 4: EFICIENCIA DE ESTIMADORES
# =====================================================================

# 4.1 Configuración para comparar eficiencia
# -------------------------------------------
n <- 100        # Tamaño de cada muestra
M <- 10000      # Número de muestras (mayor para mejor precisión)

# Inicializar vectores
xbar <- rep(NA, M)   # Medias muestrales
xmed <- rep(NA, M)   # Medianas muestrales


# 4.2 Simulación de medias y medianas
# ------------------------------------
for (i in 1:M) {
  # Generar muestra de distribución normal
  x <- rnorm(n, mean = mu, sd = sigma)
  
  # Calcular media y mediana
  xbar[i] <- mean(x)
  xmed[i] <- median(x)
}


# 4.3 Cálculo de propiedades
# ----------------------------
# Valor esperado de los estimadores
Exbar <- mean(xbar)
Exmed <- mean(xmed)

# Sesgo de los estimadores
sesgo_xbar <- Exbar - mu
sesgo_xmed <- Exmed - mu


# 4.4 Visualización de la eficiencia
# -----------------------------------
par(mfrow = c(1, 3))

# Histograma de las medias muestrales
hist(xbar, 
     freq = FALSE,
     main = c(paste('Sesgo xbar =', round(sesgo_xbar, 2)),
              paste('Var(xbar) =', round(var(xbar), 2))),
     xlab = "Media muestral",
     col = "lightblue",
     border = "darkblue",
     breaks = 30)
abline(v = mu, col = "black", lwd = 2)          # Valor verdadero
abline(v = Exbar, col = "blue", lwd = 2)        # Valor esperado

# Histograma de las medianas muestrales
hist(xmed, 
     freq = FALSE,
     main = c(paste('Sesgo xmed =', round(sesgo_xmed, 2)),
              paste('Var(xmed) =', round(var(xmed), 2))),
     xlab = "Mediana muestral",
     col = "lightgreen",
     border = "darkgreen",
     breaks = 30)
abline(v = mu, col = "black", lwd = 2)          # Valor verdadero
abline(v = Exmed, col = "blue", lwd = 2)        # Valor esperado

# Densidades superpuestas para comparar eficiencia
plot(density(xbar),
     main = paste('Eficiencia relativa =', 
                  round(var(xmed) / var(xbar), 2)),
     xlab = "Valor del estimador",
     ylab = "Densidad",
     col = "blue",
     lwd = 2,
     xlim = c(8, 12))
lines(density(xmed), col = "green", lwd = 2)
abline(v = mu, col = "red", lwd = 2, lty = 2)
legend("topright",
       legend = c("Media", "Mediana", "μ verdadero"),
       col = c("blue", "green", "red"),
       lty = c(1, 1, 2),
       lwd = 2)

# Interpretación:
# - Eficiencia relativa = var(mediana) / var(media)
# - Si ER > 1: la media es más eficiente (menor varianza)
# - Si ER < 1: la mediana es más eficiente
# - Para la distribución normal, la media es más eficiente


# =====================================================================
# RESUMEN DE RESULTADOS
# =====================================================================

# Imprimir resultados clave
cat("\n========== RESULTADOS DE LA SIMULACIÓN ==========\n\n")

cat("PARTE 1: INSESGADEZ\n")
cat("Sesgo de la media muestral:", round(sesgo_xbar, 4), "\n")
cat("Sesgo de la varianza muestral:", round(sesgo_s2, 4), "\n\n")

cat("PARTE 2: CONSISTENCIA\n")
cat("Esperanza de v² para n =", nn[length(nn)], ":", round(E_v2[length(nn)], 4), 
    "(σ² =", sigma^2, ")\n")
cat("Varianza de v² para n =", nn[length(nn)], ":", round(var_v2[length(nn)], 6), 
    "(→ 0)\n\n")

cat("PARTE 3: CONSISTENCIA (EXPONENCIAL)\n")
cat("Esperanza de θ_est para n =", nn[length(nn)], ":", round(E_theta_hat[length(nn)], 4), 
    "(θ =", theta, ")\n")
cat("Varianza de θ_est para n =", nn[length(nn)], ":", round(var_theta_hat[length(nn)], 6), 
    "(→ 0)\n\n")

cat("PARTE 4: EFICIENCIA\n")
cat("Varianza de la media:", round(var(xbar), 4), "\n")
cat("Varianza de la mediana:", round(var(xmed), 4), "\n")
cat("Eficiencia relativa (var(mediana)/var(media)):", 
    round(var(xmed) / var(xbar), 3), "\n")
cat("Conclusión: La media es", round(var(xmed) / var(xbar), 3), 
    "veces más eficiente que la mediana\n")

