# Intro to ggplot2

# load ggplot2 library
library(ggplot2)

# load gapminder data
gapminder <- read.csv("gapminder.csv")

# scatterplot of lifeExp vs gdpPercap
# aes - aesthetics, makes the connection between values provided for the x-axis and those for y-axis
# geom_point - geometric objects going to be used as graphical representation
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point()

p <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp))
p2 <- p + geom_point()
print(p2)
# change x-axis to logarithmic scale
p3 <- p2 + scale_x_log10()
p4 <- ggplot(gapminder, aes(x = log10(gdpPercap), y = lifeExp)) + geom_point()
p4
p3

(p_china <- filter(gapminder, country == "China") %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) + geom_point() + scale_x_log10())

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) + geom_point() + scale_x_log10()

p3 + aes(color = continent, shape = continent, size = pop, alpha = pop, fill = continent)

gm_china <- gapminder %>%
  filter(country == "China")
ggplot(gm_china, aes(x = gdpPercap, y = lifeExp)) + geom_line(color = "violetred") + 
  geom_point(aes(color = year), size = 6)

gm_china_india <- gapminder %>%
  filter(country %in% c("China", "India"))
ggplot(gm_china_india, aes(x = gdpPercap, y = lifeExp, group = country)) +
  geom_point(aes(color = country), size = 3) + geom_line(alpha = 0.5)

gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(x = lifeExp)) + geom_histogram(binwidth = 2.5, color = "black", fill = "lightblue")

gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(y = lifeExp, x = continent)) +
  geom_boxplot(binwidth = 2.5, color = "black", fill = "lightblue") +
  geom_point(position = position_jitter(width = 0.1, height = 0)) + 
  coord_flip()

gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(x = lifeExp, y = continent)) +
  geom_point(binwidth = 2.5, color = "black", fill = "lightblue",
             position = position_jitter(width = 0, height = 0.1))

# Faceting
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point() + scale_x_log10() +
  facet_grid(continent ~ year)

ggplot(gapminder, aes(x = gdpPercap, color = continent, y = lifeExp)) + geom_point() + scale_x_log10() +
  facet_wrap(~ year)

p <- gapminder %>%
  filter(country %in% c("China", "India", "United States", "France", "Nigeria")) %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp, color = year)) +
  geom_line(size = 2) +
  geom_point(color = "red", size = 1) +
  scale_x_log10() +
  facet_wrap(~ country)

p + theme_bw()
library(ggthemes)
p + theme_wsj()
library(broman)
p + theme_karl()
ggsave("5 countries.pdf", p, height = 7, width = 10)
