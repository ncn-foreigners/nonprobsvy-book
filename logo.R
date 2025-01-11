library(hexSticker)
library(ggplot2)
library(dplyr)

# Create sample data
set.seed(123)
# Population points - zmniejszony rozrzut
pop_data <- data.frame(
  x = rnorm(100, mean = 0, sd = 0.7),  # zmniejszone sd
  y = rnorm(100, mean = 0, sd = 0.7),  # zmniejszone sd
  type = "population"
)

# Non-probability sample points with different weights - bardziej skupione
nonprob_sample <- data.frame(
  x = rnorm(15, mean = 0.3, sd = 0.5),  # zmienione parametry rozkładu
  y = rnorm(15, mean = 0.3, sd = 0.5),
  type = "nonprob_sample",
  weight = runif(15, 0.5, 2)
)

# Probability sample points - bardziej skupione
prob_sample <- data.frame(
  x = rnorm(15, mean = 0, sd = 0.6),    # zmniejszone sd
  y = rnorm(15, mean = 0, sd = 0.6),
  type = "prob_sample",
  weight = 1
)

# Combine data
plot_data <- rbind(
  pop_data %>% mutate(weight = 1, type = "population"),
  nonprob_sample,
  prob_sample
)

# Create the base plot
p <- ggplot(plot_data, aes(x = x, y = y)) +
  # Add points with size based on weights
  geom_point(aes(size = weight, color = type, alpha = type)) +
  # Customize colors
  scale_color_manual(values = c(
    "population" = "grey80",
    "nonprob_sample" = "#3366CC",    # Blue for non-probability sample
    "prob_sample" = "#4DAF4A"        # Green for probability sample
  )) +
  scale_alpha_manual(values = c(
    "population" = 0.3,
    "nonprob_sample" = 0.8,
    "prob_sample" = 0.8
  )) +
  # Adjust size scale
  scale_size_continuous(range = c(1, 3)) +  # zmniejszony zakres wielkości punktów
  # Add tighter limits to control plot boundaries
  coord_cartesian(xlim = c(-1.5, 1.5), ylim = c(-1.5, 1.5)) +  # węższe granice
  # Remove grid and axis labels
  theme_void() +
  theme(legend.position = "none")

# Create the hex sticker
sticker(
  p,  # Your plot
  package = "nonprobsvy",  # Replace with your package name
  p_size = 20,  # Package name text size
  p_color = "#3366CC",  # Package name color matches non-prob sample
  p_y = 1.5,  # Package name y position
  
  # Subplot properties
  s_x = 1,  # Subplot x position
  s_y = 0.9,  # Subplot y position
  s_width = 1.2,  # Subplot width - zmniejszona
  s_height = 1.2,  # Subplot height - zmniejszona
  
  # Hexagon properties
  h_fill = "white",  # Hexagon fill color
  h_color = "#3366CC",  # Hexagon border color matches non-prob sample
  
  # Output specifications
  filename = "images/hex_sticker_v4.png",
  dpi = 300
)