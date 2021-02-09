\version "2.20.0"

\include "lilypond-shamisen/shamisen.ly"

first = \markup {
  \override #'(font-name . "Libertinus Serif")
  \fontsize #-3
  \typewriter
  " Ⅰ"
}
second = \markup {
  \override #'(font-name . "Libertinus Serif")
  \fontsize #-3
  \typewriter
  " Ⅱ"
}
third  = \markup {
  \override #'(font-name . "Libertinus Serif")
  \fontsize #-3
  \typewriter
  " Ⅲ"
}

#(set-global-staff-size 36)

\paper{
  indent = 0\mm
  markup-system-spacing.padding = 3
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
  author = "坂本九"
  composer = \markup \left-column {
    \concat { "作曲　" \fromproperty #'header:pdfcomposer }
    \concat { "作詞　" \fromproperty #'header:pdfpoet }
    \concat { "　歌　" \fromproperty #'header:author }
  }
  meter = "二上がり"
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
  % Hide the time signatures
  \omit Staff.TimeSignature

  \time 5/4
  r c' c' d' e' |
  \time 4/4
  e' c' g a |
  r c' r d' |
  e' c' g a |
  \break
  r c' c' d' |
  <g e'> r e' g' |
  a' r a' g' |
  \time 5/4
  a' g' e' d' d'\sukui |
  r c' c'\sukui c' a |
  \time 4/4
  % TODO: Replace with d'2 r when the spacing bug gets fixed
  d' r2 s4 |
  d'4 r d' c' |
  % TODO: Replace with e'2 r when the spacing bug gets fixed
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
  % TODO: Replace with g'2 r when the spacing bug gets fixed
  g' r2 s4 |
  f'4 f' f' g' |
  aes' r f' aes' |
  g' r e' g' |
  % TODO: Replace with d'2 r when the spacing bug gets fixed
  d' r2 s4 |

  \break

  \main

  c'4 c' r a' |
  g' e' c' a |
  <g c'> q2 s4 |
}

verse = \lyricmode {
  \repeat unfold 15 \skip 1

  う え を む _ い て _ あ る こ う _ _
  な み だ が こ ぼ れ な い よ う _ _ に
  お も い だ す は る の ひ
  ひ と り ぼ っ ち の よ る

  し あ わ せ は く も の う え に
  し あ わ せ は そ ら の う え に

  う え を む _ い て _ あ る こ う _ _
  な み だ が こ ぼ れ な い よ う _ _ に
  な き な が ら あ _ る く

  ひ と り ぼ っ ち の よ る
  ひ と り ぼ っ ち の よ る
}

verseVolta = \lyricmode {
  \repeat unfold 29 \skip 1
  に じ ん だ ほ し を か ぞ え _ _ _ て
  \repeat unfold 5 \skip 1
  な つ
}

verseUnfolded = \lyricmode {
  \repeat unfold 15 \skip 1
  う え を む _ い て _ あ る こ う _ _
  な み だ が こ ぼ れ な い よ う _ _ に
  お も い だ す は る の ひ
  ひ と り ぼ っ ち の よ る

  う え を む _ い て _ あ る こ う _ _
  に じ ん だ ほ し を か ぞ え _ _ _ て
  お も い だ す な つ の ひ
  ひ と り ぼ っ ち の よ る

  し あ わ せ は く も の う え に
  し あ わ せ は そ ら の う え に

  う え を む _ い て _ あ る こ う _ _
  な み だ が こ ぼ れ な い よ う _ _ に
  な き な が ら あ _ る く

  ひ と り ぼ っ ち の よ る
  ひ と り ぼ っ ち の よ る
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
    \unfoldRepeats \song
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
         (padding . 3)
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
