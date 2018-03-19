use warnings;
use strict;
open(FASTA,"<$ARGV[0]") or die "can not open $ARGV[0]";
open(OUT,">$ARGV[1]") or die "can not open $ARGV[1]";
my %database;
my @seq_t=("A","T","G","C");
for(my $i=0;$i<4;$i++){
	for(my $j=0;$j<4;$j++){
		for(my $k=0;$k<4;$k++){
			for(my $m=0;$m<4;$m++){
				my $a="$seq_t[$i]"."$seq_t[$j]"."$seq_t[$k]"."$seq_t[$m]";
				#print "$a\n";
				$database{$a}=0;
			}
		}
	}
}
while(my $temp=<FASTA>){
	if($temp=~/>/){
		next;
	}
	chomp($temp);
	my @seq=split //, $temp;
	my $number=@seq;
	for(my $n=0;$n<=$number-4;$n++){
		my $h="$seq[$n]"."$seq[$n+1]"."$seq[$n+2]"."$seq[$n+3]";
		if(defined($database{$h})){
			$database{$h}++;
		}else{
			next;
		}
	
	}
	$temp=~tr/(A)(T)(G)(C)/(T)(A)(C)(G)/;
	$temp=reverse($temp);
	my @seq_r=split //, $temp;
	my $number_r=@seq_r;
	for(my $n=0;$n<=$number_r-4;$n++){
		my $h="$seq_r[$n]"."$seq_r[$n+1]"."$seq_r[$n+2]"."$seq_r[$n+3]";
		if(defined($database{$h})){
			$database{$h}++;
		}else{
			next;
		}
	}	
}
while(my($key,$value)=each %database){
	print OUT "$key\t$value\n";
}