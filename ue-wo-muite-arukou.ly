\version "2.20.0"

\include "lilypond-shamisen/shamisen.ly"

#(set-global-staff-size 36)

\paper{
  indent = 0\mm
  markup-system-spacing.padding = 2
  system-system-spacing.padding = 2
  #(define fonts
    (set-global-fonts
     #:roman "IPAexGothic"
     #:factor (/ staff-height pt 20) ; unnecessary if the staff size is default
    ))
}

\header {
  title = "上を向いて歩こう"
  pdfcomposer = "中村八大"
  pdfpoet = "永六輔"
  composer = \markup \left-column {
    \concat { "作曲　" \fromproperty #'header:pdfcomposer }
    \concat { "作詞　" \fromproperty #'header:pdfpoet }
  }
  author = \markup \fromproperty #'header:pdfcomposer
  meter = "4/4 二上がり"
  tagline = ##f
  subject = \markup \concat {
    "Shamisen partition for “"
    \fromproperty #'header:title
    "” by "
    \fromproperty #'header:pdfcomposer
    "."
  }
  keywords = #(string-join '(
    "music"
    "partition"
    "shamisen"
  ) ", ")
}

main = {
  % Hide the tuplet brackets
  % \omit TupletBracket
  % \omit TupletNumber

  % Hide the time signatures
  \omit Staff.TimeSignature

  \time 5/4
  r c' c' d' e' |
  \time 4/4
  e' c' g a |
  r c' r d' |
  e' c' g a |
  r c' c' d' |
  <g e'> r e' g' |
  a' r a' g' |
  \time 5/4
  a' g' e' d' d'\sukui |
  r c' c'\sukui c' a |
  \time 4/4
  d' r2 s4 |
  d'4 r d' c' |
  e' r2 s4 |
  c'4 c' r a' |
  g' e' c' a |
  <g c'> q r2 |
}

song = {
  \shamisenNotation
  \set TabStaff.tablatureFormat = #(custom-tab-format tsugaru-signs-ascii)

  \time 4/4

  r2 g4 a |
  c' r c' d' |
  e' c' c' e' |
  g' r2 g'4 |
  g' f' e' d' |

  \break

  \repeat volta 2 \main

  \break

  f'4 f' f' g' |
  a' r f' a' |
  g' r g' e' |
  g' r2 s4 |
  f'4 f' f' g' |
  aes' r f' aes' |
  g' r e' g' |
  d' r2 s4 |

  \break

  \main

  c'4 c' r a' |
  g' e' c' a |
  <g c'> q2 s4 |
}

verse = \lyricmode {
  上 _ を 向 い て 歩 _ こ う
}

\layout {
  \context {
    \Staff
    \omit TextScript
  }
  \context {
    \Score
    \omit BarNumber
  }
}

\book {
  \paper {
    system-system-spacing =
      #'((basic-distance . 5)
         (minimum-distance . 6)
         (padding . 2)
         (stretchability . 12))
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
      % \addlyrics \verse
    >>
  }

  \score {
    \unfoldRepeats \song
    \midi {
      \tempo 4 = 146
      midiInstrument = "shamisen"
    }
  }
}

\book {
  \bookOutputSuffix "score"

  \header {
    pdftitle = \markup \concat { \fromproperty #'header:title " (Score)" }
  }

  \new StaffGroup <<
    \new Staff {
      \clef "treble_8"
      \numericTimeSignature
      \stripShamisenArticulations \song
    }
    % \addlyrics \verse
    \new TabStaff \with {
      stringTunings = #niagariTuning
    } {
      \song
    }
  >>
}
