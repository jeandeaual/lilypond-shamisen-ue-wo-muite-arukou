\version "2.20.0"

\include "ue-wo-muite-arukou.ily"

\book {
  \header {
    pdftitle = \markup \concat { \scoreTitle "（五線譜付き）" }
    meter = \markup {
      \override #'(baseline-skip . 3)
      \left-column {
        "4本（神仙）"
        \concat { \scoreMeter "（調弦 C G C）" }
      }
    }
  }

  \score {
    \new StaffGroup <<
      \new Staff {
        \clef "treble_8"
        \numericTimeSignature
        \stripShamisenArticulations \song
        \bar "|."
      }
      \addlyrics \verse
      \addlyrics \verseVolta
      \new TabStaff \with {
        stringTunings = #niagariTuning
      } {
        \song
      }
    >>
    \layout {}
  }

  \score {
    \unfoldRepeats \articulate \song
    \midi {
      \tempo 4 = 146
      midiInstrument = "shamisen"
    }
  }
}

#(set-global-staff-size 40)

\paper {
  indent = 0\mm
  markup-system-spacing.padding = 1
  system-system-spacing =
    #'((basic-distance . 3)
       (minimum-distance . 3)
       (padding . 1)
       (stretchability . 12))
  #(define fonts
    (set-global-fonts
     #:roman "IPAexGothic"
     #:factor (/ staff-height pt 20) ; unnecessary if the staff size is default
    ))
  oddHeaderMarkup = \markup \fill-line { " " \fontsize #0 \on-the-fly #not-first-page \fromproperty #'page:page-number-string }
  evenHeaderMarkup = \markup \fill-line { \fontsize #0 \on-the-fly #not-first-page \fromproperty #'page:page-number-string " " }
}

\layout {
  \context {
    \Score
    \override LyricText #'font-size = #-1
  }
}

\book {
  \bookOutputSuffix "tab"

  \header {
    title = \markup {
      \fontsize #-3.5
      \scoreTitle
    }
    composer = \markup {
      \override #'(baseline-skip . 3)
      \fontsize #-3.5 \left-column {
        \concat { "作曲　" \fromproperty #'header:pdfcomposer }
        \concat { "作詞　" \fromproperty #'header:pdfpoet }
        \concat { "　歌　" \fromproperty #'header:author }
      }
    }
    meter = \markup \fontsize #-3.5 \scoreMeter
  }

  \score {
    \new StaffGroup <<
      % Display the system start bar even with a single staff
      % Score.SystemStartBar.collapse-height needs to be lower than the number
      % of staff lines
      \override Score.SystemStartBar.collapse-height = #2
      \new TabStaff \with {
        stringTunings = #niagariTuning
      } {
        \song
      }
    >>
  }
}

\book {
  \bookOutputSuffix "lyrics-tab"

  \header {
    pdftitle = \markup \concat { \scoreTitle "（歌詞付き）" }
  }

  \score {
    \new StaffGroup <<
      % Display the system start bar even with a single staff
      % Score.SystemStartBar.collapse-height needs to be lower than the number
      % of staff lines
      \override Score.SystemStartBar.collapse-height = #2
      \new TabStaff \with {
        stringTunings = #niagariTuning
      } {
        \song
      }
      \addlyrics \verse
      \addlyrics \verseVolta
    >>
  }
}
