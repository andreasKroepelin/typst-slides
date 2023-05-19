# Theme Gallery

Here you can find an overview over all themes shipped with this template.

- [Default](#default)
- [Bipartite](#bipartite)
- [Bristol](#bristol)
- [University](#university)

---

## Default
_[go to top](#theme-gallery)_

If you do not specify a theme, the default one will be used.
You can specify it explicitly by referring to `slides-default-theme`:
```typ
#show: slides(
  // ...
  theme: slides-default-theme(color: your-favourite-color)
)
```
### Options
- `color`: the color to use for decorative elements, default `teal`

### Variants
- `"title slide"`: displays presentation title and subtitle between horziontal
  lines above horizontally positioned authors and the date
- `"wake up"`: no decoration, colored background, enlarged text

### Extra keyword arguments
- `title`: a title for that slide

### Showcase
```typ
#import "slides.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
)

#slide(theme-variant: "title slide")

#new-section("section name")

#slide(title: "Slide title")[
  A slide
]

#slide(theme-variant: "wake up")[
  Wake up!
]
```
![default theme screenshot](./default.png)

---

## Bipartite
_[go to top](#theme-gallery)_

This theme is inspired by
[Modern Annual Report](https://slidesgo.com/theme/modern-annual-report).
It features a dominant partition of space into a bright and a dark side.
```typ
#import "themes/bipartite.typ": *
#show: slides(
  // ...
  theme: bipartite-theme(),
)
```
### Options
- *none*

### Variants
- `"title slide"`: displays presentation title on a large bright portion above
  the subtitle, the authors and the date
- `"east"`: same as default variant, but dark side on the right, text is right
  aligned
- `"center split"`: bright left and dark right half of equal size, requires two
  content bodies, one for each half (does not display a slide title)

### Extra keyword arguments
- `title`: a title for that slide

### Showcase
```typ
#import "slides.typ": *
#import "themes/bipartite.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
    theme: bipartite-theme(),
)

#slide(theme-variant: "title slide")

#new-section("section name")

#slide(title: "A longer slide title")[
  #lorem(40)
]

#slide(theme-variant: "east", title: "On the right!")[
  #lorem(40)
]

#slide(theme-variant: "center split")[
  #lorem(40)
][
  #lorem(40)
]
```
![bipartite theme screenshot](./bipartite.png)


## Bristol
_[go to top](#theme-gallery)_

This is a variation of the default theme, to feature academic branding. It is inspired by an old version of David Barton's
[Beamer theme](https://github.com/dawbarton/UoB-beamer-theme).
It features a University of Bristol branding by default, however the logos and colour choices can easily be swapped, to tailor the theme to any institution of your choice.
```typ
#import "themes/bristol.typ": *
#show: slides(
  // ...
  theme: bristol-theme(),
)
```

### Options
- `color`: the colour to use for decorative elements, default University of Bristol red
- `watermark`: file path for a watermark image to span the title slide, default "bristol/watermark.svg"
- `logo`: file path for a logo image to appear on every slide, default "bristol/logo.svg"
- `secondlogo`: file path for an additional logo image, to appear on the first slide only, default "bristol/secondlogo.svg"
Default logos are shipped with the theme, however they can be swapped out for another institution's branding by changing the `watermark`, `logo`, and `secondlogo` file paths when instantiating the theme.

### Variants
- `title slide`: shows a nicely formatted title slide
- `wake up`: no decoration, colored background, enlarged text

### Extra keyword arguments
- `title`: optional, a title for that slide
- `colwidths` : optional, array specifying width of each column; default `1fr` per column
- `gutter` : optional, integer, relative length, fraction, or array, specifying the gap between columns if a multicolumn (multi-body) slide is chosen; default `0.2em`

### Showcase
```typ
#import "slides.typ": *
#import "themes/bristol.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
    theme: bristol-theme(),
)

#slide(theme-variant: "title")

#new-section("section name")

#slide(title: "Slide title")[
  A slide
]

#slide(title: "Two column", gutter: .5em)[
Column A goes on the left...
][
And column B goes on the right!
]

#slide(title: "Variable column sizes", colwidths: (2fr, 1fr, 3fr))[
This is a medium-width column
][
This is a rather narrow column
][
This is a quite a wide column
]

#slide(theme-variant: "wake up")[
  Wake up!
]
```
![UoB theme screenshot](./bristol.png)

---

## University
_[go to top](#theme-gallery)_

This theme offers a simple yet versatile design, allowing for easy customization
and flexibility. Additionally, it incorporates a progress bar at the top, which
displays the current status of the presentation.

By default, this theme utilizes multiple body attachments for every slide type,
with each additional body creating a new column on the slide. Columns are
equally sized by default, but you can modify their dimensions by providing a
`columns` parameter to the slide or the variant.

The `columns` parameter can be configured similarly to the `columns` grid
parameter. For detailed instructions on customization, please consult the
official documentation.

The theme supports the addition of multiple bodies on every slide type. Each
added body creates a new column within the slide.

### Theme options
- `institution-name`: The institution name
- `color-a`: The main color (default: `rgb("#0C6291")`)
- `color-b`: The accent accent (default: `rgb("#A63446")`)
- `color-c`: A color of your choice (default: `rgb("#FBFEF9")`)
- `logo`: An element that will be on the top right of the first slide. Usually
  an image element, like a logo. (default: `none`)
- `progress-bar`: A boolean value to enable or disable the progress bar on the
  top. (default: `true`)

### Default slide options

It is possible to override the default theme option parameters by providing
them in the `#slide` function. It is also possible to override other parameters
for more customization options. These parameters are:

- `short-authors`
- `short-title`
- `date`
- `footer`
- `header`

### Variants slide options
- `"wake up"`: no decoration, colored background, enlarged text
  Available options:
    - `fill`: The background color (default: `none`)
    - `background`: The path to a background image (default: `none`)
- `"split v"`: split a slide vertically in `columns` parts
  Available options:
    - `fill`: The background color (default: `none`)
    - `columns`: auto, integer, relative length, fraction, array: Defines the
      columns amount and size
    - `background`: The path to a background image (default: `none`)
- `"split h"`: split a slide horizontally in `rows` parts
  Available options:
    - `fill`: The background color (default: `none`)
    - `rows`: auto, integer, relative length, fraction, array: Defines the columns
      amount and size
    - `background`: The path to a background image (default: `none`)
- `"split matrix"`: divide the slide in the same amount of columns and rows.
    - `fill`: The background color (default: `none`)
    - `background`: The path to a background image (default: `none`)

### Showcase

```typ
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
    width:100%,
    height: 100%,
    lorem(30)
  )
][
  #block(
    inset: 1em,
    outset: 0pt,
    fill: rgb("#555555"),
    width:100%,
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
```

![university theme screenshot](./university.png)
