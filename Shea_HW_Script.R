#HOMEWORK: Editing and Making Publication Ready Plots
#Student Presentation: By Shea Wales

#Make a line graph 

#Load the libraries we used in class:
library(ggplot2)
library(plyr) 
library(RColorBrewer)
library(tidyr)

#Load data2 the same way we did in class (AL)
# write out all the offending strings
na_strings <- c("#DIV/0!", "", " ", "NA")

# read in the data (LTREB_classPRACdata2.csv) the same way we did in class
data2 <- read.csv("data/LTREB_classPRACdata2.csv", header = TRUE, na = na_strings, check.names = FALSE)

# Change the names
names(data2) <- c("count","stand","plot","tree_id","species","DBH","2017","2016", "2015","2014","2013","2012","2011", "2010", "2009", "2008", "2007", "2006","avg_rgr","species_long","a","b","DBH_range_cm")

# Check the names
names(data2)

#before you start please set your theme to theme_classic()
theme_set(theme_classic())

# (1) Create a "saved" historgram that plots DBH (labled "Stem Diameter at Breast Height (DBH)") as the x-axis. Set the binwidth to 2. Color code by species. Label the x-axis, "Stem Diameter at Breast Height (DBH)" and the y-axis, "Count".
Hist_basic <- ggplot(data2, aes(x = DBH, fill = species)) + geom_histogram(binwidth = 2) + labs(x = "Stem Diameter at Breast Height (DBH)", y = "Count")
Hist_basic

# (2) Create a "saved" scatter plot graph that plots DBH (labled "Stem Diameter at Breast Height (DBH)") as the x-axis and avg_rgr (labled "Average Relative Growth Rate (rgr)" as the y-axis. Color code by species. Label the x-axis, "Stem Diameter at Breast Height (DBH)" and the y-axis, "Average Relative Growth Rate (rgr)".
scatter_basic <- ggplot(data2, aes(x = DBH, y = avg_rgr, color = species)) + geom_point() + labs(x = "Stem Diameter at Breast Height (DBH)", y = "Average Relative Growth Rate (rgr)")
scatter_basic

# (3) Create and set a theme: 
#Create and set a theme that uses theme_classic, and a text base family of "mono". Axis lines should be set to 0.05. The background should not have a fill, and no grid line should be present. The text on both axes should be size 16, with the axis lables size 18. The legend text should be size 13, and the title 16. Set the legend position to (0.9,0.8).

theme_set(theme_classic(base_family = "mono") + 
            theme(
              axis.line = element_line(size=0.05),
              panel.background = element_rect(fill = NA),
              panel.grid.minor = element_line(color = NA),
              axis.text = element_text(size = 16),
              axis.title = element_text(size = 18),
              legend.text = element_text(size = 13), 
              legend.title = element_text(size = 16), 
              legend.position = c(0.9,0.8))
)



# (4) Now create a histogram using the saved variable you made earlier and the theme you just set. Log transform (log10()) the x and y axis, and use color pallette = "Set3" to color code your graph. Adjust the graph so there are no gaps between the data and axes (hint: we did this in class...)

Hist_basic + scale_y_continuous(expand = c(0,0)) + scale_fill_brewer(palette = "Set3")

# (5a) Create a scatter plot using the saved variable you made earlier and the theme set. Log transform (log10()) the x and y axis, and use color pallette = "Set3" to color code your graph.

scatter_basic + scale_color_brewer(palette = "Set3") + scale_y_log10() + scale_x_log10()

# (5b) Lastly, add regression lines for each species using "+ geom_smooth(method = 'lm', se = FALSE)". In this case se = FALSE removes the grey shading from the regression line. (If you want to see the diffrence you can change it to true!)

scatter_basic + scale_color_brewer(palette = "Set3") + scale_y_log10() + scale_x_log10() + geom_smooth(method = 'lm', se = FALSE)


