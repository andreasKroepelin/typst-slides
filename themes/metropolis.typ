/*
This theme is inspired by https://github.com/matze/mtheme

Consider using:
#set text(font: "Fira Sans", weight: "light",size:20pt)
#show math.equation: set text(font: "Fira Math")
#set strong(delta: 100)
#set par(justify:true)
*/

#let metropolis-theme(extra: none) = data => {
  let m-dark-teal = rgb("#23373b")
  let m-light-brown = rgb("#eb811b")
  let m-lighter-brown = rgb("#d6c6b7")
  let m-extra-light-gray = white.darken(2%)

  let cell = block.with(
    width:100%,
    height:100%,
    above:0pt,
    below:0pt,
    breakable:false
  )

  let title-slide(slide-info, bodies) = {
    if bodies.len() != 0 {
        panic("title slide of metropolis theme does not support any bodies")
    }
    set text(fill: m-dark-teal)
    cell(fill: m-extra-light-gray)[
      #align(horizon)[
        #block(
          width:100%,
          inset:2em
        )[
          #text(1.3em)[*#data.title*]
          #if data.subtitle != none {
            linebreak()
            text(0.9em)[#data.subtitle]
          }
          #line(length:100%, stroke: .05em + m-light-brown)
          #text(size: .8em)[
          #if data.authors != none {
              block(spacing:1em,data.authors.join(", "))
          }
          #if data.date != none {
              block(spacing:1em,data.date)
          }
          #if extra != none {
              block(spacing:1em,extra)
          }
          ]
        ]
      ]
    ]
  }

  let progress-bar() = locate(loc => {
        let filled = counter("logical-slide").at(loc).first() / counter("logical-slide").final(loc).first()*100%
        grid(columns: (filled,1fr),cell(fill:m-light-brown),cell(fill:m-lighter-brown))
  })

  let default(slide-info, bodies) = {
    if bodies.len() != 1 {
      panic("default variant of metropolis theme only supports one body per slide")
    }
    let body = bodies.first()
    grid(
      rows: (0.2em,if "title" in slide-info and slide-info.title != none {2em} else {0em},1fr),
      column-gutter: 0pt,
      row-gutter: 0pt
    )[
      #progress-bar()
    ][
      #if "title" in slide-info and slide-info.title != none {
        cell(fill:m-dark-teal,inset: (left:.5em))[
          #align(horizon)[
            #text(fill: m-extra-light-gray,size:1.2em)[*#slide-info.title*]
          ]
        ]
      }
    ][
      #cell(fill: m-extra-light-gray,inset: 2em)[
        #align(horizon)[
          #text(fill: m-dark-teal)[#bodies.first()]
        ]
      ]
    ]
    place(bottom+right,dx:-1em,dy:-1em)[#text(fill:m-dark-teal,size:0.8em)[#counter("logical-slide").display()]]
  }
  
  let wake-up(slide-info, bodies) = {
    if bodies.len() != 1 {
      panic("wake up variant of metropolis theme only supports one body per slide")
    }
    let body = bodies.first()
    grid(
      rows: (0.2em,if "title" in slide-info and slide-info.title != none {2em} else {0em},1fr),
      column-gutter: 0pt,
      row-gutter: 0pt
    )[
      #progress-bar()
    ][
      #if "title" in slide-info and slide-info.title != none {
        cell(fill:m-dark-teal,inset: (left:.5em))[
          #align(horizon)[
            #text(fill: m-extra-light-gray,size:1.2em)[*#slide-info.title*]
          ]
        ]
      }
    ][
      #cell(fill: m-dark-teal,inset: 2em)[
        #align(horizon+center)[
          #text(fill: m-extra-light-gray,size:1.2em)[*#bodies.first()*]
        ]
      ]
    ]
  }

  (
    "title slide": title-slide,
    "default": default,
    "wake up": wake-up
  )
}