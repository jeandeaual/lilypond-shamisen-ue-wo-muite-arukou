\version "2.20.0"

\include "articulate.ly"
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

#(set-global-staff-size 32)

\paper {
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
  r c'^\first c' d'^\first e'^\third |
  \time 4/4
  e' c' g a |
  r c' r d' |
  e' c' g a |
  \break
  r c'^\first c' d'^\first |
  <g e'>^\first r e' g'^\first |
  a'^\third r a' g'^\first |
  \time 5/4
  a'^\third g'^\first e' d' d'\sukui |
  r c' c'\sukui c' a |
  \time 4/4
  % TODO: Replace with d'2 r when the spacing bug gets fixed
  d' r2 s4 |
  d'4 r d' c' |
  % TODO: Replace with e'2 r when the spacing bug gets fixed
  e' r2 s4 |
  c'4 c' r a'^\third |
  g'^\first e'^\first c' a |
  <g c'> q r2 |
}

song = {
  \shamisenNotation
  \set TabStaff.tablatureFormat = #(custom-tab-format tsugaru-signs-with-sharps-and-flats)

  \time 4/4

  r2 g4 a |
  c'^\first r c' d'^\first |
  e'^\third c'^\first c' e'^\first |
  g'^\third r2 g'4 |
  g' f' e' d' |

  \break

  \repeat volta 2 \main

  \break

  f'4^\first f' f' g'^\first |
  a'^\third r f'^\first a'^\third |
  g'^\first r g' e'^\first |
  % TODO: Replace with g'2 r when the spacing bug gets fixed
  g'^\third r2 s4 |
  f'4^\first f' f' g'^\first |
  aes'^\second r f'^\first aes'^\second |
  g'^\first r e'^\first g'^\third |
  % TODO: Replace with d'2 r when the spacing bug gets fixed
  d'^\first r2 s4 |

  \break

  \main

  c'4 c' r a'^\third |
  g'^\first e'^\first c' a |
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
