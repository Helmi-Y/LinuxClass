#!/usr/bin/awk
# Helmi Yatim
# 11/10/2025
# Assignment 7

# Variables and Formats
BEGIN{
    FS = "\t"
    
    header_format = "%-20s %20s %20s\n"
    data_format = "%-20s %20.6f %20.6f\n"

    # Print Header
    printf header_format, "County","Pop/Sq Miles","% Water"
    printf header_format, "--------------", "--------------", "--------------" 

    highest_population = 0
    lowest_population = 999999999999
    highest_water_percent = 0
    lowest_water_percent = 999999999999

}


{
    # Read fields
    county = $1
    population = $2
    water_area = $3
    land_area = $4

    # Calculate density and water percent
    pop_density = population / land_area
    water_percent = water_area / (water_area + land_area) * 100

    # If statements for highest/lowest variables
    if (highest_population < pop_density) 
    {
        highest_population = pop_density
        highest_pop_county = county
    }
    if (lowest_population > pop_density) 
    {
        lowest_population = pop_density
        lowest_pop_county = county
    }
    
    if (highest_water_percent < water_percent) 
    {
        highest_water_percent = water_percent
        highest_water_percent_county = county
    }
    if (lowest_water_percent > water_percent) 
    {
        lowest_water_percent = water_percent
        lowest_water_percent_county = county
    }
    
    # Print data
    printf data_format, county, pop_density, water_percent
}

# End of script with highest and lowest variables
END{
    print "\n"
    print "\n"
    
    printf "Highest population density %s = %.6f\n", highest_pop_county, highest_population
    printf "Lowest population density %s = %.6f\n", lowest_pop_county, lowest_population
    printf "Highest percent water %s = %.6f%%\n", highest_water_percent_county, highest_water_percent
    printf "Lowest percent water %s = %.6f%%\n", lowest_water_percent_county, lowest_water_percent

}