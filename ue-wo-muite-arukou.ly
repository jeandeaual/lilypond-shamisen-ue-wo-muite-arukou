\version "2.20.0"

\include "ue-wo-muite-arukou.ily"

\book {
  \header {
    pdftitle = \markup \concat { \fromproperty #'header:title "（楽譜）" }
    meter = \markup \left-column {
      "4本（神仙）"
      "二上り（調弦 C G C）"
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

\book {
  \bookOutputSuffix "tab"

  \paper {
    system-system-spacing =
      #'((basic-distance . 5)
         (minimum-distance . 6)
         (padding . 2)
         (stretchability . 12))
  }

  \header {
    pdftitle = \markup \fromproperty #'header:title
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

  \paper {
    system-system-spacing =
      #'((basic-distance . 5)
         (minimum-distance . 6)
         (padding . 2)
         (stretchability . 12))
  }

  \header {
    pdftitle = \markup \fromproperty #'header:title
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
