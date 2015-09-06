#!/usr/bin/perl


#video1/last_01-20150831160700-00.jpg
#Left_angle(s):     167.91    174.09
#Right_angle(s):     43.45     36.47     40.82

my $minAngle =  30;
my $maxAngle = 250;

sub ang2psi_low {
  my $a = shift;
  return 0 if($a<0);

  my $psi = (270-$a)*(40/180);

  $psi = $psi <  0 ? 0 : $psi;
  $psi = $psi > 40 ? 0 : $psi;
  return $psi;
}

sub ang2psi_high {
  my $a = shift;
  return 0 if($a<0);

  my $psi = (210-$a)*(2500/180);
  $psi = $psi <  0 ? 0 : $psi;
  $psi = $psi > 2600 ? 0 : $psi;
  return $psi;

}

while(<>) {
  chomp;
  if(/last_(\d+)-(\d+)-(\d+)\.jpg$/) {
    my $ts = $2;
    my $angLeft  = -1;
    my $angRight = -1;

    while(<>) {
      last if(/^\s*$/);

      my @f = split;
      $side=shift(@f);

      my $angle=0;
      my $angle_count=0;
      foreach my $a (@f) {
        if( $a > $minAngle && $a < $maxAngle) {
          $angle += $a;
          $angle_count++;
        }
      }
      if($angle_count > 0) {
        $angle /= $angle_count;
      } else {
        $angle = -1;
      }

      if( $side =~ /left/i )  {
        $angleLeft  = $angle;
      }
      if( $side =~ /right/i ) {
        $angleRight = $angle;
      }
    }
    printf("%d  %8.0f  %8.0f\n", $ts, 10*ang2psi_low( $angleLeft), ang2psi_high($angleRight));
  }
}
