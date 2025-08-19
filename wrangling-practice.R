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

