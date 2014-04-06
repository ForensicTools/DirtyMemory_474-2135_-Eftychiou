#!/usr/bin/perl
use strict;
use warnings;
	
my $choice= 0;
my $memory= '';
my $tool= '';
my $database="dirtyDatabase.txt";

while(1)
{
	&Start;
	

	if($choice == 1){
		&ProcessMemory;
	}
	elsif($choice  == 2){
	
		while(1)
		{
			&Settings;
	
			if($choice == 1){
			
				&PrintDatabase;
			}
			elsif($choice  == 2){
				#UpdateDatabase();
			}
			elsif($choice  == 3){
				#SearchDatabase();
			}
			elsif($choice  == 4){
				last;
			}
		}
	}

	
}

sub ExecutePS {

    my @split_line=();

     print "Please be patient, this may take a few minutes. \n";
    open(PS, "strings $memory | grep 'bank' |") or die("Sorry! We were not able to analyse $memory \n");

    foreach my $line (<PS>) {

	print "$line\n";
    }
    close(PS);
    print "Memory analysis completed succesfully.\n";

}


sub Start {	

    print "\n";
    print "Please select your choice by number (1-2).\n";
    print "1. Process Memory\n";
    print "2. Settings\n";
    print "\n";		
    print "Choice>";
    chomp($choice = <STDIN>);

}


sub ProcessMemory {

   print "Enter a memory image you wish to analyse: ";
   chomp($memory = <STDIN>);	
	
   ExecutePS();
} 


sub Settings {	
    print "\n";
    print "Please select your choice by number (1-4).\n";	
    print "1. Print Dirty Database\n";
    print "2. Update Dirty Database\n";
    print "3. Search Dirty Database\n";
    print "4. Back to Start\n";
    print "\n";		
    print "Choice>";
    chomp($choice = <STDIN>);

} 

sub PrintDatabase {
	open IN, $database or die "Cannot read: $!\n";

	while( my $line = <IN> ) 
	{
   		print "hello $line\n";
	}

} 

