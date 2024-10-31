home <- function(){
  fluidPage(
    div(class = "landing-container",
        
        tags$video(
          class = "background-video",
          autoplay = TRUE,
          muted = TRUE,
          loop = TRUE,
          playsinline = TRUE,
          src = "background_video.mp4"
        ),
        
        
        div(class = "content-overlay",
            
            div(
              class = "home-logos",
              img(src = "ksu_taps.png", class = "logo"),
              img(src = "ksu.png", class = "logo")
            ),
            
            div(class = "title-section",
                h1("TAPS Hackathon 2024")
            ),
            
            p(class = "description",
              "Water sustainability in Kansas is a critical issue, especially given the state's reliance on agriculture and the depletion of the Ogallala Aquifer, a primary water source for irrigation.
              As water resources become increasingly scarce, the need for efficient water management is more pressing than ever.
              Technology and remote sensing play a vital role in addressing this challenge.
              By using satellite data and advanced digital tools, farmers can monitor soil moisture, weather patterns, and crop health in real-time, allowing them to optimize irrigation practices and reduce water waste.
              These innovations not only improve water use efficiency but also promote long-term sustainability by conserving vital resources for future generations."
            ),
            
            div(
              class = "message-container",
                h4("Click 'Explore the data' to get started")
            ),
            
            div(class = "button-container",
                # Explore Data button
                downloadButton(
                  "static_df",
                  class = "landing-button",
                  label = "Download Static Data"
                ),
                # Explore API button
                downloadButton(
                  "dynamic_df",
                  label = "Download Dynamic Data",
                  class = "landing-button"
                )
            ),
            
            br(),
            
            img(
              src = "qr_code.jpeg",
              class = "logo"
            )
            
        )
    )
  )
}