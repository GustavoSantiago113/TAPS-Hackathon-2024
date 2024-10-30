about <- function(){
  fluidPage(
    div(
      class = "about",
      
      h1("Methods description"),
      hr(),
      h3("Soil Variables"),
      p("Soil sampling at a large scale can be expensive and laborious. Considering that only a few plots presented soil analysis, a spatial kriging interpolation method was employed to estimate sand, clay and soil organic matter at the plot level. This layer was crucial in future steps of this framework functioning as predictors soil parameters estimation."),
      hr(),
      h3("NDVI Scaling"),
      p("Different approaches were integrated into a model to get insight into the spatial and temporal resolution of crop growth through the NDVI time series. While some modern weather stations located in some plots can record the NDVI daily, the remote sensing products from satellites can spatially map the NDVI for all plots but in a lower temporal resolution than the weather stations. In order to spatially scale the data, the temporal resolution was increased to daily revisit all plots. The NDVI time series obtained from Planet Scope products were extracted for all dates and plots, and then modelled to upscale the temporal resolution at a daily basis using Generalized Additive Models (GAM). In this sense, GAM’s can be very flexible capturing all changes in NDVI throughout the crop season. The predictions resulted in the dynamic variation of NDVI through time at the plot level."),
      hr(),
      h3("Crop evapotranspiration"),
      p("Because the Crop Evapotranspiration (ETc) is calculated by some weather stations located in just some of the plots, we were able to scale the ETc combining remote sensing data and weather data from weather stations. The ETc was modelled with a XGBoost model, using as a inputs daily NDVI, soil variables (sand, clay and SOM), crop management (planting date, seeding rate, nitrogen rate and irrigation), soil electrical conductivity (shallow and deep), and daily weather variables (minimum and maximum temperature, minimum and maximum relative humidity, precipitation, solar radiation, wind speed, and soil temperature). This allowed us characterize spatial and temporal variability in the soil and crop water uptake across season."),
      hr(),
      h3("Soil water features"),
      p("In order to obtain the Field capacity (FC) and the Permanent Wilting Point (PWP), the values of soil organic matter (SOM), Sand and Clay were used as an inputs in the soil pedotransfer functions from Saxton & Rawls, 1986. The data from Sentek Soil moisture sensor was used to train the model serving as the response variable. The soil moisture data was modelled with a XGBoost model, using as a inputs daily NDVI, soil variables (sand, clay and SOM), crop management (planting date, seeding rate, nitrogen rate and irrigation), soil electrical conductivity (Shallow and Deep), and daily weather variables (minimum and maximum temperature, minimum and maximum relative humidity, precipitation, solar radiation, wind speed, soil temperature and ETc). The final machine learning model was trained using a leave-one-out cross validation scheme to optimize the model and find the best hyperparameter combination."),
      hr(),
      h3("References"),
      p("Saxton, K. E., Rawls, W., Romberger, J. S., & Papendick, R. I. (1986). Estimating generalized soil‐water characteristics from texture. Soil science society of America Journal, 50(4), 1031-1036."),
      hr(),
      h1("About the authors"),
      hr(),
      div(
        class = "about-authors",
        h3("Carlos Hernandez"),
        div(
          class = "about-text-photo",
          img(src = "carlos.jpeg", class = "photo"),
          p("I am Carlos Hernández, from a small town south of Córdoba, Argentina. From a very early age, I have been interested in technology in general, always trying to develop new methods and applications to solve problems. Like my father, I obtained a degree in Agronomist Engineering at the National University of Rio Cuarto during my undergraduate studies. After that, I had the opportunity to be part of several work teams as a consultant in precision agriculture technologies and as an external consultant in spatial data management platforms and in developing recommendation algorithms for agriculture. During my months as a master's student, I have learned and reinforced my knowledge of spatial data science, artificial intelligence, and digital agriculture in the Ciampitti Lab team, in Kansas State University.")
        )
      ),
      div(
        class = "about-authors",
        h3("Gabriel Hintz"),
        div(
          class = "about-text-photo",
          p("I have had the privilege of being raised on my family’s farm, which has sparked my passion for Agriculture and Crop Science. As a result, I pursued and successfully obtained my bachelor’s degree in Agronomy from the Federal University of Santa Maria in February 2023. Currently, as a master’s student at KSU under Dr. Ciampitti, my projects focus on Water and Nitrogen Dynamics in Soybeans."),
          img(src = "gabriel.jpeg", class = "photo")
        )
      ),
      div(
        class = "about-authors",
        h3("Gustavo Santiago"),
        div(
          class = "about-text-photo",
          img(src = "gustavo.jpg", class = "photo"),
          p("Gustavo Santiago is a biosystems engineer who graduated from the University of Sao Paulo (USP) and pursues a master's degree in agronomy at Kansas State University (KSU). He is an enthusiast of computers and electronics applied to rural science, miniatures, and DIY projects.
            He has skills in different computational languages and frameworks; GIS, CAD, circuitry and database software; PCB, and 3D printing projects.
            He has already worked in many different fields: biofuels in a chemical lab; microbiology to improve yield at a biological lab; image analysis and wastewater; precision agriculture and data science; development of digital tools for web and mobile; development of sensors for agriculture and last but not least, usage and creation of deep learning models.")
        )
      ),
      div(
        class = "about-authors",
        h3("Luiz Felipe Almeida"),
        div(
          class = "about-text-photo",
          p("I was born and raised in Maringá, a city in the state of Paraná, Brazil. I obtained my Bachelor of Science degree from the State University of Maringá. During my undergraduate studies, I had an enriching experience working as a research scholar at Embrapa Soybean in Brazil for a year. After completing my BS degree, I embarked on a new journey as a research scholar at Kansas State University in February 2020. In 2022, I seized another opportunity to advance my education and started a Master's program, which I am currently actively involved in. My research focuses on studying soybean N fixation across various environments in the United States, and also the crop's nutritional status, seed yield, and seed quality, aiming to deepen our understanding of these important factors."),
          img(src = "luiz.jpeg", class = "photo")
        )
      ),
    ),
    br()
  )
}