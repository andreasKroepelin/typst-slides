// ==============================
// ======== GLOBAL STATE ========
// ==============================

#let section = state("section", "")
#let subslide = counter("subslide")
#let logical-slide = counter("logical-slide")
#let repetitions = counter("repetitions")
#let global-theme = state("global-theme", none)
#let handout-mode = state("handout-mode", false)

#let new-section(name) = section.update(name)

// =================================
// ======== DYNAMIC CONTENT ========
// =================================

#let _slides-cover(mode, body) = {
    if mode == "invisible" {
        hide(body)
    } else if mode == "transparent" {
        text(gray.lighten(50%), body)
    } else {
        panic("Illegal cover mode: " + mode)
    }
}

#let _parse-subslide-indices(s) = {
    let parts = s.split(",").map(p => p.trim())
    let parse-part(part) = {
        let match-until = part.match(regex("^-([[:digit:]]+)$"))
        let match-beginning = part.match(regex("^([[:digit:]]+)-$"))
        let match-range = part.match(regex("^([[:digit:]]+)-([[:digit:]]+)$"))
        let match-single = part.match(regex("^([[:digit:]]+)$"))
        if match-until != none {
            let parsed = int(match-until.captures.first())
            // assert(parsed > 0, "parsed idx is non-positive")
            ( until: parsed )
        } else if match-beginning != none {
            let parsed = int(match-beginning.captures.first())
            // assert(parsed > 0, "parsed idx is non-positive")
            ( beginning: parsed )
        } else if match-range != none {
            let parsed-first = int(match-range.captures.first())
            let parsed-last = int(match-range.captures.last())
            // assert(parsed-first > 0, "parsed idx is non-positive")
            // assert(parsed-last > 0, "parsed idx is non-positive")
            ( beginning: parsed-first, until: parsed-last )
        } else if match-single != none {
            let parsed = int(match-single.captures.first())
            // assert(parsed > 0, "parsed idx is non-positive")
            parsed
        } else {
            panic("failed to parse visible slide idx:" + part)
        }
    }
    parts.map(parse-part)
}

#let _check-visible(idx, visible-subslides) = {
    if type(visible-subslides) == "integer" {
        idx == visible-subslides
    } else if type(visible-subslides) == "array" {
        visible-subslides.any(s => _check-visible(idx, s))
    } else if type(visible-subslides) == "string" {
        let parts = _parse-subslide-indices(visible-subslides)
        _check-visible(idx, parts)
    } else if type(visible-subslides) == "dictionary" {
        let lower-okay = if "beginning" in visible-subslides {
            visible-subslides.beginning <= idx
        } else {
            true
        }

        let upper-okay = if "until" in visible-subslides {
            visible-subslides.until >= idx
        } else {
            true
        }

        lower-okay and upper-okay
    } else {
        panic("you may only provide a single integer, an array of integers, or a string")
    }
}

#let _last-required-subslide(visible-subslides) = {
    if type(visible-subslides) == "integer" {
        visible-subslides
    } else if type(visible-subslides) == "array" {
        calc.max(..visible-subslides.map(s => _last-required-subslide(s)))
    } else if type(visible-subslides) == "string" {
        let parts = _parse-subslide-indices(visible-subslides)
        _last-required-subslide(parts)
    } else if type(visible-subslides) == "dictionary" {
        let last = 0
        if "beginning" in visible-subslides {
            last = calc.max(last, visible-subslides.beginning)
        }
        if "until" in visible-subslides {
            last = calc.max(last, visible-subslides.until)
        }
        last
    } else {
        panic("you may only provide a single integer, an array of integers, or a string")
    }
}

#let _conditional-display(visible-subslides, reserve-space, mode, body) = {
    locate( loc => {
        let vs = if reserve-space and handout-mode.at(loc) {
            (:)
        } else {
            visible-subslides
        }
        repetitions.update(rep => calc.max(rep, _last-required-subslide(vs)))
        if _check-visible(subslide.at(loc).first(), vs) {
            body
        } else if reserve-space {
            _slides-cover(mode, body)
        }
    })
}

#let uncover(visible-subslides, mode: "invisible", body) = {
    _conditional-display(visible-subslides, true, mode, body)
}

#let only(visible-subslides, body) = {
    _conditional-display(visible-subslides, false, "doesn't even matter", body)
}

#let one-by-one(start: 1, mode: "invisible", ..children) = {
    for (idx, child) in children.pos().enumerate() {
        uncover((beginning: start + idx), mode: mode, child)
    }
}

#let alternatives(start: 1, position: bottom + left, ..children) = {
    style(styles => {
        let sizes = children.pos().map(c => measure(c, styles))
        let max-width = calc.max(..sizes.map(sz => sz.width))
        let max-height = calc.max(..sizes.map(sz => sz.height))
        for (idx, child) in children.pos().enumerate() {
            only(start + idx, box(
                width: max-width,
                height: max-height,
                align(position, child)
            ))
        }
    })
}

#let line-by-line(start: 1, mode: "invisible", body) = {
    let items = if repr(body.func()) == "sequence" {
        body.children
    } else {
        ( body, )
    }

    let idx = start
    for item in items {
        if repr(item.func()) != "space" {
            uncover((beginning: idx), mode: mode, item)
            idx += 1
        } else {
            item
        }
    }
}

#let pause(beginning, mode: "invisible") = body => {
    uncover((beginning: beginning), mode: mode, body)
}


// ================================
// ======== SLIDE CREATION ========
// ================================

#let slide(
    max-repetitions: 10,
    theme-variant: "default",
    override-theme: none,
    ..args
) = {
    locate( loc => {
        if counter(page).at(loc).first() > 1 {
            pagebreak(weak: true)
        }
    })
    logical-slide.step()
    locate( loc => {
        subslide.update(1)
        repetitions.update(1)

        let slide-content = global-theme.at(loc).at(theme-variant)
        if override-theme != none {
            slide-content = override-theme
        }
        let slide-info = args.named()
        let bodies = args.pos()

        for _ in range(max-repetitions) {
            locate( loc-inner => {
                let curr-subslide = subslide.at(loc-inner).first()
                if curr-subslide <= repetitions.at(loc-inner).first() {
                    if curr-subslide > 1 { pagebreak(weak: true) }

                    slide-content(slide-info, bodies)
                }
            })
            subslide.step()
        }
    })
}

// ===============================
// ======== DEFAULT THEME ========
// ===============================

#let slides-default-theme(color: teal) = data => {
    let title-slide(slide-info, bodies) = {
        if bodies.len() != 0 {
            panic("title slide of default theme does not support any bodies")
        }

        align(center + horizon)[
            #block(
                stroke: ( y: 1mm + color ),
                inset: 1em,
                breakable: false,
                [
                    #text(1.3em)[*#data.title*] \
                    #{
                        if data.subtitle != none {
                            parbreak()
                            text(.9em)[#data.subtitle]
                        }
                    }
                ]
            )
            #set text(size: .8em)
            #grid(
                columns: (1fr,) * calc.min(data.authors.len(), 3),
                column-gutter: 1em,
                row-gutter: 1em,
                ..data.authors
            )
            #v(1em)
            #data.date
        ]
    }

    let default(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("default variant of default theme only supports one body per slide")
        }
        let body = bodies.first()

        let decoration(position, body) = {
            let border = 1mm + color
            let strokes = (
                header: ( bottom: border ),
                footer: ( top: border )
            )
            block(
                stroke: strokes.at(position),
                width: 100%,
                inset: .3em,
                text(.5em, [body])
            )
        }


        // header
        decoration("header", section.display())

        if "title" in slide-info {
            block(
                width: 100%, inset: (x: 2em), breakable: false,
                outset: 0em,
                heading(level: 1, slide-info.title)
            )
        }
        
        v(1fr)
        block(
            width: 100%, inset: (x: 2em), breakable: false, outset: 0em,
            body
        )
        v(2fr)

        // footer
        decoration("footer")[
            #data.short-authors #h(10fr)
            #data.short-title #h(1fr)
            #data.date #h(10fr)
            #logical-slide.display()
        ]
    }

    let wake-up(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("wake up variant of default theme only supports one body per slide")
        }
        let body = bodies.first()

        block(
            width: 100%, height: 100%, inset: 2em, breakable: false, outset: 0em,
            fill: color,
            text(size: 1.5em, fill: white, {v(1fr); body; v(1fr)})
        )
    }

    (
        "title slide": title-slide,
        "default": default,
        "wake up": wake-up,
    )
}

// ===================================
// ======== TEMPLATE FUNCTION ========
// ===================================

#let slides(
    title: none,
    authors: none,
    subtitle: none,
    short-title: none,
    short-authors: none,
    date: none,
    theme: slides-default-theme(),
    aspect-ratio: "16-9",
    handout: false,
    body
) = {

    set page(
        paper: "presentation-" + aspect-ratio,
        margin: 0pt,
    )

    let data = (
        title: title,
        authors: if type(authors) == "array" {
            authors
        } else if type(authors) in ("string", "content", "none") {
            (authors, )
        } else {
            panic("if not none, authors must be an array, string, or content.")
        },
        subtitle: subtitle,
        short-title: short-title,
        short-authors: short-authors,
        date: date,
    )
    let the-theme = theme(data)
    global-theme.update(the-theme)
    handout-mode.update(handout)

    set text(size: 25pt)

    body
}
