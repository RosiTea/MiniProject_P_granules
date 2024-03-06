install.packages("ggplot2")
install.packages("tidyverse")

library(ggplot2)
library(tidyverse)

combined_model <- read_csv("20240305_data/CombinedModel.csv")

cm_long <- combined_model %>%
  pivot_longer(
    cols = -c(Location, Name), # Exclude Location and Name from the gathering
    names_to = "Time",
    values_to = "Amount",
    names_transform = list(Time = as.integer) # Converts time step names into integers
  )

ggplot(cm_long, aes(x = Time, y = Amount, colour = Name, group = Name)) + 
  geom_line() +
  theme_minimal() +
  labs(
    title = "Simulation of Protein Amount Over Time",
    x = "Time Step",
    y = "Relative Amount",
    colour = "Protein Name"
  ) +
  theme(legend.position = "right") 

# Subset of proteins you want to plot
post_proteins <- c("PLK1_post", "MEG3_post", "MEG3_RNA_post", "PGL3_post", "PGL3_RNA_post", "RNA_post")
ant_proteins <- c("PLK1_ant", "MEG3_ant", "MEG3_RNA_ant", "PGL3_ant", "PGL3_RNA_ant", "RNA_ant")
granule_proteins <- c("MEG3_granule", "PGL3_granule")

# Filter the dataframe to include only the selected proteins
cm_post_subset <- cm_long %>% 
  filter(Name %in% post_proteins)
cm_ant_subset <- cm_long %>% 
  filter(Name %in% ant_proteins)
cm_g_subset <- cm_long %>% 
  filter(Name %in% granule_proteins)

# Now plot the filtered data
ggplot(cm_post_subset, aes(x = Time, y = Amount, colour = Name, group = Name, linetype = Name)) + 
  geom_line(size=1.5) +
  theme_minimal() +
  labs(
    title = "Simulation of Posterior Protein or RNA Amount Over Time",
    x = "Time Step",
    y = "Protein or RNA Level Score (0-6)",
    colour = "Protein or RNA",
    linetype = "Protein or RNA" 
  ) +
  theme(legend.position = "right",
        panel.grid.major.x = element_line(colour = "grey80", size = 0.5),
        panel.grid.minor.x = element_blank(), 
        panel.grid.major.y = element_line(colour = "grey80", size = 0.5), 
        panel.grid.minor.y = element_blank(),
        axis.text.x = element_text(size = 12, colour = "black"), 
        axis.text.y = element_text(size = 12, colour = "black"), 
        axis.title.x = element_text(size = 14, face = "bold"), 
        axis.title.y = element_text(size = 14, face = "bold"),
        axis.line = element_line(size = 1, colour = "black"),
        title = element_text(size = 14, face = "bold")
  )+
  geom_vline(xintercept = seq(0, 30, by = 1), colour = "grey80", size = 0.5) +
  scale_colour_manual(values = c(
    "PLK1_post" = "#E69F00", 
    "MEG3_RNA_post" = "#56B4E9", "MEG3_post" = "#56B4E9",
    "PGL3_RNA_post" = "#009E73", "PGL3_post" = "#009E73",
    "RNA_post" = "#F0E442"
  )) +
  scale_linetype_manual(values = c(
    "PLK1_post" = "solid", 
    "MEG3_RNA_post" = "solid", "MEG3_post" = "twodash",
    "PGL3_RNA_post" = "solid", "PGL3_post" = "twodash",
    "RNA_post" = "solid"
  )) +
  scale_x_continuous(
    limits = c(0, 30), 
    breaks = seq(0, 30, by = 5), 
    expand = c(0,0)
  )+
  scale_y_continuous(
    limits = c(0,6),
    breaks = seq(0,6,by=1),
    expand = c(0,0.02)
  )
ggplot(cm_ant_subset, aes(x = Time, y = Amount, colour = Name, group = Name, linetype = Name)) + 
  geom_line(size=1.5) +
  theme_minimal() +
  labs(
    title = "Simulation of Anterior Protein or RNA Amount Over Time",
    x = "Time Step",
    y = "Protein or RNA Level Score (0-6)",
    colour = "Protein or RNA",
    linetype = "Protein or RNA" 
  ) +
  theme(legend.position = "right",
        panel.grid.major.x = element_line(colour = "grey80", size = 0.5),
        panel.grid.minor.x = element_blank(), 
        panel.grid.major.y = element_line(colour = "grey80", size = 0.5), 
        panel.grid.minor.y = element_blank(),
        axis.text.x = element_text(size = 12, colour = "black"), 
        axis.text.y = element_text(size = 12, colour = "black"), 
        axis.title.x = element_text(size = 14, face = "bold"), 
        axis.title.y = element_text(size = 14, face = "bold"),
        axis.line = element_line(size = 1, colour = "black"),
        title = element_text(size = 14, face = "bold")
  )+
  geom_vline(xintercept = seq(0, 30, by = 1), colour = "grey80", size = 0.5) +
  scale_colour_manual(values = c(
    "PLK1_ant" = "#E69F00", 
    "MEG3_RNA_ant" = "#56B4E9", "MEG3_ant" = "#56B4E9",
    "PGL3_RNA_ant" = "#009E73", "PGL3_ant" = "#009E73",
    "RNA_ant" = "#F0E442"
  )) +
  scale_linetype_manual(values = c(
    "PLK1_ant" = "solid", 
    "MEG3_RNA_ant" = "solid", "MEG3_ant" = "twodash",
    "PGL3_RNA_ant" = "solid", "PGL3_ant" = "twodash",
    "RNA_ant" = "solid"
  )) +
  scale_x_continuous(
    limits = c(0, 30), 
    breaks = seq(0, 30, by = 5), 
    expand = c(0,0)
  )+
  scale_y_continuous(
    limits = c(0,6),
    breaks = seq(0,6,by=1),
    expand = c(0,0.02)
  )
ggplot(cm_g_subset, aes(x = Time, y = Amount, colour = Name, group = Name)) + 
  geom_line(size=1.5) +
  theme_minimal() +
  labs(
    title = "Simulation of Posterior P-Granule Formation Over Time",
    x = "Time Step",
    y = "Condensation Score (0-6)",
    colour = "Posterior P-Granule"
  ) +
  theme(legend.position = "right",
        panel.grid.major.x = element_line(colour = "grey80", size = 0.5),
        panel.grid.minor.x = element_blank(), 
        panel.grid.major.y = element_line(colour = "grey80", size = 0.5), 
        panel.grid.minor.y = element_blank(),
        axis.text.x = element_text(size = 12, colour = "black"), 
        axis.text.y = element_text(size = 12, colour = "black"), 
        axis.title.x = element_text(size = 14, face = "bold"), 
        axis.title.y = element_text(size = 14, face = "bold"),
        axis.line = element_line(size = 1, colour = "black"),
        title = element_text(size = 14, face = "bold")
  )+
  geom_vline(xintercept = seq(0, 30, by = 1), colour = "grey80", size = 0.5) +
  scale_colour_manual(values = c(
    "MEG3_granule" = "#0072B2", 
    "PGL3_granule" = "#D55E00"
  )) +
  scale_linetype_manual(values = c(
    "MEG3_granule" = "solid", 
    "PGL3_granule" = "solid"
  )) +
  scale_x_continuous(
    limits = c(0, 30), 
    breaks = seq(0, 30, by = 5), 
    expand = c(0,0)
  )+
  scale_y_continuous(
    limits = c(0,6),
    breaks = seq(0,6,by=1),
    expand = c(0,0.02)
  )