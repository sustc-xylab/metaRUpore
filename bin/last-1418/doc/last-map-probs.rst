last-map-probs
==============

This script reads alignments of DNA reads to a genome, and estimates
the probability that each alignment represents the genomic source of
the read.

It writes the alignments with "mismap" probabilities, i.e. the
probability that the alignment does not represent the genomic source
of the read.  By default, it discards alignments with mismap
probability > 0.01.

Typical usage
-------------

These commands map DNA reads to the human genome::

  lastdb -uNEAR hu human/chr*.fa
  lastal -Q1 -D1000 hu reads.fastq | last-map-probs > myalns.maf

Options
-------

-h, --help
       Show a help message, with default option values, and exit.

-m M, --mismap=M
       Don't write alignments with mismap probability > M.
       Low-confidence alignments will be discarded unless you
       increase this value!

-s S, --score=S
       Don't write alignments with score < S.  The default value is
       somewhat higher than the lastal score threshold.
       Specifically, it is e + t * ln(1000), where e is the score
       threshold, and t is a scale factor that is written in the
       lastal header.  This roughly means that, for every alignment
       it writes, it has considered alternative alignments with
       one-thousandth the probability.

Details
-------

* This script can read alignments in either of the formats produced by
  lastal (maf or tabular).

* The input must not mix alignments of different query sequences.  In
  other words, all the alignments of one query must be next to each
  other.

Limitations
-----------

* It is possible that two or more alignments reflect the origin of one
  query sequence, for instance if the query arose by splicing.  This
  script makes no allowance for that possibility.

Method
------

Suppose one query sequence has three alignments, with scores: s1, s2,
s3.  The probability that the first alignment is the one that reflects
the origin of the query, is::

        exp(s1/t) / [exp(s1/t) + exp(s2/t) + exp(s3/t)]

Here, t is a parameter that depends on the scoring scheme: it is
written in the lastal header.

Reference
---------

For more information, please see this article:

  Incorporating sequence quality data into alignment improves DNA read
  mapping.  Frith MC, Wan R, Horton P.  Nucleic Acids Research 2010
  38:e100.
