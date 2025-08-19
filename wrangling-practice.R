#clearing environment
rm(list = ls())

#attach packages
pacman::p_load("tidyverse", "palmerpenguins", "datapasta")

#### data wrangling refresher ####
tidy_pengus_1 <- penguins %>%
  filter(island == "Biscoe" | island == "Dream") %>%  #We only want 2 islands (island %in% c("Biscoe", "Dream"))
  select(-year, -sex) %>% #we dont care about year or sex
  mutate(body_mass_kg = body_mass_g / 1000) %>% #i dont like grams so lets get kg
  rename(location = island) #we wanted to change island to location

#2

tootidy_2pengus <- penguins %>%
  filter(species == "Adelie") %>%
  filter(!is.na(flipper_length_mm), !is.na(sex)) %>%
  group_by(sex) %>%
  summarize(mean = mean(flipper_length_mm),
            standard_dev = sd(flipper_length_mm),
            sample_size = n())


#### Wrangling continued ####
animals <- data.frame(
  stringsAsFactors = FALSE,
          location = c("lagoon", "bluff", "creek", "oaks", "bluff"),
           species = c("bobcat", "coyote", "fox", "squirrel", "bobcat"),
          maturity = c("adult", "juvenile", "adult", "juvenile", "adult")
) #tools-> addins -> browse -> paste as df

sites <- data.frame(
  stringsAsFactors = FALSE,
          location = c("beach", "lagoon", "bluff", "oaks"),
             full_site_name = c("Goleta Beach","UCSB Lagoon","Ellwood Mesa",
                                "Fremont Campground"),
      jurisdiction = c("SB City", "UCSB", "SB City", "USFS")
         )


#### Join Practice ####

#full_join
full_join_example <- full_join(animals, sites); full_join_example

#Left_join

left_join_ex <- left_join(animals, sites); left_join_ex

#right_join

right_join_ex <- right_join(animals, sites); right_join_ex #double bluff

#inner_join

inner_join_ex <- inner_join(animals, sites);inner_join_ex

#filtering_joins

#semi_join

semi_join_ex <- semi_join(animals,sites);semi_join_ex

#same as

animals %>%
  filter(location %in% sites$location)

#anti_join

anti_join_ex <- anti_join(animals, sites); anti_join_ex

#### Lubridate ts####
#month first
my_date <- "03-15-1998"

lubridate::mdy(my_date) #you have to tell lubridate mdy

#day first
my_date <- "08-Jun-1974"

lubridate::dmy(my_date) #need to do dmy
#year first
my_date <- "19610818"

lubridate::ymd(my_date)

#can fail
lubridate::mdy("1942/08/30")

#or be misleading
lubridate::dmy ("09/12/84")

#working with date_times

time <- "2020-08-12 11:18"
time <- ymd_hm(time) #,tz = "America/Los_angeles" sets tz

#convert to pdt
with_tz(time, tzone = "America/Los_angeles") #didnt add tz but converted our time zone to pdt

#extract info from dates
week(time)
year(time)
day(time)
month(time)
hour(time)
minute(time)
tz(time)

#can get current time at computer
Sys.time()

start_time <- Sys.time()

end_time <- Sys.time()

end_time - start_time

#### Practice lubridate in df ####
urchin_counts <- tribble(
  ~date, ~species, ~size_mm,
  "10/30/2020", "purple", 55,
  "10/4/2020", "red", 48,
  "11/17/2020", "red", 67
)

urchin_counts %>%
  mutate(date = lubridate::mdy(date)) %>%
  mutate(year = year(date),
         month = month(date),
         day = day(date))


#math with dates
day_1 <- ymd("2020/1/6")
day_2 <- ymd("2020/5/18")
day_3 <- ymd("2020/5/19")

#create time interval
time_interval <- interval(day_1, day_2);time_interval
time_length(time_interval, "week")
time_length(time_interval, "year")
time_length(time_interval, "second")

#### stringr ####

#str detect to detect string patterns

my_string <- "Teddy loves eating salmon and socks"

#Does "love" exist within the string

my_string %>%
  str_detect("love")

my_string %>%
  str_detect("pup")

#works over data frame

my_string <- c("burrito", "fish taco", "taco salad")

#Contains fish?

my_string %>%
  str_detect("fish")


#VERY powerful when in combo with other functions

head(starwars)

skywalkers <- starwars %>%
  filter(str_detect(name, "Skywalker")); skywalkers

#Str replace to replace with pattern

firewalkers <- starwars %>%
  mutate(name = str_replace(name, pattern = "Sky",
                            replacement = "Fire"))


#Ugly string to work with

feedback <- c(" I ate    nachos     some   nachos", "Wednesday morning    "); feedback

#remove leading, trailing and duplicate spaces

str_squish(feedback)

#remove leading and trailing
str_trim(feedback)

#Lowercase
str_to_lower(feedback)

#Uppercase

str_to_upper(feedback)

#Title
str_to_title(feedback)

#count matches

str_count(feedback, pattern = "nachos")


