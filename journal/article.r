################################################################################
#
# Configure R
#
################################################################################
#
# Clear workspace
#
rm(list = ls())
#
# Garbage collection
#
gc()
#
# Set options
#
options(stringsAsFactors = FALSE)
#
# Set seed for pseudo-random number generator
#
set.seed(1977)

#
#
#
library(ggplot2)
library(Hmisc)


################################################################################
#
# Function for precision / relative precision
#
################################################################################
#
#
#
precise <- function(lower, upper, data)
  {
  #
  #
  #
  x <- (data[[upper]] - data[[lower]]) / 2
  #
  #
  #
  return(x)
  }
#
#
#  
rel.precise <- function(lower, upper, estimate, data)
  {
  #
  #
  #
  x <- precise(lower, upper, data) / data[[estimate]]
  #
  #
  #
  return(x)
  }


################################################################################
#
# Create WSUP theme for shiny
#
################################################################################

theme_article <- theme_bw() + 
                 theme(strip.text = element_text(size = 8), 
                       strip.background = element_rect(colour = "gray70", size = 0.5),
                       axis.title = element_text(size = 8),
                       axis.text = element_text(size = 6),
                       panel.border = element_rect(colour = "gray70"),
                       panel.grid = element_line(size = 0.2),
                       panel.grid.minor = element_line(size = 0.2, linetype = 3),
                       panel.background = element_rect(fill = "transparent"),
                       legend.key = element_rect(colour = NA, fill = NA),
                       legend.key.size = unit(15, "pt"),
                       legend.title = element_text(size = 8),
                       legend.text = element_text(size = 6))


#
#
#
indicatorsDF <- read.csv("indicatorsDataBGDMar2017.csv", header = TRUE, sep = ",")
resultsDF <- read.csv("surveyResultsBGDMar2017.csv", header = TRUE, sep = ",")


jmpCode <- c("jmpWater1", "jmpWater2", "jmpWater3", "jmpWater4",
             "jmpSan1", "jmpSan2", "jmpSan3", "jmpSan4")
#
#
#
jmpIndicatorsDF <- indicatorsDF[ , c("uniqueID", "psu", "zone", "type", 
                                     "quadrat", "hhid", "longitude", "latitude", 
                                     "pQuintile",
                                     jmpCode)]
#
#
#                                     
jmpResultsDF <- resultsDF[resultsDF$indicatorCode %in% jmpCode, ]
#
# WASH ladder indicators colour schemes
#
#waterLadder <- c("#4575b4", "#74add1", "#ffffbf", "#feb24c", "#ec7014")
#sanitationLadder <- c("#1a9850", "#a6d96a", "#ffffbf", "#feb24c", "#ec7014")
waterLadder <- c("#74add1", "#ffffbf", "#feb24c", "#ec7014")
sanitationLadder <- c("#a6d96a", "#ffffbf", "#feb24c", "#ec7014")

#
#
#
results.deff <- NULL
#
# DEFF
#
for(i in jmpCode)
  {
  #
  #
  #
  area.deff <- NULL
  #
  #
  #
  for(j in 1:9)
    {
    #
    #
    #
    temp <- subset(jmpIndicatorsDF, zone == j)
    #
    #
    #
    if(sum(temp[[i]]) == 0) x <- c("n" = NA, "clusters" = NA, "rho" = NA, "deff" = NA)
    else x <- deff(y = temp[[i]], cluster = temp$psu)
    #
    #
    #
    area.deff <- data.frame(rbind(area.deff, x))
    }
  #
  #
  #
  indicatorCode <- rep(i, 9)
  #
  #
  #
  indicatorSet <- ifelse(i %in% c("jmpWater1", "jmpWater2", "jmpWater3", 
                                  "jmpWater4"), "Water Source", "Sanitation Facility")
  #
  #
  #
  strata <- paste("Survey Area ", 1:9, sep = "")
  #
  #
  #
  strataSet <- rep("Survey Area", 9)
  #
  #
  #
  type <- rep("Citywide", 9)
  #
  #
  #
  area.deff <- data.frame(indicatorSet, indicatorCode, strataSet, strata, type, area.deff)
  #
  #
  #
  type.deff <- NULL
  #
  #
  #
  for(j in 1:9)
    {
    #
    #
    #
    temp <- subset(jmpIndicatorsDF, zone == j & type == 1)
    #
    #
    #
    if(sum(temp[[i]]) == 0 | sum(temp[[i]]) == nrow(temp)) x <- c("n" = NA, "clusters" = NA, "rho" = NA, "deff" = NA)
    else x <- deff(y = temp[[i]], cluster = temp$psu)
    #
    #
    #
    type.deff <- data.frame(rbind(type.deff, x))
    }
  #
  #
  #
  indicatorCode <- rep(i, 9)
  #
  #
  #
  indicatorSet <- ifelse(i %in% c("jmpWater1", "jmpWater2", "jmpWater3", 
                                  "jmpWater4"), "Water Source", "Sanitation Facility")
  #
  #
  #
  strata <- paste("Survey Area ", 1:9, sep = "")
  #
  #
  #
  strataSet <- rep("Survey Area", 9)
  #
  #
  #
  type <- rep("Slum", 9)
  #
  #
  #
  type.deff <- data.frame(indicatorSet, indicatorCode, strataSet, strata, type, type.deff)
  #
  #
  #
  area.deff <- data.frame(rbind(area.deff, type.deff))
  #
  #
  #
  wealth.deff <- NULL
  #
  #
  #
  for(k in 1:5)
    {
    #
    #
    #
    temp <- subset(jmpIndicatorsDF, pQuintile == k)
    #
    #
    #
    if(sum(temp[[i]]) == 0) x <- c("n" = NA, "clusters" = NA, "rho" = NA, "deff" = NA)
    else x <- deff(y = temp[[i]], cluster = temp$psu)
    #
    #
    #
    wealth.deff <- data.frame(rbind(wealth.deff, x))
    }
  #
  #
  #
  indicatorCode <- rep(i, 5)
  #
  #
  #
  indicatorSet <- ifelse(i %in% c("jmpWater1", "jmpWater2", "jmpWater3", 
                                  "jmpWater4"), "Water Source", "Sanitation Facility")
  #
  #
  #
  strata <- paste("Wealth Quintile ", 1:5, sep = "")
  #
  #
  #
  strataSet <- rep("Wealth Quintile", 5)
  #
  #
  #
  type <- rep("Citywide", 5)
  #
  #
  #
  wealth.deff <- data.frame(indicatorSet, indicatorCode, strataSet, strata, type, wealth.deff)
  #
  #
  #
  type.deff <- NULL
  #
  #
  #
  for(k in 1:5)
    {
    #
    #
    #
    temp <- subset(jmpIndicatorsDF, pQuintile == k & type == 1)
    #
    #
    #
    if(sum(temp[[i]]) == 0) x <- c("n" = NA, "clusters" = NA, "rho" = NA, "deff" = NA)
    else x <- deff(y = temp[[i]], cluster = temp$psu)
    #
    #
    #
    type.deff <- data.frame(rbind(type.deff, x))
    }
  #
  #
  #
  indicatorCode <- rep(i, 5)
  #
  #
  #
  indicatorSet <- ifelse(i %in% c("jmpWater1", "jmpWater2", "jmpWater3", 
                                  "jmpWater4"), "Water Source", "Sanitation Facility")
  #
  #
  #
  strata <- paste("Wealth Quintile ", 1:5, sep = "")
  #
  #
  #
  strataSet <- rep("Wealth Quintile", 5)
  #
  #
  #
  type <- rep("Slum", 5)
  #
  #
  #
  type.deff <- data.frame(indicatorSet, indicatorCode, strataSet, strata, type, type.deff)
  #
  #
  #
  wealth.deff <- data.frame(rbind(wealth.deff, type.deff))
  #
  #
  #
  overall.deff <- NULL
  #
  #
  #
  if(sum(jmpIndicatorsDF[[i]]) == 0) x <- c("n" = NA, "clusters" = NA, "rho" = NA, "deff" = NA)
  else x <- deff(y = jmpIndicatorsDF[[i]], cluster = jmpIndicatorsDF$psu)
  #
  #
  #
  overall.deff <- data.frame(rbind(overall.deff, x))
  #
  #
  #
  indicatorSet <- ifelse(i %in% c("jmpWater1", "jmpWater2", "jmpWater3", 
                                  "jmpWater4"), "Water Source", "Sanitation Facility")
  #
  #
  #  
  overall.deff <- data.frame(cbind("indicatorSet" = indicatorSet, "indicatorCode" = i, "strataSet" = "Overall", "strata" = "Overall", "type" = "Citywide"), overall.deff)
  #
  #
  #
  type.deff <- NULL
  #
  #
  #
  temp <- subset(jmpIndicatorsDF, type == 1)
  #
  #
  #
  if(sum(temp[[i]]) == 0) x <- c("n" = NA, "clusters" = NA, "rho" = NA, "deff" = NA)
  else x <- deff(y = temp[[i]], cluster = temp$psu)
  #
  #
  #
  type.deff <- data.frame(rbind(type.deff, x))
  #
  #
  #
  indicatorSet <- ifelse(i %in% c("jmpWater1", "jmpWater2", "jmpWater3", 
                                  "jmpWater4"), "Water Source", "Sanitation Facility")
  #
  #
  #  
  type.deff <- data.frame(cbind("indicatorSet" = indicatorSet, "indicatorCode" = i, "strataSet" = "Overall", "strata" = "Overall", "type" = "Slum"), type.deff)
  #
  #
  #
  overall.deff <- data.frame(rbind(overall.deff, type.deff))
  #
  # 
  #
  results.deff <- data.frame(rbind(results.deff, area.deff, wealth.deff, overall.deff))
  }
#
#
#
results.deff[results.deff$indicatorCode == "jmpWater1", c("n", "clusters")] <- results.deff[results.deff$indicatorCode == "jmpWater2", c("n", "clusters")]
results.deff[results.deff$indicatorCode == "jmpWater3", c("n", "clusters")] <- results.deff[results.deff$indicatorCode == "jmpWater2", c("n", "clusters")]
results.deff[results.deff$indicatorCode == "jmpSan1", c("n", "clusters")] <- results.deff[results.deff$indicatorCode == "jmpWater2", c("n", "clusters")]
results.deff[results.deff$indicatorCode == "jmpSan2", c("n", "clusters")] <- results.deff[results.deff$indicatorCode == "jmpWater2", c("n", "clusters")]
results.deff[results.deff$indicatorCode == "jmpSan4", c("n", "clusters")] <- results.deff[results.deff$indicatorCode == "jmpWater2", c("n", "clusters")]
#
#
#
row.names(results.deff) <- 1:nrow(results.deff)
#
#
#
write.csv(results.deff, "resultsDEFF.csv", row.names = FALSE)




################################################################################
#
# Summary statistics
#
################################################################################
#
# Overall summary statistics - full data set
#
summary(results.deff)
#
#
#
summary(results.deff[results.deff$strataSet == "Survey Area" & results.deff$type == "Slum", ])
summary(results.deff[results.deff$strataSet == "Survey Area" & results.deff$type == "Citywide", ])

summary(results.deff[results.deff$strataSet == "Wealth Quintile" & results.deff$type == "Slum", ])
summary(results.deff[results.deff$strataSet == "Wealth Quintile" & results.deff$type == "Citywide", ])

summary(results.deff[results.deff$strataSet == "Overall" & results.deff$type == "Slum", ])
summary(results.deff[results.deff$strataSet == "Overall" & results.deff$type == "Citywide", ])


################################################################################
#
# Plots - ICC (rho)
#
################################################################################
#
# 
#
results.deff$indicatorCode <- factor(results.deff$indicatorCode, 
                                     levels = c("jmpSan1", "jmpSan2", "jmpSan3", 
                                                "jmpSan4",
                                                "jmpWater1", "jmpWater2", "jmpWater3", 
                                                "jmpWater4")) 
#
#
#
results.deff$indicatorSet <- factor(results.deff$indicatorSet, 
                                    levels = c("Sanitation Facility", 
                                               "Water Source"))
#
#
#                                               
results.deff$type <- factor(results.deff$type, 
                            levels = c("Slum", 
                                       "Citywide"))
#
#
#                                               
results.deff$strataSet <- factor(results.deff$strataSet, 
                                 levels = c("Survey Area", 
                                            "Wealth Quintile",
                                            "Overall"))


#
# 
#
basePlot <- ggplot(data = results.deff, 
                   aes(x = strata, y = rho, 
                       colour = indicatorCode, 
                       fill = indicatorCode, 
                       shape = indicatorCode))
pointPlot <- geom_point(alpha = 0.8)
#
#
#    
pointColour <- scale_colour_manual(name = "Indicators",
                                   values = c(rep("#1a9850", 4), 
                                              rep("#4575b4", 4)),
                                   labels = c("Open defecation", 
                                              "Unimproved sanitation facility", 
                                              "Limited sanitation facility", 
                                              "Basic sanitation facility",
                                              "Surface water", 
                                              "Unimproved water source", 
                                              "Limited water source", 
                                              "Basic water source"))           
#
#
#    
pointFill <- scale_fill_manual(name = "Indicators",
                               values = c(rep("#1a9850", 4), 
                                          rep("#4575b4", 4)),
                               labels = c("Open defecation", 
                                          "Unimproved sanitation facility", 
                                          "Limited sanitation facility", 
                                          "Basic sanitation facility",
                                          "Surface water", 
                                          "Unimproved water source", 
                                          "Limited water source", 
                                          "Basic water source"))           
#
#
#    
pointShape <- scale_shape_manual(name = "Indicators",
                                 values = c(21, 22, 23, 24,
                                            21, 22, 23, 24),
                                 labels = c("Open defecation", 
                                            "Unimproved sanitation facility", 
                                            "Limited sanitation facility", 
                                            "Basic sanitation facility",
                                            "Surface water", 
                                            "Unimproved water source", 
                                            "Limited water source", 
                                            "Basic water source"))
#
#
#
png(filename = "rhoPlot.png",
    width = 12, height = 6, units = "in", res = 300)
#
#
#    
basePlot + pointPlot + 
  facet_grid(type ~ indicatorSet) + 
  pointColour + pointFill + pointShape + 
  ylim(0, 1) + 
  theme_article + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5), 
                        legend.position = "right", 
                        legend.direction = "vertical")
#
#
#
dev.off()


################################################################################
#
# Plots - Design effect (DEFF)
#
################################################################################
#
#
#
basePlot <- ggplot(data = results.deff, 
                   aes(x = strata, y = deff, 
                       colour = indicatorCode,
                       fill = indicatorCode,
                       shape = indicatorCode))
pointPlot <- geom_point(alpha = 0.8)
#
#
#
png(filename = "deffPlot.png",
    width = 12, height = 6, units = "in", res = 300)
#
#
#
basePlot + pointPlot + 
  facet_grid(type ~ indicatorSet) + 
  pointColour + pointFill + pointShape + 
  xlab(label = "") + 
  theme_article + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5), 
                        legend.position = "right", 
                        legend.direction = "vertical")
#
#
#
dev.off()



  
  
################################################################################
#
# Create precision results data.frame for plotting
#
################################################################################  
#
#
#
std.error.slum <- precise(data = jmpResultsDF, 
                          lower = "slumLCL", 
                          upper = "slumUCL")    
std.error.city <- precise(data = jmpResultsDF, 
                          lower = "totalLCL", 
                          upper = "totalUCL")
#
#
#
r.std.error.slum <- rel.precise(data = jmpResultsDF, 
                                lower = "slumLCL", 
                                upper = "slumUCL", 
                                estimate = "slumEst")    
r.std.error.city <- rel.precise(data = jmpResultsDF, 
                                lower = "totalLCL", 
                                upper = "totalUCL", 
                                estimate = "totalEst")
#
#
#
indicator <- vector(mode = "character", length = nrow(jmpResultsDF))
#
#
#
indicator[jmpResultsDF$indicatorCode == "jmpWater1"] <- "Surface water"
indicator[jmpResultsDF$indicatorCode == "jmpWater2"] <- "Unimproved water source"
indicator[jmpResultsDF$indicatorCode == "jmpWater3"] <- "Limited water source"
indicator[jmpResultsDF$indicatorCode == "jmpWater4"] <- "Basic water source"
indicator[jmpResultsDF$indicatorCode == "jmpSan1"]   <- "Open defecation"
indicator[jmpResultsDF$indicatorCode == "jmpSan2"]   <- "Unimproved sanitation facility"
indicator[jmpResultsDF$indicatorCode == "jmpSan3"]   <- "Limited sanitation facility"
indicator[jmpResultsDF$indicatorCode == "jmpSan4"]   <- "Basic sanitation facility"
#
#
#
indicatorSet <- ifelse(grepl("jmpWater", jmpResultsDF$indicatorCode), "Water Source", "Sanitation Facility")
#
#
#
results.precision <- data.frame(indicator,
                                "indicatorCode" = jmpResultsDF[ , "indicatorCode"], 
                                jmpResultsDF[ , c("strata", "slumEst", "slumLCL", "slumUCL")],
                                std.error.slum, r.std.error.slum,
                                jmpResultsDF[ , c("totalEst", "totalLCL", "totalUCL")],
                                std.error.city, r.std.error.city)

write.csv(results.precision, "resultsPrecision.csv", row.names = FALSE)

#
#
#
strataSet <- ifelse(grepl("Survey Area ", results.precision$strata), "Survey Area",
               ifelse(grepl("Wealth Quintile ", results.precision$strata), "Wealth Quintile", "Overall"))




slum.results.precision <- data.frame(indicatorSet, 
                                     results.precision[ , c("indicator", "indicatorCode")],        
                                     strataSet, 
                                     results.precision[ , "strata"], 
                                     results.precision[ , c("slumEst", "slumLCL", "slumUCL", "std.error.slum", "r.std.error.slum")], 
                                     "type" = rep("Slum", nrow(results.precision))) 

names(slum.results.precision) <- c("indicatorSet", "indicator", "indicatorCode", 
                                   "strataSet", "strata", "estimate", "lcl", "ucl", 
                                   "std.error", "r.std.error", "type")

city.results.precision <- data.frame(indicatorSet, 
                                     results.precision[ , c("indicator", "indicatorCode")], 
                                     strataSet, 
                                     results.precision[ , "strata"], 
                                     results.precision[ , c("totalEst", "totalLCL", "totalUCL", "std.error.city", "r.std.error.city")], 
                                     "type" = rep("Citywide", nrow(results.precision)))

names(city.results.precision) <- c("indicatorSet", "indicator", "indicatorCode", 
                                   "strataSet", "strata", "estimate", "lcl", "ucl", 
                                   "std.error", "r.std.error", "type")

results.precision <- data.frame(rbind(slum.results.precision, city.results.precision))


################################################################################
#
# Summary results precision
#
################################################################################
#
#
#
summary(results.precision[results.precision$strataSet == "Survey Area" & results.precision$type == "Slum", ])
summary(results.precision[results.precision$strataSet == "Survey Area" & results.precision$type == "Citywide", ])

summary(results.precision[results.precision$strataSet == "Wealth Quintile" & results.precision$type == "Slum", ])
summary(results.precision[results.precision$strataSet == "Wealth Quintile" & results.precision$type == "Citywide", ])

summary(results.precision[results.precision$strataSet == "Overall" & results.precision$type == "Slum", ])
summary(results.precision[results.precision$strataSet == "Overall" & results.precision$type == "Citywide", ])



################################################################################
#
# Plot - precision
#
################################################################################
#
# 
#
results.precision$indicatorCode <- factor(results.precision$indicatorCode,
                                          levels = c("jmpSan1", "jmpSan2", 
                                                     "jmpSan3", "jmpSan4",
                                                     "jmpWater1", "jmpWater2", 
                                                     "jmpWater3", "jmpWater4")) 

results.precision$indicatorSet <- factor(results.precision$indicatorSet,
                                         levels = c("Sanitation Facility", 
                                                    "Water Source"))

results.precision$type <- factor(results.precision$type,
                                 levels = c("Slum", "Citywide"))

results.precision$strataSet <- factor(results.precision$strataSet,
                                     levels = c("Survey Area", 
                                                "Wealth Quintile", 
                                                "Overall"))



basePlot <- ggplot(data = results.precision, 
                   mapping = aes(x = estimate, 
                                 y = std.error, 
                                 colour = indicatorCode,
                                 shape = indicatorCode,
                                 fill = indicatorCode))

pointPlot <- geom_point(stat = "identity", alpha = 0.8)

#
#
#    
pointColour <- scale_colour_manual(name = "Indicators",
                                   values = c(rev(sanitationLadder), rev(waterLadder)),
                                   labels = c("Open defecation", 
                                              "Unimproved sanitation facility", 
                                              "Limited sanitation facility", 
                                              "Basic sanitation facility",
                                              "Surface water", 
                                              "Unimproved water source", 
                                              "Limited water source", 
                                              "Basic water source"))           
#
#
#    
pointFill <- scale_fill_manual(name = "Indicators",
                               values = c(rev(sanitationLadder), rev(waterLadder)),
                               labels = c("Open defecation", 
                                          "Unimproved sanitation facility", 
                                          "Limited sanitation facility", 
                                          "Basic sanitation facility",
                                          "Surface water", 
                                          "Unimproved water source", 
                                          "Limited water source", 
                                          "Basic water source"))           
#
#
#    
pointShape <- scale_shape_manual(name = "Indicators",
                                 values = c(rep(21, 4), rep(22, 4)),
                                 labels = c("Open defecation", 
                                            "Unimproved sanitation facility", 
                                            "Limited sanitation facility", 
                                            "Basic sanitation facility",
                                            "Surface water", 
                                            "Unimproved water source", 
                                            "Limited water source", 
                                            "Basic water source"))

png("precision.png", height = 6, width = 12, units = "in", res = 300)

basePlot + pointPlot + facet_grid(indicatorSet ~ type + strataSet) + 
  pointColour + pointFill + pointShape + 
  geom_hline(yintercept = 0.1, linetype = 2, size = 0.5, colour = "red") + 
  xlab(label = "Estimate") + ylab(label = "Precision") +
  theme_article

dev.off()



basePlot <- ggplot(data = results.precision, 
                   mapping = aes(x = estimate, 
                                 y = r.std.error,
                                 colour = indicatorCode,
                                 fill = indicatorCode,
                                 shape = indicatorCode))
                                 
pointPlot <- geom_point(stat = "identity", alpha = 0.8)


png("relPrecision.png", height = 6, width = 12, units = "in", res = 300)

basePlot + pointPlot + facet_grid(indicatorSet ~ type + strataSet) +
  pointColour + pointFill + pointShape +
  geom_hline(yintercept = 0.3, linetype = 2, size = 0.5, colour = "red") +
  xlab(label = "Estimate") + ylab(label = "Relative Precision") +
  theme_article
  
dev.off()


png("relStdErrorStrata.png", height = 6, width = 12, units = "in", res = 300)

basePlot + pointPlot + facet_grid(strataSet ~ indicatorSet) +
  pointColour + pointFill + pointShape +
  geom_hline(yintercept = 0.3, linetype = 2, size = 0.5, colour = "red") +
  xlab(label = "Estimate") + ylab(label = "Relative Precision") + 
  theme_article
  
dev.off()
  
  
basePlot <- ggplot(data = results.precision, 
                   mapping = aes(x = std.error, 
                                 y = r.std.error,
                                 colour = indicatorCode,
                                 shape = indicatorCode,
                                 fill = indicatorCode))
                                 
pointPlot <- geom_point(stat = "identity", alpha = 0.8)




################################################################################
#
# Define plotting layers for ggplot - stacked bar by survey area grouped by type
#
################################################################################
#
# Re-structure factor for indicatorCode
#
results.precision$indicatorCode <- factor(results.precision$indicatorCode,
                                          levels = c(rev(c("jmpSan1", "jmpSan2", 
                                                           "jmpSan3", "jmpSan4")),
                                                     rev(c("jmpWater1", "jmpWater2", 
                                                           "jmpWater3", "jmpWater4")))) 

#
# Base plot
#
basePlot <- ggplot(data = results.precision, 
                   mapping = aes(x = strata, 
                                 y = estimate, 
                                 fill = indicatorCode))
#
# Bar plot
#
barPlot <- geom_bar(stat = "identity", position = "fill", alpha = 0.8)
#
# Bar fill
#
barFill <- scale_fill_manual(name = "Indicators",
                               values = c(sanitationLadder, waterLadder),
                               labels = c(rev(c("Open defecation", 
                                                "Unimproved sanitation facility", 
                                                "Limited sanitation facility", 
                                                "Basic sanitation facility")),
                                          rev(c("Surface water", 
                                                "Unimproved water source", 
                                                "Limited water source", 
                                                "Basic water source"))))
#
# Facets
#
barFacet <- facet_wrap(indicatorSet ~ type, nrow = 3)
#
# Axis labels
#
barLabels <- labs(x = "strata", y = "estimate")
#
# x-axis tick mark labels
#
xLabels <- scale_x_discrete(labels = c("Slum", "Citywide"))


################################################################################
#
# Plot
#
################################################################################
#
# Open graphics device
#
png(filename = "jmpLadderByStrata.png",
    width = 12, height = 7.5, units = "in",
    res = 200)
#
# Assemble plotting layers
#
basePlot + 
barPlot + barFill + barFacet + barLabels + 
theme_article + theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
#
# Close graphics device
#
dev.off()





