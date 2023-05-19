#import "../../../slides.typ": *
#import "../../../themes/university.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
    theme: university-theme(
        institution-name: "UniversityName",
        logo: image("300x200.svg", width: 60mm)
    )
)

#slide(theme-variant: "title slide")

#new-section("section name")

#slide(title: "A longer slide title")[
  #box(
    inset: 1em
  )[
    #lorem(40)
  ]
]

#slide(title: "A longer slide title with 2 columns")[
  #block(
    inset: 1em,
    outset: 0pt,
    fill: rgb("#eeeeee"),
    width: 100%,
    height: 100%,
    lorem(30)
  )
][
  #block(
    inset: 1em,
    outset: 0pt,
    fill: rgb("#555555"),
    width: 100%,
    height: 100%,
    text(fill:white)[#lorem(30)]
  )
]

#slide(theme-variant: "wake up", background: "../book/src/theme-gallery/background.svg")[
  *Another variant with an image in background...*
]

#slide(theme-variant: "split v", columns: 2, fill: rgb("#ff0000"))[
  #box(
    height: 100%,
  )[
    #image("1080x1920.svg", fit: "stretch")
  ]
][
  #set align(center + horizon)
  #set text(fill: white);
  #box(
    inset: 1em,
  )[
    Or a split slide with an image on the left and some text on the right...
  ]
]

#slide(theme-variant: "split v")[
  #set align(center+horizon)
  #box(
    width: 100%,
    height: 100%,
    fill: rgb("#dddddd")
  )[
    left
  ]
][
  #set align(center+horizon)
  #box(
    width: 100%,
  )[
    right
  ]
]

#slide(theme-variant: "split h")[
  #set align(center+horizon)
  #box(
    width: 100%,
    height: 100%,
    fill: rgb("#dddddd")
  )[
    top
  ]
][
  #set align(center+horizon)
  #box(
    width: 100%,
  )[
    bottom
  ]
]

#slide(theme-variant: "split matrix")[
  #set align(center+horizon)
  #box(
    width: 100%,
    height: 100%,
    fill: rgb("#dddddd")
  )[
    top left
  ]
][
  #set align(center+horizon)
  #box(
    width: 100%,
  )[
    top right
  ]
][
  #set align(center+horizon)
  #box(
    width: 100%,
  )[
    bottom left
  ]
][
  #set align(center+horizon)
  #box(
    width: 100%,
    height: 100%,
    fill: rgb("#dddddd")
  )[
    bottom right
  ]
]
