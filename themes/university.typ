#import "../slides.typ": *

// University theme
//
// By Pol Dellaiera - https://github.com/drupol
//
// Please feel free to improve this theme
// by submitting a PR in https://github.com/andreasKroepelin/typst-slides
//
#let university-theme(
    institution-name: "University",
    color-a: rgb("#0C6291"),
    color-b: rgb("#A63446"),
    color-c: rgb("#FBFEF9"),
    logo: none,
    progress-bar: true
) = data => {
    let color-title = color-a
    let color-subtitle = color-a
    let color-section = color-a.lighten(85%)
    let color-authors = black

    let color-footer-fill-short-authors = color-a
    let color-footer-fill-short-title = color-b
    let color-footer-fill-date = color-b
    let color-footer-fill-slide-counter = color-b

    let color-footer-short-authors = white
    let color-footer-short-title = white
    let color-footer-date = white
    let color-footer-slide-counter = white

    let last-slide-number = locate(loc => logical-slide.final(loc).first())

    let title-slide(slide-info, bodies) = {
        if logo != none {
            align(right)[
                #logo
            ]
        }
        align(center + horizon)[
            #block(
                inset: 0em,
                breakable: false,
                [
                    #text(2em, color-a)[*#data.title*] \
                    #{
                        if data.subtitle != none {
                            parbreak()
                            text(1.2em, color-subtitle)[#data.subtitle]
                        }
                    }
                ]
            )
            #set text(size: .8em)
            #grid(
                columns: (1fr,) * calc.min(data.authors.len(), 3),
                column-gutter: 1em,
                row-gutter: 1em,
                ..data.authors.map(author => text(color-authors)[#author])
            )
            #v(1em)
            #{
                parbreak()
                text(.9em)[#institution-name]
            }
            #{
                parbreak()
                text(.8em)[#data.date]
            }
        ]
    }

    let default(slide-info, bodies) = {
        if not "columns" in slide-info {
            slide-info.columns = (1fr, ) * bodies.len()
        }

        let header() = {
            let cell = rect.with(
                width: 100%,
                stroke: none,
                outset: 0mm
            )
            if "header" in slide-info {
                slide-info.header
            } else {
                if "title" in slide-info {
                    block(fill: color-c.lighten(90%))[
                        #grid(
                            columns: (60%, 40%),
                            cell[
                                #heading(level: 3, text(color-title)[#slide-info.title])
                            ],
                            cell[
                                #align(right)[
                                    #heading(level: 2, text(color-section)[#section.display()])
                                ]
                            ]
                        )
                    ]
                }
            }
        }

        let footer() = {
            set text(
                size: 10pt
            )
            set align(center)
            let cell = rect.with(
                width: 100%,
                inset: 1mm,
                outset: 0mm
            )
            if "footer" in slide-info {
                slide-info.footer
            } else {
                grid(
                    columns: (25%, 1fr, 15%, 10%),
                    rows: (5mm, auto),
                    cell(
                        height: 100%,
                        fill: color-footer-fill-short-authors
                    )[#text(color-footer-short-authors)[
                        #if "short-authors" in slide-info {
                            slide-info.short-authors
                        } else {
                            data.short-authors
                        }
                    ]],
                    cell(
                        height: 100%,
                        fill: color-footer-fill-short-title
                    )[#text(color-footer-short-title)[
                        #if "short-title" in slide-info {
                            slide-info.short-title
                        } else {
                            data.short-title
                        }
                    ]],
                    cell(
                        height: 100%,
                        fill: color-footer-fill-date
                    )[#text(color-footer-date)[
                        #if "date" in slide-info {
                            slide-info.date
                        } else {
                            data.date
                        }
                    ]],
                    cell(
                        height: 100%,
                        fill: color-footer-fill-slide-counter
                    )[#text(color-footer-slide-counter)[#logical-slide.display() / #last-slide-number]]
                )
            }
        }


        let progress-barline() = locate(loc => {
            if (progress-bar == true) {
                let cell = block.with(
                    width:100%,
                    height:100%,
                    above:0pt,
                    below:0pt,
                    breakable:false
                )

                let filled = counter("logical-slide").at(loc).first() / counter("logical-slide").final(loc).first()*100%
                grid(rows: 2pt, columns: (filled,1fr),cell(fill:color-a),cell(fill:color-b))
            } else {
                none
            }
        })

        grid(
            gutter: 0pt,
            rows: (auto, auto, 1fr, auto),
            progress-barline(),
            header(),
            grid(
                gutter: 0pt,
                columns: (1fr,) * bodies.len(),
                ..bodies.map(body => {
                    set align(horizon)
                    block(height: 100%, body)
                })
            ),
            footer()
        )
    }

    let wake-up(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("wake-up variant of university theme only supports one body per slide")
        }

        if not "inset" in slide-info {
            slide-info.inset = 2em
        }

        if not "fill" in slide-info {
            slide-info.fill = none
        }

        if "background" in slide-info {
            place(center+horizon)[
                #image(
                    slide-info.background,
                    fit: "stretch",
                    width: 100%,
                    height: 100%
                )
            ]
        }

        let body = bodies.first()

        block(
            width: 100%,
            height: 100%,
            inset: slide-info.inset,
            breakable: false,
            outset: 0em,
            fill: slide-info.fill,
            text(size: 2em, fill: white, {v(1fr); body; v(1fr)})
        )
    }

    let split-v(slide-info, bodies) = {
        if not "columns" in slide-info {
            slide-info.columns = (1fr, ) * bodies.len()
        }

        if not "fill" in slide-info {
            slide-info.fill = none
        }

        if "background" in slide-info {
            place(center+horizon)[
                #image(
                    slide-info.background,
                    fit: "stretch",
                    width: 100%,
                    height: 100%
                )
            ]
        }

        box(
            fill: slide-info.fill
        )[
            #grid(
                columns: slide-info.columns,
                ..bodies.map(body => {
                    set align(horizon)
                    block(height: 100%, body)
                })
            )
        ]
    }

    let split-h(slide-info, bodies) = {
        if not "rows" in slide-info {
            slide-info.rows = (1fr,) * bodies.len()
        }

        if not "fill" in slide-info {
            slide-info.fill = none
        }

        if "background" in slide-info {
            place(center+horizon)[
                #image(
                    slide-info.background,
                    fit: "stretch",
                    width: 100%,
                    height: 100%
                )
            ]
        }

        box(
            fill: slide-info.fill
        )[
            #grid(
                rows: slide-info.rows,
                ..bodies
            )
        ]
    }

    let split-matrix(slide-info, bodies) = {
        if not "fill" in slide-info {
            slide-info.fill = none
        }

        if "background" in slide-info {
            place(center+horizon)[
                #image(
                    slide-info.background,
                    fit: "stretch",
                    width: 100%,
                    height: 100%
                )
            ]
        }

        let grid-box = box.with(
            width: 100%,
            height: 100%,
            outset: 0em,
            inset: (x: 0em),
            baseline: 0em,
            stroke: none,
        )

        box(
            fill: slide-info.fill
        )[
            #grid(
                columns: (1fr,) * int(calc.sqrt(bodies.len())),
                rows: (1fr,)  * int(calc.sqrt(bodies.len())),
                ..range(0, bodies.len()).map(i => grid-box(bodies.at(i)))
            )
        ]
    }

    (
        "title slide": title-slide,
        "default": default,
        "wake up": wake-up,
        "split h": split-h,
        "split v": split-v,
        "split matrix": split-matrix
    )
}
