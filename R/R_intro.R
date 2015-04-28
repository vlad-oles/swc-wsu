x <- 1
x
y <- x + 3
ls()  # list all the objects in the environment

# a vector of weights
weights <- c(50, 60, 65, 82)  # "c" is for "combine"

animals <- c("mouse", "rat", "dog") # all elements in a vector should be of the same type

length(weights) # number of elements in a vector

class(weights)  # find a class of an object

str(weights)  # find a structure of an object
str(x)

weights <- c(weights, 90) # add new element
weights <- c(30, weights) # add new element

z <- c(x, y, weights)
mean(z)

# Data
getwd() # current directory
list.files()  # list all the files in a directory
setwd("~/Desktop/swc-wsu") # change current directory

getwd()
gapminder <- read.csv("data/gapminder.csv")  # read a file into an object
head(gapminder) # show first records (6 by default) from a data.frame
class(gapminder) # data.frame
str(gapminder)  

weights[1] # 1st element of a vector
weights[1:3] # first 3 elements of a vector

gapminder[1, 1] # first row, first column
gapminder[1, 3] # first row, third column
gapminder[500, 5:6] # 500th row, 5th & 6th columns
gapminder$pop # all values for the "pop" column
gapminder[, 5] # all values for the "pop" column
gapminder[, "pop"] # all values for the "pop" column
gapminder[gapminder$country =="Finland", ] # all rows where country is "Finland"
gapminder[gapminder$pop <= 100000, c(1, 3)] # countries and years where pop <= 100000
gapminder[gapminder$pop <= 100000, c("country", "year")] # countries and years where pop <= 100000
gapminder[gapminder$lifeExp > 80, "country"] # countries which have life expectancies greater than 80

# install a package
install.packages("dplyr")
install.packages("ggplot2")

# load a package
library("dplyr")

select(gapminder, country, year, pop) # select only specified columns from the data.frame
filter(gapminder, country == "Finland")
# put left operand as 1st argument of the right operand, shortcut is Cmd-Shift-M
 %>% 

gapminder_sml <- gapminder %>%
  filter(pop <= 100000) %>%
  select(country, year)
#filter(gapminder, country == "Finland") %>% select(country, year, pop)
filter(gapminder, gdpPercap >= 35000) %>% select(country, year, gdpPercap)

gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  head

gapminder_new <- gapminder %>%
  mutate(totalgdp = gdpPercap * pop)

gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%
  summarize(meangdp = mean(totalgdp))

gapminder <- gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%
  summarize(meangdp = mean(totalgdp), mingdp = min(totalgdp))

gapminder %>%
  group_by(continent) %>%
  summarize(maxlifeExp = max(lifeExp))

gapminder %>%
  group_by(year) %>%
  summarize(meanlifeExp = mean(lifeExp), minlifeExp = min(lifeExp), maxlifeExp = max(lifeExp))

gapminder %>%
  filter(country == "Finland", year <= 1982) %>%
  select(country, year, pop)

write.csv(gapminder_sml, "gapminder_sml.csv")