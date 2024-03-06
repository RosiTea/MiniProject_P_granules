install.packages("ggplot2")
install.packages("tidyverse")

library(ggplot2)
library(tidyverse)

rna_model <- read_csv("20240305_data/RNAcompetition.csv")

rm_long <- rna_model %>%
  pivot_longer(
    cols = -c(Location, Name), # Exclude Location and Name from the gathering
    names_to = "Time",
    values_to = "Amount",
    names_transform = list(Time = as.integer) # Converts time step names into integers
  )

ggplot(rm_long, aes(x = Time, y = Amount, colour = Name, group = Name)) + 
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
post_proteins <- c("MEG3_post", "MEG3_RNA_post", "PGL3_post", "PGL3_RNA_post", "RNA_post")
ant_proteins <- c("MEG3_ant", "MEG3_RNA_ant", "PGL3_ant", "PGL3_RNA_ant", "RNA_ant")
granule_proteins <- c("MEG3_granule", "PGL3_granule")

# Filter the dataframe to include only the selected proteins
rm_post_subset <- rm_long %>% 
  filter(Name %in% post_proteins)
rm_ant_subset <- rm_long %>% 
  filter(Name %in% ant_proteins)
rm_g_subset <- rm_long %>% 
  filter(Name %in% granule_proteins)

# Now plot the filtered data
lines_and_shapes <- data.frame(
  Name = unique(rm_post_subset$Name),
  linetype = c("solid", "twodash", "solid", "twodash", "solid"), # example values
  shape = c(17, 15, NA, NA, NA) # NA for those without a specific shape
)

ggplot(rm_post_subset, aes(x = Time, y = Amount, colour = Name, group = Name)) + 
  geom_line(aes(linetype = Name), size=1.5) +
  geom_point(aes(shape = Name), size=3, position=position_dodge(width=0.1)) +
  theme_minimal() +
  labs(
    title = "Simulation of Posterior Protein or RNA Amount Over Time",
    x = "Time Step",
    y = "Protein or RNA Level Score (0-6)",
    colour = "Protein or RNA",
    linetype = "Protein or RNA",
    shape = "Protein or RNA"
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
    "MEG3_RNA_post" = "#56B4E9", "MEG3_post" = "#56B4E9",
    "PGL3_RNA_post" = "#009E73", "PGL3_post" = "#009E73",
    "RNA_post" = "#F0E442"
  )) +
  scale_linetype_manual(values = lines_and_shapes$linetype) +
  scale_shape_manual(values = lines_and_shapes$shape) +
  guides(
    linetype = guide_legend(override.aes = list(shape = lines_and_shapes$shape)),
    shape = guide_legend(override.aes = list(linetype = lines_and_shapes$linetype))
  )+
  scale_x_continuous(
    limits = c(0, 30.1), 
    breaks = seq(0, 30, by = 5), 
    expand = c(0,0)
  )+
  scale_y_continuous(
    limits = c(0,6),
    breaks = seq(0,6,by=1),
    expand = c(0,0.02)
  )

ggplot(rm_ant_subset, aes(x = Time, y = Amount, colour = Name, group = Name)) + 
  geom_line(aes(linetype = Name), size=1.5) +
  geom_point(aes(shape = Name), size=3, position=position_dodge(width=0.1)) +
  theme_minimal() +
  labs(
    title = "Simulation of Anterior Protein or RNA Amount Over Time",
    x = "Time Step",
    y = "Protein or RNA Level Score (0-6)",
    colour = "Protein or RNA",
    linetype = "Protein or RNA",
    shape = "Protein or RNA"
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
    "MEG3_RNA_ant" = "#56B4E9", "MEG3_ant" = "#56B4E9",
    "PGL3_RNA_ant" = "#009E73", "PGL3_ant" = "#009E73",
    "RNA_ant" = "#F0E442"
  )) +
  scale_linetype_manual(values = lines_and_shapes$linetype) +
  scale_shape_manual(values = lines_and_shapes$shape) +
  guides(
    linetype = guide_legend(override.aes = list(shape = lines_and_shapes$shape)),
    shape = guide_legend(override.aes = list(linetype = lines_and_shapes$linetype))
  )+
  scale_x_continuous(
    limits = c(0, 30.1), 
    breaks = seq(0, 30, by = 5), 
    expand = c(0,0)
  )+
  scale_y_continuous(
    limits = c(-0.01,6),
    breaks = seq(0,6,by=1),
    expand = c(0,0.02)
  )


lines_and_shapes_2 <- data.frame(
  Name = unique(rm_g_subset$Name),
  linetype = c("solid", "solid"), # example values
  shape = c(17, NA) # NA for those without a specific shape
)
ggplot(rm_g_subset, aes(x = Time, y = Amount, colour = Name, group = Name)) + 
  geom_line(aes(linetype = Name), size=1.5) +
  geom_point(aes(shape = Name), size=3, position=position_dodge(width=0.1)) +
  theme_minimal() +
  labs(
    title = "Simulation of Posterior P-Granule Formation Over Time",
    x = "Time Step",
    y = "Condensation Score (0-6)",
    colour = "Posterior P-Granule",
    linetype = "Posterior P-Granule",
    shape = "Posterior P-Granule"
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
  scale_linetype_manual(values = lines_and_shapes_2$linetype) +
  scale_shape_manual(values = lines_and_shapes_2$shape) +
  guides(
    linetype = guide_legend(override.aes = list(shape = lines_and_shapes_2$shape)),
    shape = guide_legend(override.aes = list(linetype = lines_and_shapes_2$linetype))
  )+
  scale_x_continuous(
    limits = c(0, 30.1), 
    breaks = seq(0, 30, by = 5), 
    expand = c(0,0)
  )+
  scale_y_continuous(
    limits = c(0,6),
    breaks = seq(0,6,by=1),
    expand = c(0,0.02)
  )
