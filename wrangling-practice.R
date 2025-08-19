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


