#!/usr/bin/env perl

## This script is modified from ucscGenomeBrowser/kent (https://github.com/ucscGenomeBrowser/kent/blob/master/src/utils/pslScore/pslScore.pl). It is used to calculate sequence similarity of alignments in sliding windows of 100kb. 
#
#  pslScore.pl - a reproduction of the C library calculations from
#                src/lib/psl.c
#

#use strict;
use warnings;

my $argc = scalar(@ARGV);

# is psl a protein psl (are it's blockSizes and scores in protein space)
# 1 == not protein, return 3 == protein
sub pslCalcMilliBad($$$$$$$$$$$) {
my ($sizeMul, $qEnd, $qStart, $tEnd, $tStart, $qNumInsert, $tNumInsert, $matches, $repMatches, $misMatches, $isMrna) = @_;
my $milliBad = 0;
my $qAliSize =  ($qEnd - $qStart);
my $tAliSize = $tEnd - $tStart;
my $aliSize = $qAliSize;
$aliSize = $tAliSize if ($tAliSize < $qAliSize);
if ($aliSize <= 0) {
  return $milliBad;
}
my $sizeDif = $qAliSize - $tAliSize;
if ($sizeDif < 0) {
  if ($isMrna) {
      $sizeDif = 0;
  } else {
      $sizeDif = -$sizeDif;
  }
}
my $insertFactor = $qNumInsert;
if (0 == $isMrna) {
  $insertFactor += $tNumInsert;
}
my $total = (1 * ($matches + $repMatches + $misMatches));
if ($total != 0) {
  my $roundAwayFromZero = 3*log(1+$sizeDif);
  if ($roundAwayFromZero < 0) {
    $roundAwayFromZero = int($roundAwayFromZero - 0.5);
  } else {
    $roundAwayFromZero = int($roundAwayFromZero + 0.5);
  }
  $milliBad = (1000 * ($misMatches  + $insertFactor + $roundAwayFromZero)) / $total;

$mis2=($misMatches  + $insertFactor + $roundAwayFromZero);
$total2=$total;
}
#return $milliBad;
return ($mis2,$total2);
} # sub pslCalcMilliBad()

my $w=0; my $winSize=100000;
while (my $file = shift) {
  if ($file =~ m/.gz$/) {
    open (FH, "zcat $file|") or die "can not read $file";
  } else {
    open (FH, "<$file") or die "can not read $file";
  }
  while (my $line = <FH>) {
    next if ($line =~ m/^#/);
    chomp $line;
    
    my ($matches, $misMatches, $repMatches, $nCount, $qNumInsert, $qBaseInsert, $tNumInsert, $tBaseInsert, $strand, $qName, $qSize, $qStart, $qEnd, $tName, $tSize, $tStart, $tEnd) = (split('\t', $line))[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
    my $sizeMul=1;
    $w=int($tStart / $winSize) ;

    my @winOut = pslCalcMilliBad($sizeMul, $qEnd, $qStart, $tEnd, $tStart, $qNumInsert, $tNumInsert, $matches, $repMatches, $misMatches, 1);
    $misAll{$w}+=$winOut[0];
    $totalAll{$w}+=$winOut[1];

  }
  close (FH);
}
	foreach  $winSaved (keys %misAll )
		{print $winSaved,"\t",$winSaved*$winSize,"\t",$misAll{$winSaved},"\t",$totalAll{$winSaved},   "\n";}

