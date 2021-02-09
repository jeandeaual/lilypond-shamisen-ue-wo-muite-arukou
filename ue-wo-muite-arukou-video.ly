\version "2.20.0"

\include "ue-wo-muite-arukou.ily"

\score {
  \new StaffGroup <<
    \new Staff {
      \clef "treble_8"
      \numericTimeSignature
      \stripShamisenArticulations \song
      \bar "|."
    }
    \addlyrics \verseUnfolded
    \new TabStaff \with {
      stringTunings = #niagariTuning
    } {
      \unfoldRepeats \song
    }
  >>
  \layout {}
  \midi {
    \tempo 4 = 146
    midiInstrument = "shamisen"
  }
}
