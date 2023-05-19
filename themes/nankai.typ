// =========================================
// Nankai University theme for Typst slides.
// Made By SesameMan.
// https://github.com/sesameman/typst-slides-nankai
// =========================================

#import "../slides.typ": *

#let heiti = ("Times New Roman", "Heiti SC", "Heiti TC", "SimHei")
#let songti = ("Times New Roman", "Songti SC", "Songti TC", "SimSun")
#let zhongsong = ("Times New Roman", "STZhongsong", "SimSun")
#let kaiti = ("Times New Roman", "Kaiti SC")
#set text(font: songti)

#let nankai-theme(
    mail: "yourmail@mail.nankai.edu.cn",
    college: "计算机学院",
    usage: "毕业答辩",
    color: rgb("#711A5F"), 
    biglogo: "nk-image/nankai.png", 
    watermark: "nk-image/nankai-10.png", 
    logo: "nk-image/nankai-white.png",
    nkutext: "nk-image/nku-text.png",
    ) = data => {
    let title-slide(slide-info, bodies) = {
     	place(dx: 50%,
        dy: -13%,
        image(watermark, height: 510pt)
        )
        place(dx: 0.4em+80pt+0.4em,
        dy: 0.4em,
        image(nkutext, height: 80pt)
        )
        place(dx: 0.4em,
        dy: 0.4em,
        image(biglogo, height: 80pt)
        )
        v(82pt)
        align(center + horizon)[
            #block(
                stroke: (y: 1mm + rgb("#711A5F"), x: 1mm + rgb("#711A5F")),
                inset: 1em,
                breakable: false,
                fill: rgb("#E4E5EA"),
                radius: 15pt,
                [
                    #box()[#text(1.3em)[*#data.title*] \
                    #{
                        if data.subtitle != none {
                            parbreak()  
                            text(.9em)[#data.subtitle]
                        }
                    }
                    ]
                ]
            )
            // #h(1fr)
            #set text(size: 1em)
            #grid(
                columns: (1fr,) * calc.min(data.authors.len(), 3),
                column-gutter: 1em,
                row-gutter: 1em,
                ..data.authors
            )
            #block(
                stroke: (left: 2mm + rgb("#711A5F")),
                inset: 0.4em,
                breakable: false,
                align(left)[
            #if bodies.len() > 1 {
                panic("title slide of default theme does not support too many bodies")
            } else if bodies.len() == 1 {
                let body = bodies.first()
                text(size: 1em, body)
            }
                ]
            )            
            #parbreak()
            #text(0.8em)[#data.date]
            #v(15fr)
        ]
    }
    // globe font setting

    // Next Pages
    let displayed-title(slide-info) = if "title" in slide-info {
        text(fill: rgb("#fafafa"), slide-info.title)
        } else {
        []
    }
    let decoration(position, body) = {
        let border =  color
        let strokes = (
            header: ( bottom: border ),
            footer: ( top: border )
        )
        block(
            stroke: none,
            width: 100%,
            height: 1em,
            fill: color,
            outset: 0em, inset: 0em, breakable: false,
            align(left + horizon)[#h(0.2em) 
            #box[
            #box(image(logo, width: .8em))]
                #text(fill: rgb("#fafafa"), 0.5em,body
                )
            ]
        )
    }
    let default(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("default variant of default theme only supports one body per slide")
        }
        let body = bodies.first()
     	place(dx: 50%,
        dy: -13%,
        image(watermark, height: 510pt)
        )

        // header
        decoration("header", section.display() + h(1fr) +displayed-title(slide-info)+ h(1fr)+ data.date +h(1em)+ usage + h(1em))

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
            text(size: 0.8em)[#body]
        )
        v(2fr)

        // footer
        decoration("footer")[
            #h(1em)
            #data.short-authors #h(4em)
            #mail #h(4em)
            #college #h(1fr)
            #text(1.5em)[#logical-slide.display()] #h(1em)
        ]
    }

    let wake-up(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("wake up variant of default theme only supports one body per slide")
        }
        let body = bodies.first()
        v(0em)
        // block(
        //     width: 100%, inset: (x: 2em), breakable: false, outset: 0em,
        //     text(size: 1.5em, fill: white, {v(1fr); body; v(1fr);})
        // )
        block(
            width: 100%, height: 100%-1em,inset: 2em, breakable: false, outset: 0em,
            fill: color,
            text(size: 1.5em, fill: white, {v(1fr); body; v(1fr);})
        )
        v(1fr)
        decoration("footer")[
            #h(1fr)#text(1.5em)[#logical-slide.display()] #h(1em)
        ]
    }

    (
        "title slide": title-slide,
        "default": default,
        "wake up": wake-up,
    )
}