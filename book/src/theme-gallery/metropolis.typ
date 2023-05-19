#import "../../../slides.typ": *
#import "../../../themes/metropolis.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
    theme: metropolis-theme(extra: "Extra"),
)
#set text(font: "Fira Sans", weight: "light", size:20pt)
#show math.equation: set text(font: "Fira Math")
#set strong(delta: 100)
#set par(justify:true)

#slide(theme-variant: "title slide")

#slide(title: "Slide title")[
  A slide
]

#slide()[
  A slide without a title
]

#slide(theme-variant: "wake up")[
  Wake up!
]