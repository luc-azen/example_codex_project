# Example script using Lahman data

library(tidyverse)
library(Lahman)
library(baseballr)

# top 50 winningest managerial seasons since 1960
manager_seasons <- Managers %>%
  filter(yearID >= 1960) %>%
  left_join(Teams %>% select(yearID, teamID, team_name = name, WSWin), by = c("yearID", "teamID")) %>%
  left_join(People %>% select(playerID, nameFirst, nameLast), by = "playerID") %>%
  mutate(manager = paste(nameFirst, nameLast),
         wonWS = WSWin == "Y") %>%
  arrange(desc(W)) %>%
  select(yearID, manager, team_name, W, wonWS) %>%
  slice_head(n = 50)
